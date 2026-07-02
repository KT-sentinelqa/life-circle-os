import pytest
from sqlalchemy.ext.asyncio import AsyncSession

from src.organizations.repository import (
    OrganizationMemberRepository,
    OrganizationRepository,
)
from src.organizations.schemas import OrganizationCreate, OrganizationUpdate
from src.profiles.repository import UserProfileRepository
from src.profiles.schemas import UserProfileCreate, UserProfileUpdate
from src.rbac.roles import MEMBER_ROLE_ID
from src.users.models import User


@pytest.mark.anyio
async def test_organization_repository(db_session: AsyncSession, test_user: User):
    repo = OrganizationRepository(db_session)
    owner_id = test_user.id

    # Create
    org_in = OrganizationCreate(name="Repo Org", slug="repo-org")
    org = await repo.create(org_in, owner_id)
    assert org.id is not None
    assert org.slug == "repo-org"

    # Get by ID
    fetched = await repo.get_by_id(org.id)
    assert fetched is not None
    assert fetched.name == "Repo Org"

    # Get by Slug
    fetched = await repo.get_by_slug("repo-org")
    assert fetched is not None
    assert fetched.name == "Repo Org"

    # Update
    update_in = OrganizationUpdate(name="Updated Repo Org")
    updated = await repo.update(org, update_in)
    assert updated.name == "Updated Repo Org"
    assert updated.slug == "repo-org"  # unchanged

    # Delete
    await repo.delete(org.id)
    deleted = await repo.get_by_id(org.id)
    assert deleted is None


@pytest.mark.anyio
async def test_organization_member_repository(db_session: AsyncSession, test_user: User):
    repo = OrganizationMemberRepository(db_session)
    org_repo = OrganizationRepository(db_session)
    user_id = test_user.id

    org_in = OrganizationCreate(name="Member Org", slug="member-org")
    org = await org_repo.create(org_in, user_id)

    # Add member
    member = await repo.add_member(org.id, user_id, MEMBER_ROLE_ID)
    assert member.id is not None
    assert member.organization_id == org.id

    # Get membership
    membership = await repo.get_membership(org.id, user_id)
    assert membership is not None
    assert membership.role_id == MEMBER_ROLE_ID

    # Get by org
    members = await repo.get_members_by_organization(org.id)
    assert len(members) == 1

    # Get by user
    orgs = await repo.get_organizations_by_user(user_id)
    assert len(orgs) == 1

    # Remove member
    await repo.remove_member(org.id, user_id)
    membership = await repo.get_membership(org.id, user_id)
    assert membership is None


@pytest.mark.anyio
async def test_user_profile_repository(db_session: AsyncSession, test_user: User):
    repo = UserProfileRepository(db_session)
    user_id = test_user.id

    # Create
    profile_in = UserProfileCreate(user_id=user_id, full_name="Test Profile")
    profile = await repo.create(profile_in)
    assert profile.id is not None

    # Get
    fetched = await repo.get_by_user_id(user_id)
    assert fetched is not None
    assert fetched.full_name == "Test Profile"

    # Update
    update_in = UserProfileUpdate(full_name="Updated Profile")
    updated = await repo.update(profile, update_in)
    assert updated.full_name == "Updated Profile"
