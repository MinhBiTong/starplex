from pydantic import BaseModel, Field, ConfigDict

from schema._email import EmailStr

class UserRegister(BaseModel):
    email: EmailStr
    password: str = Field(..., min_length=8)
    full_name: str | None = None

class UserLogin(BaseModel):
    email: EmailStr
    password: str

class TokenResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    expires_in: int          # giây
    user: "AuthUser"

class AuthUser(BaseModel):
    id: int
    email: EmailStr
    full_name: str | None = None
    role: str
    status: str
    avatar_url: str | None = None

class RefreshRequest(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    refresh_token: str

class ForgotPasswordRequest(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    email: EmailStr

class ResetPasswordRequest(BaseModel):
    token: str
    new_password: str = Field(..., min_length=8)


class ChangePasswordRequest(BaseModel):
    """Schema for changing password when already logged in"""
    current_password: str = Field(..., min_length=1)
    new_password: str = Field(..., min_length=8)


class MessageResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    message: str
    reset_token: str | None = None
