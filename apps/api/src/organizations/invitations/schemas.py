from datetime import datetime
from uuid import UUID

from pydantic import BaseModel, EmailStr

from src.organizations.invitations.models import InvitationState


class InvitationCreate(BaseModel):
    email: EmailStr
    role_id: UUID


class InvitationRead(BaseModel):
    id: UUID
    organization_id: UUID
    email: str
    inviter_id: UUID
    role_id: UUID
    state: InvitationState
    expires_at: datetime
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class InvitationAccept(BaseModel):
    token: str
