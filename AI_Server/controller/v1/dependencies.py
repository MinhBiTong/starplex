from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text

from config.security import decode_access_token
from db.session import get_db
from schema.users import User, UserRole, UserStatus


bearer_scheme = HTTPBearer(auto_error=False)


async def get_current_user(
    credentials: HTTPAuthorizationCredentials | None = Depends(bearer_scheme),
    db: AsyncSession = Depends(get_db),
) -> User:
    if credentials is None or credentials.scheme.lower() != "bearer":
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Missing access token")

    payload = decode_access_token(credentials.credentials)
    if not payload or payload.get("type") != "access":
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid access token")

    try:
        user_id = int(payload.get("sub"))
    except (TypeError, ValueError):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid access token")

    result = await db.execute(
        text(
            "SELECT id, email, password_hash, full_name, avatar_url, role, status, "
            "created_at, updated_at FROM Users WHERE id = :user_id"
        ),
        {"user_id": user_id},
    )
    user_row = result.mappings().first()
    if not user_row:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Account is inactive")

    if user_row["status"] != UserStatus.ACTIVE.value:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Account is inactive")

    return User(
        id=user_row["id"],
        email=user_row["email"],
        password_hash=user_row["password_hash"],
        full_name=user_row["full_name"],
        avatar_url=user_row["avatar_url"],
        role=UserRole(user_row["role"]),
        status=UserStatus(user_row["status"]),
        created_at=user_row["created_at"],
        updated_at=user_row["updated_at"],
    )


async def get_current_admin(user: User = Depends(get_current_user)) -> User:
    if user.role != UserRole.ADMIN:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Admin permission required")
    return user