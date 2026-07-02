from datetime import datetime
from uuid import UUID

from pydantic import BaseModel, ConfigDict


class OrganizationBase(BaseModel):
    name: str


class OrganizationCreate(OrganizationBase):
    slug: str


class OrganizationUpdate(BaseModel):
    name: str | None = None
    slug: str | None = None


class OrganizationRead(OrganizationBase):
    id: UUID
    slug: str
    owner_id: UUID
    created_at: datetime
    updated_at: datetime

    model_config = ConfigDict(from_attributes=True)


class OrganizationMemberBase(BaseModel):
    pass


class OrganizationMemberCreate(OrganizationMemberBase):
    user_id: UUID
    role_id: UUID


class OrganizationMemberRead(OrganizationMemberBase):
    id: UUID
    organization_id: UUID
    user_id: UUID
    role_id: UUID
    role_name: str | None = None
    created_at: datetime

    model_config = ConfigDict(from_attributes=True)
