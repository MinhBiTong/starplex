from datetime import datetime

from pydantic import BaseModel, Field


class SettingItem(BaseModel):
    key: str = Field(..., min_length=1, max_length=100)
    value: str | None = None
    value_type: str = Field(default="string", pattern="^(string|int|bool|json)$")
    updated_at: datetime | None = None


class SettingsUpdate(BaseModel):
    items: list[SettingItem]
