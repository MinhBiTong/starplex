from datetime import datetime

from pydantic import BaseModel, Field


class PaymentCreate(BaseModel):
    package_id: int
    payment_method: str = Field(pattern="^(momo|zalopay|vnpay|bank_transfer|stripe|other)$")


class StripeCheckoutCreate(BaseModel):
    package_id: int


class StripeCheckoutResult(BaseModel):
    payment_id: int
    checkout_url: str


class PaymentResult(BaseModel):
    id: int
    user_id: int
    package_id: int
    package_name: str
    credit_amount: int
    amount: float
    currency: str
    payment_method: str
    status: str
    transaction_code: str | None
    provider_transaction_id: str | None
    created_at: datetime
    paid_at: datetime | None


class PaymentStatusUpdate(BaseModel):
    status: str = Field(pattern="^(completed|failed|cancelled)$")
