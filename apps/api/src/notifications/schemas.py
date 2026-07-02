from datetime import datetime
from uuid import UUID

from pydantic import BaseModel, ConfigDict


class NotificationBase(BaseModel):
    type: str
    channel: str = "in-app"
    title: str
    message: str
    link: str | None = None


class NotificationCreate(NotificationBase):
    user_id: UUID


class NotificationRead(NotificationBase):
    id: UUID
    user_id: UUID
    is_read: bool
    read_at: datetime | None
    created_at: datetime

    model_config = ConfigDict(from_attributes=True)


class NotificationUpdate(BaseModel):
    is_read: bool
