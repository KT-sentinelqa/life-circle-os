from uuid import UUID

from fastapi import HTTPException, status

from src.notifications.models import Notification
from src.notifications.repository import NotificationRepository


class NotificationService:
    def __init__(self, repository: NotificationRepository):
        self.repository = repository

    async def get_user_notifications(
        self, user_id: UUID, limit: int = 50, skip: int = 0, unread_only: bool = False
    ) -> list[Notification]:
        return await self.repository.get_user_notifications(
            user_id, limit=limit, skip=skip, unread_only=unread_only
        )

    async def mark_notification_as_read(self, notification_id: UUID, user_id: UUID) -> Notification:
        notification = await self.repository.get_by_id(notification_id)
        if not notification:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail="Notification not found"
            )
        if notification.user_id != user_id:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Not authorized to access this notification",
            )

        if not notification.is_read:
            notification = await self.repository.mark_as_read(notification)
            await self.repository.session.commit()

        return notification
