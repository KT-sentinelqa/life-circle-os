from uuid import UUID

from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from src.core.database import get_db
from src.core.dependencies import get_current_user
from src.notifications.repository import NotificationRepository
from src.notifications.schemas import NotificationRead
from src.notifications.service import NotificationService
from src.users.models import User

router = APIRouter(prefix="/notifications", tags=["Notifications"])


def get_notification_service(
    session: AsyncSession = Depends(get_db),
) -> NotificationService:
    return NotificationService(NotificationRepository(session))


@router.get("", response_model=list[NotificationRead])
async def get_notifications(
    limit: int = 50,
    skip: int = 0,
    unread_only: bool = False,
    current_user: User = Depends(get_current_user),
    service: NotificationService = Depends(get_notification_service),
) -> list[NotificationRead]:
    return await service.get_user_notifications(
        current_user.id, limit=limit, skip=skip, unread_only=unread_only
    )


@router.patch("/{id}/read", response_model=NotificationRead)
async def mark_notification_as_read(
    id: UUID,
    current_user: User = Depends(get_current_user),
    service: NotificationService = Depends(get_notification_service),
) -> NotificationRead:
    return await service.mark_notification_as_read(id, current_user.id)
