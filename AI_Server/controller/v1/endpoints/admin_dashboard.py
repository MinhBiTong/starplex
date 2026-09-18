from fastapi import APIRouter, Depends, Query
from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession

from controller.v1.dependencies import get_current_admin
from db.session import get_db
from schema.users import User


router = APIRouter(prefix="/admin/dashboard", tags=["Admin Dashboard"])


@router.get("/summary")
async def summary(db: AsyncSession = Depends(get_db), _: User = Depends(get_current_admin)):
    queries = {
        "users": "SELECT COUNT(*) FROM Users",
        "active_users": "SELECT COUNT(*) FROM Users WHERE status = 'active'",
        "generations": "SELECT COUNT(*) FROM Generations",
        "completed_generations": "SELECT COUNT(*) FROM Generations WHERE status = 'completed'",
        "payments": "SELECT COUNT(*) FROM Payments",
        "completed_payments": "SELECT COUNT(*) FROM Payments WHERE status = 'completed'",
        "credit_balance": "SELECT COALESCE(SUM(balance), 0) FROM CreditWallets",
    }
    result = {}
    for key, query in queries.items():
        result[key] = int((await db.execute(text(query))).scalar_one())
    revenue = await db.execute(text("SELECT COALESCE(SUM(amount), 0) FROM Payments WHERE status = 'completed'"))
    result["revenue"] = float(revenue.scalar_one())
    return result


@router.get("/generations")
async def generations(
    limit: int = Query(default=50, ge=1, le=200),
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    result = await db.execute(
        text(
            """
            SELECT g.id, g.user_id, u.full_name, u.email, g.type, g.prompt,
                   g.aspect_ratio, g.status, g.credit_cost, g.error_message,
                   g.created_at, g.completed_at, f.file_url
            FROM Generations g
            JOIN Users u ON u.id = g.user_id
            LEFT JOIN GenerationFiles f ON f.generation_id = g.id
            ORDER BY g.id DESC LIMIT :limit
            """
        ),
        {"limit": limit},
    )
    return [dict(row) for row in result.mappings()]


@router.get("/credits")
async def credits(
    limit: int = Query(default=50, ge=1, le=200),
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    result = await db.execute(
        text(
            """
            SELECT c.*, u.full_name, u.email
            FROM CreditTransactions c
            JOIN Users u ON u.id = c.user_id
            ORDER BY c.id DESC LIMIT :limit
            """
        ),
        {"limit": limit},
    )
    return [dict(row) for row in result.mappings()]
