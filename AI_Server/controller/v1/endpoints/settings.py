from datetime import datetime

from fastapi import APIRouter, Depends
from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession

from controller.v1.dependencies import get_current_admin
from db.session import get_db
from schema.users import User
from schema.settings import SettingItem, SettingsUpdate


router = APIRouter(prefix="/admin/settings", tags=["Admin Settings"])


@router.get("", response_model=list[SettingItem])
async def list_settings(
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_admin),
):
    result = await db.execute(
        text("SELECT setting_key, setting_value, value_type, updated_at FROM SystemSettings ORDER BY setting_key")
    )
    return [
        SettingItem(key=row.setting_key, value=row.setting_value, value_type=row.value_type, updated_at=row.updated_at)
        for row in result
    ]


@router.put("", response_model=list[SettingItem])
async def update_settings(
    data: SettingsUpdate,
    db: AsyncSession = Depends(get_db),
    admin: User = Depends(get_current_admin),
):
    now = datetime.utcnow()
    for item in data.items:
        await db.execute(
            text(
                """
                INSERT INTO SystemSettings (setting_key, setting_value, value_type, updated_by, updated_at)
                VALUES (:key, :value, :value_type, :updated_by, :updated_at)
                ON DUPLICATE KEY UPDATE
                    setting_value = VALUES(setting_value),
                    value_type = VALUES(value_type),
                    updated_by = VALUES(updated_by),
                    updated_at = VALUES(updated_at)
                """
            ),
            {
                "key": item.key,
                "value": item.value,
                "value_type": item.value_type,
                "updated_by": admin.id,
                "updated_at": now,
            },
        )
    result = await db.execute(
        text("SELECT setting_key, setting_value, value_type, updated_at FROM SystemSettings ORDER BY setting_key")
    )
    return [
        SettingItem(key=row.setting_key, value=row.setting_value, value_type=row.value_type, updated_at=row.updated_at)
        for row in result
    ]
