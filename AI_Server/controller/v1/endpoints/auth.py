from datetime import datetime, timedelta, timezone
import hashlib
import logging
import secrets
from fastapi import APIRouter, Depends, HTTPException, Request, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text

from schema.auth import (
    UserRegister, UserLogin, TokenResponse,
    RefreshRequest, ForgotPasswordRequest,
    ResetPasswordRequest, MessageResponse, AuthUser,
    ChangePasswordRequest
)

from config.security import (
    hash_password, verify_password,
    create_access_token, create_refresh_token, decode_token
)

from config import settings
from config.rate_limit import limiter, forgot_password_limit, login_limit, register_limit
from schema.users import User, UserRole, UserStatus
from db.session import get_db
from controller.v1.dependencies import get_current_user
from services.email_service import send_welcome_email, send_password_reset_email

log = logging.getLogger(__name__)

router = APIRouter(prefix="/auth", tags=["Auth"])


def _token_hash(value: str) -> str:
    return hashlib.sha256(value.encode("utf-8")).hexdigest()


async def _store_refresh_token(
    db: AsyncSession, user_id: int, jti: str, expires_at: datetime
):
    now = datetime.utcnow()
    await db.execute(
        text(
            """
            INSERT INTO RefreshTokens
                (user_id, token_hash, expires_at, created_at)
            VALUES (:user_id, :token_hash, :expires_at, :created_at)
            """
        ),
        {
            "user_id": user_id,
            "token_hash": _token_hash(jti),
            "expires_at": expires_at,
            "created_at": now,
        },
    )

# ====================== REGISTER ======================
@router.post("/register", response_model=TokenResponse, status_code=201)
@register_limit()  # Rate limit: 5 registrations per 5 minutes per IP
async def register(request: Request, data: UserRegister, db: AsyncSession = Depends(get_db)):
    registration_setting = await db.execute(
        text("SELECT setting_value FROM SystemSettings WHERE setting_key = 'registration_enabled'")
    )
    if registration_setting.scalar_one_or_none() in {"false", "0", "False"}:
        raise HTTPException(status_code=403, detail="Registration is currently disabled")

    # Check if email already exists
    email_check = await db.execute(
        text("SELECT id FROM Users WHERE email = :email"),
        {"email": data.email}
    )
    if email_check.scalar_one_or_none():
        raise HTTPException(status_code=400, detail="Email already registered")

    # Insert new user
    now = datetime.utcnow()
    await db.execute(
        text(
            """
            INSERT INTO Users
                (email, password_hash, full_name, role, status, created_at, updated_at)
            VALUES (:email, :password_hash, :full_name, :role, :status, :created_at, :updated_at)
            """
        ),
        {
            "email": data.email,
            "password_hash": hash_password(data.password),
            "full_name": data.full_name,
            "role": UserRole.USER.value,
            "status": UserStatus.ACTIVE.value,
            "created_at": now,
            "updated_at": now,
        },
    )

    # Get the inserted user ID
    user_id = int((await db.execute(text("SELECT LAST_INSERT_ID()"))).scalar_one())

    # Create credit wallet
    await db.execute(
        text("INSERT INTO CreditWallets (user_id, balance, updated_at) VALUES (:user_id, :balance, :updated_at)"),
        {"user_id": user_id, "balance": 10, "updated_at": now},
    )

    # Issue the token pair in the same response so the client lands on
    # the home screen already signed in — same contract as /auth/login.
    access_token = create_access_token(user_id)
    refresh_token, jti = create_refresh_token(user_id)
    await _store_refresh_token(
        db,
        user_id,
        jti,
        datetime.utcnow() + timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS),
    )
    await db.commit()

    # Fire-and-forget welcome email. We intentionally do NOT await this
    # against the SMTP server: a slow / misconfigured mail server must
    # not extend the perceived registration latency. Failures are logged
    # inside the email service for ops to pick up.
    welcome = send_welcome_email(data.email, data.full_name)
    if not welcome.success:
        log.info(
            "welcome email deferred for user_id=%s reason=%s",
            user_id,
            welcome.detail,
        )

    return TokenResponse(
        access_token=access_token,
        refresh_token=refresh_token,
        expires_in=settings.ACCESS_TOKEN_EXPIRE_MINUTES * 60,
        user=AuthUser(
            id=user_id,
            email=data.email,
            full_name=data.full_name,
            role=UserRole.USER.value,
            status=UserStatus.ACTIVE.value,
        ),
    )

# ====================== LOGIN ======================
@router.post("/login", response_model=TokenResponse)
@login_limit()  # Rate limit: 10 login attempts per 5 minutes per IP
async def login(request: Request, data: UserLogin, db: AsyncSession = Depends(get_db)):
    result = await db.execute(
        text("SELECT id, email, password_hash, full_name, avatar_url, role, status FROM Users WHERE email = :email"),
        {"email": data.email}
    )
    user_row = result.mappings().first()

    if not user_row or not verify_password(data.password, user_row["password_hash"]):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect email or password"
        )

    if user_row["status"] != UserStatus.ACTIVE.value:
        raise HTTPException(status_code=403, detail="Account is disabled")

    user_id = user_row["id"]
    # Create tokens
    access_token = create_access_token(user_id)
    refresh_token, jti = create_refresh_token(user_id)

    await _store_refresh_token(
        db,
        user_id,
        jti,
        datetime.utcnow() + timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS),
    )
    await db.commit()

    return TokenResponse(
        access_token=access_token,
        refresh_token=refresh_token,
        expires_in=settings.ACCESS_TOKEN_EXPIRE_MINUTES * 60,
        user=AuthUser(
            id=user_row["id"],
            email=user_row["email"],
            full_name=user_row["full_name"],
            role=user_row["role"],
            status=user_row["status"],
            avatar_url=user_row["avatar_url"],
        ),
    )

# ====================== REFRESH TOKEN ======================
@router.post("/refresh", response_model=TokenResponse)
async def refresh_token(data: RefreshRequest, db: AsyncSession = Depends(get_db)):
    payload = decode_token(data.refresh_token)
    if not payload or payload.get("type") != "refresh":
        raise HTTPException(status_code=401, detail="Invalid refresh token")

    user_id = payload.get("sub")
    jti = payload.get("jti")

    stored = await db.execute(
        text(
            """
            SELECT id
            FROM RefreshTokens
            WHERE user_id = :user_id
              AND token_hash = :token_hash
              AND revoked_at IS NULL
              AND expires_at > :now
            LIMIT 1
            """
        ),
        {"user_id": int(user_id), "token_hash": _token_hash(jti), "now": datetime.utcnow()},
    )
    stored_row = stored.mappings().first()
    if not stored_row:
        raise HTTPException(status_code=401, detail="Refresh token revoked or expired")

    await db.execute(
        text("UPDATE RefreshTokens SET revoked_at = :now WHERE id = :id"),
        {"now": datetime.utcnow(), "id": stored_row["id"]},
    )

    new_access = create_access_token(user_id)
    new_refresh, new_jti = create_refresh_token(user_id)

    # Fetch user info
    user_result = await db.execute(
        text("SELECT id, email, full_name, avatar_url, role, status FROM Users WHERE id = :user_id"),
        {"user_id": int(user_id)}
    )
    user_row = user_result.mappings().first()
    if not user_row or user_row["status"] != UserStatus.ACTIVE.value:
        raise HTTPException(status_code=401, detail="User not found or inactive")

    await _store_refresh_token(
        db,
        int(user_id),
        new_jti,
        datetime.utcnow() + timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS),
    )
    await db.commit()

    return TokenResponse(
        access_token=new_access,
        refresh_token=new_refresh,
        expires_in=settings.ACCESS_TOKEN_EXPIRE_MINUTES * 60,
        user=AuthUser(
            id=user_row["id"],
            email=user_row["email"],
            full_name=user_row["full_name"],
            role=user_row["role"],
            status=user_row["status"],
            avatar_url=user_row["avatar_url"],
        ),
    )

# ====================== LOGOUT ======================
@router.post("/logout", response_model=MessageResponse)
async def logout(data: RefreshRequest, db: AsyncSession = Depends(get_db)):
    payload = decode_token(data.refresh_token)
    if payload and payload.get("type") == "refresh":
        user_id = payload.get("sub")
        jti = payload.get("jti")
        await db.execute(
            text(
                """
                UPDATE RefreshTokens
                SET revoked_at = :now
                WHERE user_id = :user_id AND token_hash = :token_hash
                """
            ),
            {"now": datetime.utcnow(), "user_id": int(user_id), "token_hash": _token_hash(jti)},
        )
        await db.commit()

    return {"message": "Logged out successfully"}

# ====================== LOGOUT ALL DEVICES ======================
@router.post("/logout-all", response_model=MessageResponse)
async def logout_all(data: RefreshRequest, db: AsyncSession = Depends(get_db)):
    payload = decode_token(data.refresh_token)
    if not payload or payload.get("type") != "refresh":
        raise HTTPException(status_code=401, detail="Invalid token")

    user_id = payload.get("sub")
    await db.execute(
        text(
            "UPDATE RefreshTokens SET revoked_at = :now "
            "WHERE user_id = :user_id AND revoked_at IS NULL"
        ),
        {"now": datetime.utcnow(), "user_id": int(user_id)},
    )
    await db.commit()
    return {"message": "Logged out from all devices"}

# ====================== FORGOT PASSWORD ======================
@router.post("/forgot-password", response_model=MessageResponse)
@forgot_password_limit()
async def forgot_password(request: Request, data: ForgotPasswordRequest, db: AsyncSession = Depends(get_db)):
    result = await db.execute(
        text("SELECT id, email, full_name FROM Users WHERE email = :email"),
        {"email": data.email},
    )
    user_row = result.mappings().first()

    # Same response whether the email exists or not so an attacker
    # cannot enumerate which addresses are registered.
    generic_message = (
        "If an account exists for that email, a password reset link "
        "has been sent."
    )

    # No matching row — bail out without touching the rest of the flow.
    if not user_row:
        return {"message": generic_message}

    raw_token = secrets.token_urlsafe(32)
    token_hash = hashlib.sha256(raw_token.encode("utf-8")).hexdigest()
    now = datetime.utcnow()
    await db.execute(
        text(
            """
            INSERT INTO PasswordResetTokens
                (user_id, token_hash, expires_at, created_at)
            VALUES (:user_id, :token_hash, :expires_at, :created_at)
            """
        ),
        {
            "user_id": user_row["id"],
            "token_hash": token_hash,
            "expires_at": now + timedelta(minutes=30),
            "created_at": now,
        },
    )
    await db.commit()

    # Email the raw token to the user. The HTTP response *never* carries
    # the token — the only way the user can obtain it is via their inbox.
    delivery = send_password_reset_email(
        user_row["email"],
        raw_token,
        user_row["full_name"],
    )
    if not delivery.success:
        log.info(
            "password-reset email deferred for user_id=%s reason=%s",
            user_row["id"],
            delivery.detail,
        )

    return {"message": generic_message}

# ====================== RESET PASSWORD ======================
@router.post("/reset-password", response_model=MessageResponse)
async def reset_password(data: ResetPasswordRequest, db: AsyncSession = Depends(get_db)):
    token_hash = hashlib.sha256(data.token.encode("utf-8")).hexdigest()
    result = await db.execute(
        text(
            """
            SELECT id, user_id
            FROM PasswordResetTokens
            WHERE token_hash = :token_hash
              AND used_at IS NULL
              AND expires_at > :now
            LIMIT 1
            """
        ),
        {"token_hash": token_hash, "now": datetime.utcnow()},
    )
    reset_row = result.mappings().first()
    if not reset_row:
        raise HTTPException(status_code=400, detail="Invalid or expired reset token")

    user_id = reset_row["user_id"]
    new_password_hash = hash_password(data.new_password)

    # Update user password
    await db.execute(
        text("UPDATE Users SET password_hash = :password_hash, updated_at = :updated_at WHERE id = :id"),
        {"password_hash": new_password_hash, "updated_at": datetime.utcnow(), "id": user_id},
    )

    # Mark reset token as used
    await db.execute(
        text("UPDATE PasswordResetTokens SET used_at = :used_at WHERE id = :id"),
        {"used_at": datetime.utcnow(), "id": reset_row["id"]},
    )
    await db.commit()

    # Revoke all refresh tokens for this user
    await db.execute(
        text(
            "UPDATE RefreshTokens SET revoked_at = :now "
            "WHERE user_id = :user_id AND revoked_at IS NULL"
        ),
        {"now": datetime.utcnow(), "user_id": user_id},
    )
    await db.commit()
    return {"message": "Password has been reset successfully."}

# ====================== CHANGE PASSWORD (When Logged In) ======================
@router.post("/change-password", response_model=MessageResponse)
async def change_password(
    data: ChangePasswordRequest,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Change password for currently logged-in user"""
    # Verify current password
    if not verify_password(data.current_password, current_user.password_hash):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Current password is incorrect"
        )

    # Update to new password
    new_password_hash = hash_password(data.new_password)
    now = datetime.utcnow()

    await db.execute(
        text(
            "UPDATE Users SET password_hash = :password_hash, updated_at = :updated_at WHERE id = :id"
        ),
        {"password_hash": new_password_hash, "updated_at": now, "id": current_user.id},
    )
    await db.commit()

    # Revoke all existing refresh tokens for security
    await db.execute(
        text(
            "UPDATE RefreshTokens SET revoked_at = :now "
            "WHERE user_id = :user_id AND revoked_at IS NULL"
        ),
        {"now": now, "user_id": current_user.id},
    )

    await db.commit()

    return {"message": "Password changed successfully. Please login again with your new password."}
