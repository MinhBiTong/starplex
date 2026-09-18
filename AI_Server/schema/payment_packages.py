from datetime import datetime

from pydantic import BaseModel, ConfigDict, Field


class PaymentPackageBase(BaseModel):
    name: str = Field(..., min_length=1, max_length=255)
    price: float = Field(..., ge=0)
    currency: str = Field(default="USD", min_length=1, max_length=10)
    credit_amount: int = Field(..., gt=0)
    description: str | None = None
    is_active: bool = True
    billing_period: str = Field(default="one_time", pattern="^(monthly|yearly|one_time)$")
    is_featured: bool = False
    benefits: list[str] = Field(default_factory=list)


class PaymentPackageCreate(PaymentPackageBase):
    pass


class PaymentPackageUpdate(PaymentPackageBase):
    pass


class PaymentPackageResult(PaymentPackageBase):
    model_config = ConfigDict(from_attributes=True)

    id: int
    created_at: datetime
    updated_at: datetime | None
