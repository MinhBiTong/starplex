from datetime import datetime
from typing import Literal

from pydantic import BaseModel, Field


class ImageGenerationRequest(BaseModel):
    prompt: str = Field(..., min_length=1, max_length=4000)
    aspect_ratio: Literal["16:9", "1:1", "9:16"] = "16:9"
    style: Literal["Cinematic", "Documentary", "Studio", "Animated"] = "Cinematic"
    type: Literal["image"] = "image"


class ImageGenerationResponse(BaseModel):
    generation_id: int
    status: str
    credit_cost: int
    image_url: str
    prompt: str
    translated_prompt: str
    aspect_ratio: str
    width: int
    height: int


class GenerationHistoryItem(BaseModel):
    id: int
    type: str
    prompt: str
    aspect_ratio: str | None = None
    status: str
    credit_cost: int
    error_message: str | None = None
    created_at: datetime
    completed_at: datetime | None = None
    file_url: str | None = None


class GenerationUsage(BaseModel):
    credit_balance: int


class VideoGenerationRequest(BaseModel):
    prompt: str = Field(..., min_length=1, max_length=4000)
    aspect_ratio: Literal["16:9", "1:1", "9:16"] = "16:9"
    duration_seconds: Literal[4, 6, 8] = 4
    quality: Literal["720p", "1080p"] = "720p"
    type: Literal["video"] = "video"


class VideoGenerationResponse(BaseModel):
    """Accepted job — poll GET /generate/video/{generation_id} until done."""

    generation_id: int
    status: str
    credit_cost: int
    prompt: str
    aspect_ratio: str
    duration_seconds: int
    quality: str


class VideoGenerationStatusResponse(BaseModel):
    generation_id: int
    status: str
    credit_cost: int
    video_url: str | None = None
    error_message: str | None = None
    aspect_ratio: str | None = None
    duration_seconds: int | None = None
    resolution: str | None = None
    created_at: datetime | None = None
    completed_at: datetime | None = None
