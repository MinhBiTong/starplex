from pydantic import BaseModel, Field


class ProfileUpdate(BaseModel):
    """Schema for user self-updating their profile"""
    full_name: str | None = Field(default=None, max_length=255)
    avatar_url: str | None = Field(default=None, max_length=500)
