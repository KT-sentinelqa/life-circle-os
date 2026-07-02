from datetime import datetime
from uuid import UUID

from pydantic import BaseModel, ConfigDict


class UserProfileBase(BaseModel):
    full_name: str | None = None
    avatar_url: str | None = None
    timezone: str | None = None
    locale: str | None = None


class UserProfileCreate(UserProfileBase):
    user_id: UUID


class UserProfileUpdate(UserProfileBase):
    pass


class UserProfileRead(UserProfileBase):
    id: UUID
    user_id: UUID
    created_at: datetime
    updated_at: datetime

    model_config = ConfigDict(from_attributes=True)
