import io
from math import ceil
from datetime import datetime
from pathlib import Path
from uuid import uuid4

from fastapi import APIRouter, Depends, File, HTTPException, Query, Request, UploadFile, status
from sqlalchemy import text
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession

from config import settings
from config.security import hash_password
from controller.v1.dependencies import get_current_admin, get_current_user
from db.session import get_db
from schema.users import User, UserCreate, UserListResult, UserResult, UserUpdate, UserRole, UserStatus
from schema.profile import ProfileUpdate


router = APIRouter(prefix="/users", tags=["Users"])

_ALLOWED_AVATAR_TYPES = {
    "image/jpeg",
    "image/png",
    "image/webp",
}
AVATAR_MAX_BYTES = 5 * 1024 * 1024


@router.get("/me", response_model=UserResult)
async def get_current_user_profile(
    current_user: User = Depends(get_current_user),
):
    """Get current authenticated user's profile"""
    return current_user


@router.post("/me/avatar")
async def upload_avatar(
    request: Request,
    file: UploadFile = File(...),
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Accept an avatar image, re-encode it to a 512px JPEG and store it.

    Re-encoding normalises every browser/mobile format into one small
    file (and strips EXIF metadata, including GPS tags) before it is
    served from the public /avatars mount.
    """
    from PIL import Image, ImageOps

    if (file.content_type or "") not in _ALLOWED_AVATAR_TYPES:
        raise HTTPException(
            status_code=415, detail="Only JPEG, PNG or WebP images are supported"
        )
    raw = await file.read()
    if len(raw) > AVATAR_MAX_BYTES:
        raise HTTPException(status_code=413, detail="Image must be 5 MB or smaller")
    try:
        image = ImageOps.exif_transpose(Image.open(io.BytesIO(raw)))
        image = image.convert("RGB")
        image.thumbnail((512, 512))
    except Exception as error:
        raise HTTPException(status_code=415, detail="Invalid image file") from error

    buffer = io.BytesIO()
    image.save(buffer, format="JPEG", quality=88, optimize=True)
    buffer.seek(0)

    avatar_dir = Path(settings.AVATAR_DIR)
    avatar_dir.mkdir(parents=True, exist_ok=True)
    filename = f"u{current_user.id}_{uuid4().hex[:8]}.jpg"
    (avatar_dir / filename).write_bytes(buffer.getvalue())

    # Best-effort cleanup of the replaced avatar file. Only delete files
    # that live inside our own directory and match our naming scheme.
    old_url = (
        await db.execute(
            text("SELECT avatar_url FROM Users WHERE id = :id"), {"id": current_user.id}
        )
    ).scalar_one_or_none()
    if old_url:
        old_path = avatar_dir / old_url.rsplit("/", 1)[-1]
        if old_path.parent == avatar_dir and old_path.is_file():
            old_path.unlink(missing_ok=True)

    url = f"{str(request.base_url).rstrip('/')}/avatars/{filename}"
    await db.execute(
        text(
            "UPDATE Users SET avatar_url = :url, updated_at = :now WHERE id = :id"
        ),
        {"url": url, "now": datetime.utcnow(), "id": current_user.id},
    )
    await db.commit()
    return {"avatar_url": url}


@router.put("/me", response_model=UserResult)
async def update_current_user_profile(
    data: ProfileUpdate,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Update current user's profile (full_name, avatar_url only)"""
    now = datetime.utcnow()
    updates = {"updated_at": now}
    if data.full_name is not None:
        updates["full_name"] = data.full_name
    if data.avatar_url is not None:
        updates["avatar_url"] = data.avatar_url

    # Build the UPDATE statement dynamically
    set_clause = ", ".join([f"{k} = :{k}" for k in updates.keys()])
    await db.execute(
        text(f"UPDATE Users SET {set_clause} WHERE id = :id"),
        {**updates, "id": current_user.id}
    )
    await db.commit()

    # Fetch updated user
    result = await db.execute(
        text("SELECT id, email, password_hash, full_name, avatar_url, role, status, created_at, updated_at FROM Users WHERE id = :id"),
        {"id": current_user.id}
    )
    user_row = result.mappings().first()

    # Return reconstructed User object
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


async def _email_in_use(db: AsyncSession, email: str, user_id: int | None = None) -> bool:
    if user_id is not None:
        result = await db.execute(
            text("SELECT id FROM Users WHERE email = :email AND id != :user_id"),
            {"email": email, "user_id": user_id}
        )
    else:
        result = await db.execute(
            text("SELECT id FROM Users WHERE email = :email"),
            {"email": email}
        )
    return result.scalar_one_or_none() is not None


@router.get("", response_model=UserListResult)
async def list_users(
    search: str | None = None,
    role: str | None = Query(default=None, pattern="^(user|admin)$"),
    status_filter: str | None = Query(
        default=None, alias="status", pattern="^(active|inactive|banned)$"
    ),
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=8, ge=1, le=100),
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    # Build WHERE clause dynamically
    where_conditions = []
    params = {}

    if search:
        term = f"%{search.strip()}%"
        where_conditions.append("(full_name LIKE :search_term OR email LIKE :search_term)")
        params["search_term"] = term

    if role:
        where_conditions.append("role = :role")
        params["role"] = role

    if status_filter:
        where_conditions.append("status = :status")
        params["status"] = status_filter

    where_clause = " AND ".join(where_conditions) if where_conditions else "1=1"

    # Count total
    count_query = f"SELECT COUNT(*) FROM Users WHERE {where_clause}"
    total = (await db.execute(text(count_query), params)).scalar_one()

    # Fetch paginated results
    offset = (page - 1) * page_size
    list_query = f"""
        SELECT id, email, password_hash, full_name, avatar_url, role, status, created_at, updated_at
        FROM Users
        WHERE {where_clause}
        ORDER BY created_at DESC, id DESC
        LIMIT :limit OFFSET :offset
    """
    params["limit"] = page_size
    params["offset"] = offset

    result = await db.execute(text(list_query), params)
    users = []
    for row in result.mappings():
        users.append(User(
            id=row["id"],
            email=row["email"],
            password_hash=row["password_hash"],
            full_name=row["full_name"],
            avatar_url=row["avatar_url"],
            role=UserRole(row["role"]),
            status=UserStatus(row["status"]),
            created_at=row["created_at"],
            updated_at=row["updated_at"],
        ))

    return UserListResult(
        items=users,
        total=total,
        page=page,
        page_size=page_size,
        total_pages=ceil(total / page_size) if total else 0,
    )


@router.get("/{user_id}", response_model=UserResult)
async def get_user(
    user_id: int,
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    result = await db.execute(
        text("SELECT id, email, password_hash, full_name, avatar_url, role, status, created_at, updated_at FROM Users WHERE id = :id"),
        {"id": user_id}
    )
    user_row = result.mappings().first()
    if not user_row:
        raise HTTPException(status_code=404, detail="User not found")

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


@router.post("", response_model=UserResult, status_code=status.HTTP_201_CREATED)
async def create_user(
    data: UserCreate,
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    if await _email_in_use(db, data.email):
        raise HTTPException(status_code=409, detail="Email already registered")

    now = datetime.utcnow()
    await db.execute(
        text(
            """
            INSERT INTO Users
                (email, password_hash, full_name, avatar_url, role, status, created_at, updated_at)
            VALUES (:email, :password_hash, :full_name, :avatar_url, :role, :status, :created_at, :updated_at)
            """
        ),
        {
            "email": data.email,
            "password_hash": hash_password(data.password),
            "full_name": data.full_name,
            "avatar_url": data.avatar_url,
            "role": data.role,
            "status": data.status,
            "created_at": now,
            "updated_at": now,
        },
    )

    user_id = int((await db.execute(text("SELECT LAST_INSERT_ID()"))).scalar_one())

    # Create credit wallet
    await db.execute(
        text("INSERT INTO CreditWallets (user_id, balance, updated_at) VALUES (:user_id, :balance, :updated_at)"),
        {"user_id": user_id, "balance": 10, "updated_at": now},
    )

    try:
        await db.commit()
    except IntegrityError:
        await db.rollback()
        raise HTTPException(status_code=409, detail="Email already registered")

    # Fetch created user
    result = await db.execute(
        text("SELECT id, email, password_hash, full_name, avatar_url, role, status, created_at, updated_at FROM Users WHERE id = :id"),
        {"id": user_id}
    )
    user_row = result.mappings().first()

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


@router.put("/{user_id}", response_model=UserResult)
async def update_user(
    user_id: int,
    data: UserUpdate,
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    # Check user exists
    result = await db.execute(
        text("SELECT id, email, password_hash, full_name, avatar_url, role, status, created_at, updated_at FROM Users WHERE id = :id"),
        {"id": user_id}
    )
    user_row = result.mappings().first()
    if not user_row:
        raise HTTPException(status_code=404, detail="User not found")

    # Check if new email is in use
    if data.email and await _email_in_use(db, data.email, user_id):
        raise HTTPException(status_code=409, detail="Email already registered")

    # Build update fields
    updates = {"updated_at": datetime.utcnow()}
    values = data.model_dump(exclude_unset=True)
    password = values.pop("password", None)

    if password:
        updates["password_hash"] = hash_password(password)

    for field, value in values.items():
        if field in ["email", "full_name", "avatar_url", "role", "status"]:
            updates[field] = value

    # Build UPDATE statement
    set_clause = ", ".join([f"{k} = :{k}" for k in updates.keys()])

    try:
        await db.execute(
            text(f"UPDATE Users SET {set_clause} WHERE id = :id"),
            {**updates, "id": user_id}
        )
        await db.commit()
    except IntegrityError:
        await db.rollback()
        raise HTTPException(status_code=409, detail="Email already registered")

    # Fetch updated user
    result = await db.execute(
        text("SELECT id, email, password_hash, full_name, avatar_url, role, status, created_at, updated_at FROM Users WHERE id = :id"),
        {"id": user_id}
    )
    updated_row = result.mappings().first()

    return User(
        id=updated_row["id"],
        email=updated_row["email"],
        password_hash=updated_row["password_hash"],
        full_name=updated_row["full_name"],
        avatar_url=updated_row["avatar_url"],
        role=UserRole(updated_row["role"]),
        status=UserStatus(updated_row["status"]),
        created_at=updated_row["created_at"],
        updated_at=updated_row["updated_at"],
    )
