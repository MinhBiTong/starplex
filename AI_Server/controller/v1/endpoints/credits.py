from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession

from controller.v1.dependencies import get_current_admin, get_current_user
from db.session import get_db
from schema.users import User
from schema.credits import CreditAdjustment, CreditTransactionResult, CreditWalletResult


router = APIRouter(prefix="/credits", tags=["Credits"])


async def _wallet(db: AsyncSession, user_id: int, create: bool = False):
    result = await db.execute(text("SELECT id, user_id, balance FROM CreditWallets WHERE user_id = :user_id FOR UPDATE"), {"user_id": user_id})
    row = result.mappings().first()
    if row is None and create:
        await db.execute(text("INSERT INTO CreditWallets (user_id, balance, updated_at) VALUES (:user_id, 0, NOW())"), {"user_id": user_id})
        result = await db.execute(text("SELECT id, user_id, balance FROM CreditWallets WHERE user_id = :user_id FOR UPDATE"), {"user_id": user_id})
        row = result.mappings().first()
    return row


@router.get("/me", response_model=CreditWalletResult)
async def my_wallet(db: AsyncSession = Depends(get_db), user: User = Depends(get_current_user)):
    row = await _wallet(db, user.id, create=True)
    return CreditWalletResult(user_id=row["user_id"], wallet_id=row["id"], balance=row["balance"])


@router.get("/transactions", response_model=list[CreditTransactionResult])
async def my_transactions(
    limit: int = Query(default=50, ge=1, le=200),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    result = await db.execute(text("SELECT * FROM CreditTransactions WHERE user_id = :user_id ORDER BY id DESC LIMIT :limit"), {"user_id": user.id, "limit": limit})
    return [CreditTransactionResult(**dict(row)) for row in result.mappings()]


@router.post("/admin/{user_id}/adjust", response_model=CreditTransactionResult)
async def adjust_credits(
    user_id: int,
    data: CreditAdjustment,
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    # Check if user exists
    user_check = await db.execute(text("SELECT id FROM Users WHERE id = :id"), {"id": user_id})
    if not user_check.scalar_one_or_none():
        raise HTTPException(status_code=404, detail="User not found")

    wallet = await _wallet(db, user_id, create=True)
    before = int(wallet["balance"])
    after = before + data.amount
    if after < 0:
        raise HTTPException(status_code=409, detail="Credit balance cannot be negative")
    await db.execute(text("UPDATE CreditWallets SET balance = :balance, updated_at = NOW() WHERE id = :id"), {"balance": after, "id": wallet["id"]})
    await db.execute(text("INSERT INTO CreditTransactions (user_id, wallet_id, type, amount, balance_before, balance_after, reference_type, reference_id, description, created_at) VALUES (:user_id, :wallet_id, 'adjustment', :amount, :before, :after, 'admin', NULL, :description, NOW())"), {"user_id": user_id, "wallet_id": wallet["id"], "amount": data.amount, "before": before, "after": after, "description": data.description})
    result = await db.execute(text("SELECT * FROM CreditTransactions WHERE user_id = :user_id ORDER BY id DESC LIMIT 1"), {"user_id": user_id})
    return CreditTransactionResult(**dict(result.mappings().one()))
