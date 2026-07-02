from datetime import UTC, datetime
from uuid import UUID

from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from src.notifications.models import Notification
from src.notifications.schemas import NotificationCreate


class NotificationRepository:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def get_user_notifications(
        self, user_id: UUID, limit: int = 50, skip: int = 0, unread_only: bool = False
    ) -> list[Notification]:
        stmt = select(Notification).filter(Notification.user_id == user_id)
        if unread_only:
            stmt = stmt.filter(Notification.is_read.is_(False))

        stmt = stmt.order_by(Notification.created_at.desc()).offset(skip).limit(limit)
        result = await self.session.execute(stmt)
        return list(result.scalars().all())

    async def get_by_id(self, notification_id: UUID) -> Notification | None:
        result = await self.session.execute(
            select(Notification).filter(Notification.id == notification_id)
        )
        return result.scalars().first()

    async def create(self, obj_in: NotificationCreate) -> Notification:
        db_obj = Notification(**obj_in.model_dump())
        self.session.add(db_obj)
        await self.session.flush()
        await self.session.refresh(db_obj)
        return db_obj

    async def mark_as_read(self, notification: Notification) -> Notification:
        notification.is_read = True
        notification.read_at = datetime.now(UTC)
        self.session.add(notification)
        await self.session.flush()
        await self.session.refresh(notification)
        return notification
