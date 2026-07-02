import uuid

import pytest
from fastapi import HTTPException
from sqlalchemy.ext.asyncio import AsyncSession

from src.organizations.membership_service import MembershipService
from src.organizations.repository import (
    OrganizationMemberRepository,
    OrganizationRepository,
)
from src.organizations.schemas import OrganizationCreate, OrganizationUpdate
from src.organizations.service import OrganizationService
from src.profiles.repository import UserProfileRepository
from src.profiles.schemas import UserProfileUpdate
from src.profiles.service import UserProfileService
from src.rbac.roles import ADMIN_ROLE_ID, MEMBER_ROLE_ID
from src.users.models import User, UserRole


@pytest.mark.anyio
async def test_organization_service(db_session: AsyncSession, test_user: User):
    org_repo = OrganizationRepository(db_session)
    member_repo = OrganizationMemberRepository(db_session)
    service = OrganizationService(org_repo, member_repo)
    user_id = test_user.id

    org_in = OrganizationCreate(name="Service Org", slug="service-org")
    org = await service.create_organization(org_in, user_id)

    # Check duplicate creation
    with pytest.raises(HTTPException) as exc:
        await service.create_organization(org_in, user_id)
    assert exc.value.status_code == 400

    # Get org
    fetched = await service.get_organization(org.id)
    assert fetched.name == "Service Org"

    # Get user orgs
    orgs = await service.get_user_organizations(user_id)
    assert len(orgs) == 1

    # Update org
    update_in = OrganizationUpdate(name="Updated Service Org")
    updated = await service.update_organization(org.id, update_in)
    assert updated.name == "Updated Service Org"

    # Get non-existent
    with pytest.raises(HTTPException):
        await service.get_organization(uuid.uuid4())


@pytest.mark.anyio
async def test_membership_service(db_session: AsyncSession, test_user: User):
    org_repo = OrganizationRepository(db_session)
    member_repo = OrganizationMemberRepository(db_session)
    org_service = OrganizationService(org_repo, member_repo)
    mem_service = MembershipService(member_repo)

    owner_id = test_user.id

    # Create member
    member_user = User(
        id=uuid.uuid4(),
        email="member@test.com",
        hashed_password="dummy_hash",
        role=UserRole.USER,
    )
    db_session.add(member_user)
    await db_session.commit()
    await db_session.refresh(member_user)
    user_id = member_user.id

    org_in = OrganizationCreate(name="Mem Service Org", slug="mem-service-org")
    org = await org_service.create_organization(org_in, owner_id)

    # Invite member
    member = await mem_service.invite_member(org.id, user_id, MEMBER_ROLE_ID)
    assert member.role_id == MEMBER_ROLE_ID

    # Duplicate invite
    with pytest.raises(HTTPException):
        await mem_service.invite_member(org.id, user_id, ADMIN_ROLE_ID)

    # Get members
    members = await mem_service.get_organization_members(org.id)
    assert len(members) == 2  # Owner + Member

    # Get membership
    membership = await mem_service.get_membership(org.id, user_id)
    assert membership is not None

    # Get missing membership
    with pytest.raises(HTTPException):
        await mem_service.get_membership(org.id, uuid.uuid4())

    # Remove member
    await mem_service.remove_member(org.id, user_id)
    with pytest.raises(HTTPException):
        await mem_service.get_membership(org.id, user_id)

    # Cannot remove last owner
    with pytest.raises(HTTPException):
        await mem_service.remove_member(org.id, owner_id)


@pytest.mark.anyio
async def test_user_profile_service(db_session: AsyncSession, test_user: User):
    repo = UserProfileRepository(db_session)
    service = UserProfileService(repo)
    user_id = test_user.id

    # Get auto-creates profile
    profile = await service.get_profile(user_id)
    assert profile.user_id == user_id

    # Update profile
    update_in = UserProfileUpdate(full_name="Service Profile")
    updated = await service.update_profile(user_id, update_in)
    assert updated.full_name == "Service Profile"
