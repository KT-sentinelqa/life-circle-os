import hashlib
import secrets
from datetime import UTC, datetime, timedelta
from uuid import UUID

from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from src.organizations.invitations.models import InvitationState, OrganizationInvitation


class InvitationRepository:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def create_invitation(
        self,
        organization_id: UUID,
        email: str,
        inviter_id: UUID,
        role_id: UUID,
        expires_in_days: int = 7,
    ) -> tuple[OrganizationInvitation, str]:
        raw_token = secrets.token_urlsafe(32)
        token_hash = hashlib.sha256(raw_token.encode("utf-8")).hexdigest()

        expires_at = datetime.now(UTC) + timedelta(days=expires_in_days)

        invitation = OrganizationInvitation(
            organization_id=organization_id,
            email=email,
            inviter_id=inviter_id,
            role_id=role_id,
            state=InvitationState.PENDING,
            token_hash=token_hash,
            expires_at=expires_at,
        )
        self.session.add(invitation)
        await self.session.flush()
        await self.session.refresh(invitation)
        return invitation, raw_token

    async def get_by_id(self, invitation_id: UUID) -> OrganizationInvitation | None:
        result = await self.session.execute(
            select(OrganizationInvitation).filter(OrganizationInvitation.id == invitation_id)
        )
        return result.scalars().first()

    async def get_by_token(self, raw_token: str) -> OrganizationInvitation | None:
        token_hash = hashlib.sha256(raw_token.encode("utf-8")).hexdigest()
        result = await self.session.execute(
            select(OrganizationInvitation).filter(OrganizationInvitation.token_hash == token_hash)
        )
        return result.scalars().first()

    async def get_pending_by_email(
        self, organization_id: UUID, email: str
    ) -> OrganizationInvitation | None:
        result = await self.session.execute(
            select(OrganizationInvitation).filter(
                OrganizationInvitation.organization_id == organization_id,
                OrganizationInvitation.email == email,
                OrganizationInvitation.state == InvitationState.PENDING,
            )
        )
        return result.scalars().first()

    async def transition_state(
        self, invitation: OrganizationInvitation, new_state: InvitationState
    ) -> OrganizationInvitation:
        # Enforce transitions: PENDING -> ACCEPTED, EXPIRED, REVOKED
        if invitation.state != InvitationState.PENDING:
            raise ValueError(f"Cannot transition invitation from {invitation.state} to {new_state}")

        if new_state not in (
            InvitationState.ACCEPTED,
            InvitationState.EXPIRED,
            InvitationState.REVOKED,
        ):
            raise ValueError(f"Invalid transition to {new_state}")

        invitation.state = new_state
        self.session.add(invitation)
        await self.session.flush()
        await self.session.refresh(invitation)
        return invitation
