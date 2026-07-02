from uuid import uuid4

import pytest
from sqlalchemy.ext.asyncio import AsyncSession

from src.organizations.invitations.models import InvitationState
from src.organizations.invitations.repository import InvitationRepository
from src.organizations.invitations.schemas import InvitationCreate
from src.organizations.invitations.service import InvitationService
from src.organizations.repository import (
    OrganizationMemberRepository,
    OrganizationRepository,
)
from src.rbac.models import Role
from src.users.repository import UserRepository


@pytest.fixture
async def rbac_setup(db_session: AsyncSession):
    from sqlalchemy import select

    result = await db_session.execute(
        select(Role).where(
            Role.name == "Admin",
            Role.organization_id.is_(None),
        )
    )
    role = result.scalar_one()
    return role


@pytest.fixture
async def invitation_service(db_session: AsyncSession):
    return InvitationService(
        InvitationRepository(db_session),
        OrganizationRepository(db_session),
        OrganizationMemberRepository(db_session),
        UserRepository(db_session),
    )


@pytest.mark.asyncio
async def test_invite_member(
    invitation_service: InvitationService,
    test_organization,
    test_user,
    rbac_setup,
):
    from sqlalchemy.future import select

    from src.outbox.models import OutboxEvent

    invite_in = InvitationCreate(email="newuser@example.com", role_id=rbac_setup.id)

    invitation = await invitation_service.invite_member(
        org_id=test_organization.id,
        inviter_id=test_user.id,
        invitation_in=invite_in,
        app_url="http://localhost:8000",
    )

    assert invitation.email == "newuser@example.com"
    assert invitation.state == InvitationState.PENDING

    # Assert outbox event was created for email delivery
    result = await invitation_service.invitation_repo.session.execute(
        select(OutboxEvent).filter_by(event_type="email_delivery_v1")
    )
    events = result.scalars().all()
    assert any(invitation.email in e.payload for e in events)


@pytest.mark.asyncio
async def test_accept_invitation(
    invitation_service: InvitationService,
    test_organization,
    test_user,
    rbac_setup,
):
    # Create invitation
    invite_in = InvitationCreate(email=test_user.email, role_id=rbac_setup.id)

    # We must mock or use the repo directly to get the token because test_user already exists
    # Wait, if test_user already exists, invite_member raises an error if they are in the org.
    # Let's create a fresh user for this test.
    from src.users.models import User

    new_user = User(id=uuid4(), email="invitee@example.com", hashed_password="fake", is_active=True)
    invitation_service.user_repo.session.add(new_user)
    await invitation_service.user_repo.session.commit()

    invite_in.email = "invitee@example.com"
    await invitation_service.invite_member(
        org_id=test_organization.id,
        inviter_id=test_user.id,
        invitation_in=invite_in,
        app_url="http://localhost",
    )

    # Get raw token directly from repo since it's only returned by the internal create_invitation
    raw_token = None
    # Instead of finding the token, let's just create it directly
    invitation_repo = invitation_service.invitation_repo
    inv, raw_token = await invitation_repo.create_invitation(
        test_organization.id, "acceptme@example.com", test_user.id, rbac_setup.id
    )

    accept_user = User(
        id=uuid4(), email="acceptme@example.com", hashed_password="fake", is_active=True
    )
    invitation_service.user_repo.session.add(accept_user)
    await invitation_service.user_repo.session.commit()

    accepted_inv = await invitation_service.accept_invitation(raw_token, accept_user.id)
    assert accepted_inv.state == InvitationState.ACCEPTED
