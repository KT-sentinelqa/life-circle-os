from datetime import UTC, datetime
from uuid import UUID

from fastapi import HTTPException, status

from src.organizations.invitations.models import InvitationState, OrganizationInvitation
from src.organizations.invitations.repository import InvitationRepository
from src.organizations.invitations.schemas import InvitationCreate
from src.organizations.repository import (
    OrganizationMemberRepository,
    OrganizationRepository,
)
from src.rbac.models import Role
from src.users.repository import UserRepository


class InvitationService:
    def __init__(
        self,
        invitation_repo: InvitationRepository,
        org_repo: OrganizationRepository,
        member_repo: OrganizationMemberRepository,
        user_repo: UserRepository,
    ):
        self.invitation_repo = invitation_repo
        self.org_repo = org_repo
        self.member_repo = member_repo
        self.user_repo = user_repo

    async def invite_member(
        self,
        org_id: UUID,
        inviter_id: UUID,
        invitation_in: InvitationCreate,
        app_url: str,
    ) -> OrganizationInvitation:
        # Check if user is already a member
        user = await self.user_repo.get_by_email(invitation_in.email)
        if user:
            existing_member = await self.member_repo.get_membership(org_id, user.id)
            if existing_member:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="User is already a member of this organization",
                )

        # Check for pending invitation
        pending_invite = await self.invitation_repo.get_pending_by_email(
            org_id, invitation_in.email
        )
        if pending_invite:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="A pending invitation already exists for this email",
            )

        # Ensure role exists and belongs to this organization (or is system default)
        from sqlalchemy.future import select

        role_result = await self.invitation_repo.session.execute(
            select(Role).filter(Role.id == invitation_in.role_id)
        )
        role = role_result.scalars().first()
        if not role or (role.organization_id is not None and role.organization_id != org_id):
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Invalid role",
            )

        invitation, raw_token = await self.invitation_repo.create_invitation(
            organization_id=org_id,
            email=invitation_in.email,
            inviter_id=inviter_id,
            role_id=invitation_in.role_id,
        )

        org = await self.org_repo.get_by_id(org_id)

        # Publish email event to outbox
        invite_link = f"{app_url}/accept-invitation?token={raw_token}"
        from src.outbox.publisher import publish_event
        from src.outbox.schemas import EmailDeliveryEventV1

        email_event = EmailDeliveryEventV1(
            to_email=invitation.email,
            subject=f"You have been invited to {org.name if org else str(org_id)}",
            template_name="organization_invitation",
            template_context={
                "organization_name": org.name if org else str(org_id),
                "invitation_link": invite_link,
            },
        )

        publish_event(
            session=self.invitation_repo.session,
            aggregate_type="invitation",
            aggregate_id=str(invitation.id),
            event=email_event,
        )

        await self.invitation_repo.session.commit()
        return invitation

    async def accept_invitation(self, raw_token: str, user_id: UUID) -> OrganizationInvitation:
        invitation = await self.invitation_repo.get_by_token(raw_token)
        if not invitation:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail="Invitation not found"
            )

        if invitation.state != InvitationState.PENDING:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Invitation is not pending",
            )

        if invitation.expires_at < datetime.now(UTC):
            await self.invitation_repo.transition_state(invitation, InvitationState.EXPIRED)
            await self.invitation_repo.session.commit()
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST, detail="Invitation has expired"
            )

        user = await self.user_repo.get_by_id(user_id)
        if not user or user.email != invitation.email:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Invitation email does not match user email",
            )

        # Add user to organization
        from src.organizations.models import OrganizationMember

        member = OrganizationMember(
            organization_id=invitation.organization_id,
            user_id=user_id,
            role_id=invitation.role_id,
        )
        self.member_repo.session.add(member)

        await self.invitation_repo.transition_state(invitation, InvitationState.ACCEPTED)
        await self.invitation_repo.session.commit()

        return invitation

    async def revoke_invitation(self, invitation_id: UUID) -> OrganizationInvitation:
        invitation = await self.invitation_repo.get_by_id(invitation_id)
        if not invitation:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail="Invitation not found"
            )

        try:
            await self.invitation_repo.transition_state(invitation, InvitationState.REVOKED)
            await self.invitation_repo.session.commit()
        except ValueError as e:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=str(e)) from e

        return invitation
