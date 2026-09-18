from datetime import datetime

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession

from controller.v1.dependencies import get_current_admin
from db.session import get_db
from schema.users import User
from schema.payment_packages import (
    PaymentPackageCreate,
    PaymentPackageResult,
    PaymentPackageUpdate,
)


router = APIRouter(prefix="/admin/payment-packages", tags=["Admin Payment Packages"])
public_router = APIRouter(prefix="/payment-packages", tags=["Payment Packages"])


async def _benefits(db: AsyncSession, package_id: int) -> list[str]:
    result = await db.execute(
        text(
            """
            SELECT benefit
            FROM PaymentPackageBenefits
            WHERE package_id = :package_id
            ORDER BY sort_order, id
            """
        ),
        {"package_id": package_id},
    )
    return [row[0] for row in result.fetchall()]


def _as_bool(value) -> bool:
    if isinstance(value, (bytes, bytearray)):
        return value != b"\x00"
    return bool(value)


def _package(row, benefits: list[str]) -> PaymentPackageResult:
    return PaymentPackageResult(
        id=row.id,
        name=row.name,
        price=float(row.price),
        currency=row.currency,
        credit_amount=row.credit_amount,
        description=row.description,
        is_active=_as_bool(row.is_active),
        billing_period=row.billing_period,
        is_featured=_as_bool(row.is_featured),
        benefits=benefits,
        created_at=row.created_at,
        updated_at=row.updated_at,
    )


async def _get_package(db: AsyncSession, package_id: int):
    result = await db.execute(
        text("SELECT * FROM PaymentPackages WHERE id = :id"), {"id": package_id}
    )
    return result.mappings().one_or_none()


async def _replace_benefits(db: AsyncSession, package_id: int, benefits: list[str]) -> None:
    await db.execute(
        text("DELETE FROM PaymentPackageBenefits WHERE package_id = :package_id"),
        {"package_id": package_id},
    )
    for index, benefit in enumerate(benefits):
        value = benefit.strip()
        if not value:
            continue
        await db.execute(
            text(
                """
                INSERT INTO PaymentPackageBenefits
                    (package_id, benefit, sort_order, created_at)
                VALUES (:package_id, :benefit, :sort_order, :created_at)
                """
            ),
            {
                "package_id": package_id,
                "benefit": value,
                "sort_order": index,
                "created_at": datetime.utcnow(),
            },
        )


@router.get("", response_model=list[PaymentPackageResult])
async def list_packages(
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    result = await db.execute(text("SELECT * FROM PaymentPackages ORDER BY is_featured DESC, id DESC"))
    rows = result.mappings().all()
    return [_package(row, await _benefits(db, row.id)) for row in rows]


@public_router.get("/active", response_model=list[PaymentPackageResult])
async def list_active_packages(db: AsyncSession = Depends(get_db)):
    result = await db.execute(text("SELECT * FROM PaymentPackages WHERE is_active = 1 ORDER BY is_featured DESC, id DESC"))
    rows = result.mappings().all()
    return [_package(row, await _benefits(db, row.id)) for row in rows]


@router.get("/{package_id}", response_model=PaymentPackageResult)
async def get_package(
    package_id: int,
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    row = await _get_package(db, package_id)
    if row is None:
        raise HTTPException(status_code=404, detail="Payment package not found")
    return _package(row, await _benefits(db, package_id))


@router.post("", response_model=PaymentPackageResult, status_code=status.HTTP_201_CREATED)
async def create_package(
    data: PaymentPackageCreate,
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    now = datetime.utcnow()
    await db.execute(
        text(
            """
            INSERT INTO PaymentPackages
                (name, price, currency, credit_amount, description,
                 is_active, billing_period, is_featured, created_at, updated_at)
            VALUES
                (:name, :price, :currency, :credit_amount, :description,
                 :is_active, :billing_period, :is_featured, :created_at, NULL)
            """
        ),
        {**data.model_dump(exclude={"benefits"}), "created_at": now},
    )
    package_id = int((await db.execute(text("SELECT LAST_INSERT_ID()"))).scalar_one())
    await _replace_benefits(db, package_id, data.benefits)
    row = await _get_package(db, package_id)
    return _package(row, await _benefits(db, package_id))


@router.put("/{package_id}", response_model=PaymentPackageResult)
async def update_package(
    package_id: int,
    data: PaymentPackageUpdate,
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    if await _get_package(db, package_id) is None:
        raise HTTPException(status_code=404, detail="Payment package not found")
    await db.execute(
        text(
            """
            UPDATE PaymentPackages
            SET name = :name, price = :price, currency = :currency,
                credit_amount = :credit_amount, description = :description,
                is_active = :is_active, billing_period = :billing_period,
                is_featured = :is_featured, updated_at = :updated_at
            WHERE id = :id
            """
        ),
        {"id": package_id, **data.model_dump(exclude={"benefits"}), "updated_at": datetime.utcnow()},
    )
    await _replace_benefits(db, package_id, data.benefits)
    row = await _get_package(db, package_id)
    return _package(row, await _benefits(db, package_id))


@router.patch("/{package_id}/status", response_model=PaymentPackageResult)
async def update_package_status(
    package_id: int,
    is_active: bool,
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    row = await _get_package(db, package_id)
    if row is None:
        raise HTTPException(status_code=404, detail="Payment package not found")
    await db.execute(
        text("UPDATE PaymentPackages SET is_active = :is_active, updated_at = :updated_at WHERE id = :id"),
        {"id": package_id, "is_active": is_active, "updated_at": datetime.utcnow()},
    )
    row = await _get_package(db, package_id)
    return _package(row, await _benefits(db, package_id))


@router.delete("/{package_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_package(
    package_id: int,
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    if await _get_package(db, package_id) is None:
        raise HTTPException(status_code=404, detail="Payment package not found")
    payment_count = await db.execute(
        text("SELECT COUNT(*) FROM Payments WHERE package_id = :id"), {"id": package_id}
    )
    if payment_count.scalar_one() > 0:
        raise HTTPException(status_code=409, detail="Package has payment history; deactivate it instead")
    await db.execute(text("DELETE FROM PaymentPackageBenefits WHERE package_id = :id"), {"id": package_id})
    await db.execute(text("DELETE FROM PaymentPackages WHERE id = :id"), {"id": package_id})
