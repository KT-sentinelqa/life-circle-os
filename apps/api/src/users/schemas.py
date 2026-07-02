from datetime import datetime
from uuid import UUID

from pydantic import BaseModel, ConfigDict, EmailStr

from src.users.models import UserRole


class UserBase(BaseModel):
    email: EmailStr
    full_name: str | None = None
    is_active: bool | None = True
    role: UserRole | None = UserRole.USER


class UserCreate(UserBase):
    password: str


class UserUpdate(BaseModel):
    email: EmailStr | None = None
    full_name: str | None = None
    password: str | None = None
    is_active: bool | None = None


class UserRead(UserBase):
    id: UUID
    created_at: datetime
    updated_at: datetime | None = None

    model_config = ConfigDict(from_attributes=True)
