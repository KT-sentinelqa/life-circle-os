from typing import Any
from uuid import UUID

from fastapi import APIRouter, Depends, Request

from src.core.dependencies import get_current_user, get_invitation_service
from src.organizations.invitations.schemas import (
    InvitationAccept,
    InvitationCreate,
    InvitationRead,
)
from src.organizations.invitations.service import InvitationService
from src.users.models import User

# This router might be included under /organizations/{org_id}/invitations
router = APIRouter(tags=["Invitations"])


@router.post("/", response_model=InvitationRead)
async def create_invitation(
    org_id: UUID,
    invitation_in: InvitationCreate,
    request: Request,
    current_user: User = Depends(get_current_user),
    service: InvitationService = Depends(get_invitation_service),
) -> Any:
    """
    Invite a user to the organization.
    """
    app_url = str(request.base_url).rstrip("/")
    return await service.invite_member(
        org_id=org_id,
        inviter_id=current_user.id,
        invitation_in=invitation_in,
        app_url=app_url,
    )


@router.post("/accept", response_model=InvitationRead)
async def accept_invitation(
    accept_in: InvitationAccept,
    request: Request,
    current_user: User = Depends(get_current_user),
    service: InvitationService = Depends(get_invitation_service),
) -> Any:
    """
    Accept an invitation using the raw token.
    """
    return await service.accept_invitation(
        raw_token=accept_in.token,
        user_id=current_user.id,
    )


@router.post("/{invitation_id}/revoke", response_model=InvitationRead)
async def revoke_invitation(
    org_id: UUID,
    invitation_id: UUID,
    request: Request,
    current_user: User = Depends(get_current_user),
    service: InvitationService = Depends(get_invitation_service),
) -> Any:
    """
    Revoke a pending invitation.
    """
    return await service.revoke_invitation(invitation_id=invitation_id)
