from datetime import datetime

from pydantic import BaseModel, Field


class CreditWalletResult(BaseModel):
    user_id: int
    wallet_id: int
    balance: int


class CreditTransactionResult(BaseModel):
    id: int
    user_id: int
    wallet_id: int
    type: str
    amount: int
    balance_before: int
    balance_after: int
    reference_type: str | None
    reference_id: int | None
    description: str | None
    created_at: datetime


class CreditAdjustment(BaseModel):
    amount: int = Field(..., ne=0)
    description: str = Field(..., min_length=1, max_length=500)
