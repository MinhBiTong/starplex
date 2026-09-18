import asyncio
from datetime import datetime
from decimal import Decimal, ROUND_HALF_UP
from uuid import uuid4

import stripe
from fastapi import APIRouter, Depends, HTTPException, Query, Request, status
from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession

from config import settings
from controller.v1.dependencies import get_current_admin, get_current_user
from db.session import get_db
from schema.users import User
from schema.payments import (
    PaymentCreate,
    PaymentResult,
    PaymentStatusUpdate,
    StripeCheckoutCreate,
    StripeCheckoutResult,
)


router = APIRouter(tags=["Payments"])


def _payment(row) -> PaymentResult:
    data = dict(row)
    data["amount"] = float(data["amount"])
    return PaymentResult(**data)


async def _get_payment(db: AsyncSession, payment_id: int, lock: bool = False):
    suffix = " FOR UPDATE" if lock else ""
    result = await db.execute(
        text(f"SELECT * FROM Payments WHERE id = :id{suffix}"),
        {"id": payment_id},
    )
    return result.mappings().first()


def _require_stripe() -> None:
    if not settings.STRIPE_SECRET_KEY:
        raise HTTPException(
            status_code=503,
            detail="Stripe is not configured. Set STRIPE_SECRET_KEY on the server.",
        )


def _checkout_return_url(kind: str) -> str:
    configured = (
        settings.STRIPE_SUCCESS_URL if kind == "success" else settings.STRIPE_CANCEL_URL
    )
    if configured:
        return configured
    base_url = settings.FRONTEND_URL.rstrip("/")
    if kind == "success":
        return f"{base_url}/?stripe=success&session_id={{CHECKOUT_SESSION_ID}}"
    return f"{base_url}/?stripe=cancelled"


def _create_checkout_session(
    *,
    payment_id: int,
    user: User,
    package,
):
    stripe.api_key = settings.STRIPE_SECRET_KEY
    amount_cents = int(
        (Decimal(str(package["price"])) * 100).quantize(
            Decimal("1"), rounding=ROUND_HALF_UP
        )
    )
    if amount_cents <= 0:
        raise ValueError("Payment package price must be greater than zero")

    metadata = {
        "payment_id": str(payment_id),
        "user_id": str(user.id),
        "package_id": str(package["id"]),
    }
    return stripe.checkout.Session.create(
        mode="payment",
        customer_email=user.email,
        client_reference_id=str(payment_id),
        metadata=metadata,
        payment_intent_data={"metadata": metadata},
        line_items=[
            {
                "price_data": {
                    "currency": str(package["currency"]).lower(),
                    "product_data": {
                        "name": str(package["name"]),
                        "description": str(package["description"] or "AI credits"),
                    },
                    "unit_amount": amount_cents,
                },
                "quantity": 1,
            }
        ],
        success_url=_checkout_return_url("success"),
        cancel_url=_checkout_return_url("cancel"),
    )


async def _complete_payment(
    db: AsyncSession,
    payment_id: int,
    provider_transaction_id: str | None = None,
) -> PaymentResult:
    """Mark a pending payment complete and grant credits exactly once."""
    payment = await _get_payment(db, payment_id, lock=True)
    if not payment:
        raise HTTPException(status_code=404, detail="Payment not found")
    if payment["status"] == "completed":
        return _payment(payment)
    if payment["status"] != "pending":
        raise HTTPException(status_code=409, detail="Payment is no longer pending")

    wallet_result = await db.execute(
        text(
            "SELECT id, balance FROM CreditWallets "
            "WHERE user_id = :user_id FOR UPDATE"
        ),
        {"user_id": payment["user_id"]},
    )
    wallet = wallet_result.mappings().first()
    if not wallet:
        await db.execute(
            text(
                "INSERT INTO CreditWallets (user_id, balance, updated_at) "
                "VALUES (:user_id, 0, NOW())"
            ),
            {"user_id": payment["user_id"]},
        )
        wallet_result = await db.execute(
            text(
                "SELECT id, balance FROM CreditWallets "
                "WHERE user_id = :user_id FOR UPDATE"
            ),
            {"user_id": payment["user_id"]},
        )
        wallet = wallet_result.mappings().one()

    before = int(wallet["balance"])
    after = before + int(payment["credit_amount"])
    await db.execute(
        text(
            "UPDATE CreditWallets SET balance = :balance, updated_at = NOW() "
            "WHERE id = :id"
        ),
        {"balance": after, "id": wallet["id"]},
    )
    await db.execute(
        text(
            """
            INSERT INTO CreditTransactions
                (user_id, wallet_id, type, amount, balance_before, balance_after,
                 reference_type, reference_id, description, created_at)
            VALUES
                (:user_id, :wallet_id, 'purchase', :amount, :before, :after,
                 'payment', :reference_id, :description, NOW())
            """
        ),
        {
            "user_id": payment["user_id"],
            "wallet_id": wallet["id"],
            "amount": payment["credit_amount"],
            "before": before,
            "after": after,
            "reference_id": payment_id,
            "description": f"Purchase {payment['package_name']}",
        },
    )
    await db.execute(
        text(
            """
            UPDATE Payments
            SET status = 'completed', paid_at = :paid_at,
                provider_transaction_id = COALESCE(:provider_transaction_id,
                    provider_transaction_id)
            WHERE id = :id
            """
        ),
        {
            "id": payment_id,
            "paid_at": datetime.utcnow(),
            "provider_transaction_id": provider_transaction_id,
        },
    )
    await db.commit()
    return _payment(await _get_payment(db, payment_id))


async def _set_stripe_payment_status(
    db: AsyncSession,
    payment_id: int,
    payment_status: str,
) -> None:
    payment = await _get_payment(db, payment_id, lock=True)
    if not payment or payment["status"] == "completed":
        return
    await db.execute(
        text("UPDATE Payments SET status = :status WHERE id = :id"),
        {"id": payment_id, "status": payment_status},
    )
    await db.commit()


@router.post(
    "/payments/stripe/checkout-session",
    response_model=StripeCheckoutResult,
    status_code=status.HTTP_201_CREATED,
)
async def create_stripe_checkout_session(
    data: StripeCheckoutCreate,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    _require_stripe()
    package_result = await db.execute(
        text("SELECT * FROM PaymentPackages WHERE id = :id AND is_active = 1"),
        {"id": data.package_id},
    )
    package = package_result.mappings().first()
    if not package:
        raise HTTPException(status_code=404, detail="Payment package is not available")

    code = f"PAY-{uuid4().hex[:12].upper()}"
    await db.execute(
        text(
            """
            INSERT INTO Payments
                (user_id, package_id, package_name, credit_amount, amount, currency,
                 payment_method, status, transaction_code, provider_transaction_id,
                 created_at, paid_at)
            VALUES (:user_id, :package_id, :package_name, :credit_amount, :amount,
                    :currency, 'stripe', 'pending', :transaction_code, NULL,
                    :created_at, NULL)
            """
        ),
        {
            "user_id": user.id,
            "package_id": package["id"],
            "package_name": package["name"],
            "credit_amount": package["credit_amount"],
            "amount": package["price"],
            "currency": package["currency"],
            "transaction_code": code,
            "created_at": datetime.utcnow(),
        },
    )
    payment_id = int((await db.execute(text("SELECT LAST_INSERT_ID()"))).scalar_one())
    await db.commit()

    try:
        checkout_session = await asyncio.to_thread(
            _create_checkout_session,
            payment_id=payment_id,
            user=user,
            package=package,
        )
    except (stripe.error.StripeError, ValueError) as error:
        await db.execute(
            text("UPDATE Payments SET status = 'failed' WHERE id = :id"),
            {"id": payment_id},
        )
        await db.commit()
        raise HTTPException(status_code=502, detail="Unable to create Stripe Checkout session") from error

    await db.execute(
        text(
            "UPDATE Payments SET provider_transaction_id = :session_id WHERE id = :id"
        ),
        {"session_id": checkout_session.id, "id": payment_id},
    )
    await db.commit()
    return StripeCheckoutResult(payment_id=payment_id, checkout_url=checkout_session.url)


@router.post("/payments/stripe/webhook", include_in_schema=False)
async def stripe_webhook(request: Request, db: AsyncSession = Depends(get_db)):
    if not settings.STRIPE_WEBHOOK_SECRET:
        raise HTTPException(status_code=503, detail="Stripe webhook is not configured")

    payload = await request.body()
    signature = request.headers.get("stripe-signature")
    if not signature:
        raise HTTPException(status_code=400, detail="Missing Stripe-Signature header")
    try:
        event = stripe.Webhook.construct_event(
            payload,
            signature,
            settings.STRIPE_WEBHOOK_SECRET,
        )
    except (ValueError, stripe.error.SignatureVerificationError) as error:
        raise HTTPException(status_code=400, detail="Invalid Stripe webhook signature") from error

    event_type = event["type"]
    session = event["data"]["object"]
    metadata = session.get("metadata", {})
    payment_id_value = metadata.get("payment_id") or session.get("client_reference_id")
    try:
        payment_id = int(payment_id_value)
    except (TypeError, ValueError):
        return {"received": True}

    if event_type in {"checkout.session.completed", "checkout.session.async_payment_succeeded"}:
        if session.get("payment_status") == "paid":
            await _complete_payment(
                db,
                payment_id,
                session.get("payment_intent") or session.get("id"),
            )
    elif event_type == "checkout.session.expired":
        await _set_stripe_payment_status(db, payment_id, "cancelled")
    elif event_type == "checkout.session.async_payment_failed":
        await _set_stripe_payment_status(db, payment_id, "failed")
    return {"received": True}


@router.post("/payments", response_model=PaymentResult, status_code=status.HTTP_201_CREATED)
async def create_payment(
    data: PaymentCreate,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    if data.payment_method == "stripe":
        raise HTTPException(
            status_code=400,
            detail="Use /payments/stripe/checkout-session for Stripe payments",
        )
    package_result = await db.execute(
        text("SELECT * FROM PaymentPackages WHERE id = :id AND is_active = 1"),
        {"id": data.package_id},
    )
    package = package_result.mappings().first()
    if not package:
        raise HTTPException(status_code=404, detail="Payment package is not available")
    code = f"PAY-{uuid4().hex[:12].upper()}"
    await db.execute(
        text(
            """
            INSERT INTO Payments
                (user_id, package_id, package_name, credit_amount, amount, currency,
                 payment_method, status, transaction_code, provider_transaction_id,
                 created_at, paid_at)
            VALUES (:user_id, :package_id, :package_name, :credit_amount, :amount,
                    :currency, :payment_method, 'pending', :transaction_code, NULL,
                    :created_at, NULL)
            """
        ),
        {
            "user_id": user.id,
            "package_id": package["id"],
            "package_name": package["name"],
            "credit_amount": package["credit_amount"],
            "amount": package["price"],
            "currency": package["currency"],
            "payment_method": data.payment_method,
            "transaction_code": code,
            "created_at": datetime.utcnow(),
        },
    )
    result = await db.execute(
        text("SELECT * FROM Payments WHERE transaction_code = :code"), {"code": code}
    )
    return _payment(result.mappings().one())


@router.get("/payments/me", response_model=list[PaymentResult])
async def list_my_payments(
    limit: int = Query(default=50, ge=1, le=200),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    result = await db.execute(
        text(
            "SELECT * FROM Payments WHERE user_id = :user_id "
            "ORDER BY id DESC LIMIT :limit"
        ),
        {"user_id": user.id, "limit": limit},
    )
    return [_payment(row) for row in result.mappings()]


@router.get("/admin/payments", response_model=list[PaymentResult])
async def list_all_payments(
    status_filter: str | None = Query(default=None, alias="status"),
    method_filter: str | None = Query(default=None, alias="payment_method"),
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    query = "SELECT * FROM Payments"
    params = {}
    if status_filter:
        query += " WHERE status = :status"
        params["status"] = status_filter
    if method_filter:
        query += " WHERE " if " WHERE " not in query else " AND "
        query += "payment_method = :payment_method"
        params["payment_method"] = method_filter
    query += " ORDER BY id DESC"
    result = await db.execute(text(query), params)
    return [_payment(row) for row in result.mappings()]


@router.patch("/admin/payments/{payment_id}/status", response_model=PaymentResult)
async def update_payment_status(
    payment_id: int,
    data: PaymentStatusUpdate,
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    payment = await _get_payment(db, payment_id, lock=True)
    if not payment:
        raise HTTPException(status_code=404, detail="Payment not found")
    if payment["payment_method"] == "stripe":
        raise HTTPException(
            status_code=409,
            detail="Stripe payments are completed only by a verified Stripe webhook",
        )
    if payment["status"] == "completed" and data.status != "completed":
        raise HTTPException(status_code=409, detail="Completed payment cannot be changed here")
    if data.status == "completed" and payment["status"] != "completed":
        return await _complete_payment(db, payment_id)
    await db.execute(
        text("UPDATE Payments SET status = :status, paid_at = NULL WHERE id = :id"),
        {"status": data.status, "id": payment_id},
    )
    await db.commit()
    return _payment(await _get_payment(db, payment_id))


@router.get("/admin/payments/{payment_id}", response_model=PaymentResult)
async def get_payment_detail(
    payment_id: int,
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    """Get detailed payment information"""
    payment = await _get_payment(db, payment_id)
    if not payment:
        raise HTTPException(status_code=404, detail="Payment not found")
    return _payment(payment)


@router.post("/admin/payments/{payment_id}/refund", response_model=PaymentResult)
async def refund_payment(
    payment_id: int,
    db: AsyncSession = Depends(get_db),
    admin: User = Depends(get_current_admin),
):
    """
    Refund a completed payment.
    - Marks payment as 'failed' or 'cancelled'
    - Deducts granted credits from user's wallet
    - Creates refund credit transaction
    """
    payment = await _get_payment(db, payment_id, lock=True)
    if not payment:
        raise HTTPException(status_code=404, detail="Payment not found")
    
    if payment["status"] != "completed":
        raise HTTPException(
            status_code=409,
            detail=f"Cannot refund payment with status '{payment['status']}'. Only completed payments can be refunded."
        )
    
    user_id = payment["user_id"]
    credit_amount = int(payment["credit_amount"])
    
    # Get user's wallet with lock
    wallet_result = await db.execute(
        text("SELECT id, balance FROM CreditWallets WHERE user_id = :user_id FOR UPDATE"),
        {"user_id": user_id},
    )
    wallet = wallet_result.mappings().first()
    
    if not wallet:
        raise HTTPException(status_code=404, detail="User wallet not found")
    
    current_balance = int(wallet["balance"])
    
    # Check if user has enough credits to deduct
    if current_balance < credit_amount:
        raise HTTPException(
            status_code=409,
            detail=f"User only has {current_balance} credits, cannot deduct {credit_amount} for refund. Manual adjustment may be required."
        )
    
    # Deduct credits
    new_balance = current_balance - credit_amount
    
    await db.execute(
        text("UPDATE CreditWallets SET balance = :balance, updated_at = NOW() WHERE id = :id"),
        {"balance": new_balance, "id": wallet["id"]},
    )
    
    # Create refund transaction
    await db.execute(
        text(
            """
            INSERT INTO CreditTransactions
                (user_id, wallet_id, type, amount, balance_before, balance_after,
                 reference_type, reference_id, description, created_at)
            VALUES (:user_id, :wallet_id, 'refund', :amount, :before, :after,
                    'payment', :payment_id, :description, NOW())
            """
        ),
        {
            "user_id": user_id,
            "wallet_id": wallet["id"],
            "amount": -credit_amount,
            "before": current_balance,
            "after": new_balance,
            "payment_id": payment_id,
            "description": f"Refund for payment {payment['transaction_code']} by admin",
        },
    )
    
    # Update payment status to cancelled (or could use a new 'refunded' status if added to enum)
    await db.execute(
        text(
            """
            UPDATE Payments 
            SET status = 'cancelled', paid_at = NULL 
            WHERE id = :id
            """
        ),
        {"id": payment_id},
    )
    
    await db.commit()
    
    return _payment(await _get_payment(db, payment_id))
