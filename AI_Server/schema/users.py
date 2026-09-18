from datetime import datetime
from enum import Enum

from pydantic import BaseModel, ConfigDict, Field

from schema._email import EmailStr

class UserRole(str, Enum):
    USER = "user"
    ADMIN = "admin"


class UserStatus(str, Enum):
    ACTIVE = "active"
    INACTIVE = "inactive"
    BANNED = "banned"


class UserCreate(BaseModel):
    email: EmailStr
    password: str = Field(..., min_length=8)
    full_name: str | None = Field(default=None, max_length=255)
    avatar_url: str | None = Field(default=None, max_length=500)
    role: UserRole = UserRole.USER
    status: UserStatus = UserStatus.ACTIVE


class UserUpdate(BaseModel):
    email: EmailStr | None = None
    password: str | None = Field(default=None, min_length=8)
    full_name: str | None = Field(default=None, max_length=255)
    avatar_url: str | None = Field(default=None, max_length=500)
    role: UserRole | None = None
    status: UserStatus | None = None


class UserResult(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    email: EmailStr
    full_name: str | None
    avatar_url: str | None
    role: UserRole
    status: UserStatus
    created_at: datetime
    updated_at: datetime | None


class UserListResult(BaseModel):
    items: list[UserResult]
    total: int
    page: int
    page_size: int
    total_pages: int


class User(BaseModel):
    """Lightweight DTO representing the authenticated/current user.

    Built manually from raw SQL rows; not an ORM mapping.
    Holds ``password_hash`` because ``change-password`` endpoint needs to
    verify the current password hash. Never serialize this model in
    responses - use ``UserResult`` instead.
    """

    model_config = ConfigDict(from_attributes=True)

    id: int
    email: str
    password_hash: str
    full_name: str | None = None
    avatar_url: str | None = None
    role: UserRole
    status: UserStatus
    created_at: datetime | None = None
    updated_at: datetime | None = None