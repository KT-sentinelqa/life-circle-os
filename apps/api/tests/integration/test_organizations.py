import uuid

import pytest
from httpx import AsyncClient
from sqlalchemy.ext.asyncio import AsyncSession

from src.rbac.roles import ADMIN_ROLE_ID, MEMBER_ROLE_ID, OWNER_ROLE_ID
from src.users.models import User, UserRole


@pytest.mark.anyio
async def test_create_organization(
    client: AsyncClient, test_user: User, test_user_token_headers: dict
):
    response = await client.post(
        "/api/v1/organizations",
        json={"name": "Test Org", "slug": "test-org"},
        headers=test_user_token_headers,
    )
    assert response.status_code == 201
    data = response.json()
    assert data["name"] == "Test Org"
    assert data["slug"] == "test-org"
    assert data["owner_id"] == str(test_user.id)
    org_id = data["id"]

    # Verify membership was created
    response = await client.get("/api/v1/organizations", headers=test_user_token_headers)
    assert response.status_code == 200
    orgs = response.json()
    assert len(orgs) > 0
    assert any(o["id"] == org_id for o in orgs)


@pytest.mark.anyio
async def test_get_organization(
    client: AsyncClient, test_user: User, test_user_token_headers: dict
):
    # Create Org
    response = await client.post(
        "/api/v1/organizations",
        json={"name": "Test Org 2", "slug": "test-org-2"},
        headers=test_user_token_headers,
    )
    org_id = response.json()["id"]

    # Get Org
    response = await client.get(f"/api/v1/organizations/{org_id}", headers=test_user_token_headers)
    assert response.status_code == 200
    assert response.json()["name"] == "Test Org 2"


@pytest.mark.anyio
async def test_invite_member_and_permissions(
    client: AsyncClient,
    test_user: User,
    test_user_token_headers: dict,
    db_session: AsyncSession,
):
    # 1. Create org
    response = await client.post(
        "/api/v1/organizations",
        json={"name": "Perm Test", "slug": "perm-test"},
        headers=test_user_token_headers,
    )
    org_id = response.json()["id"]

    # 2. Create another user in DB directly for test
    new_user = User(
        id=uuid.uuid4(),
        email="invited@example.com",
        hashed_password="fake",
        role=UserRole.USER,
    )
    db_session.add(new_user)
    await db_session.commit()

    # 3. Invite user as ADMIN
    response = await client.post(
        f"/api/v1/organizations/{org_id}/invite",
        json={"user_id": str(new_user.id), "role_id": str(ADMIN_ROLE_ID)},
        headers=test_user_token_headers,
    )
    assert response.status_code == 201

    # 4. Try duplicate invite
    response = await client.post(
        f"/api/v1/organizations/{org_id}/invite",
        json={"user_id": str(new_user.id), "role_id": str(MEMBER_ROLE_ID)},
        headers=test_user_token_headers,
    )
    assert response.status_code == 400
    assert "already a member" in response.json()["detail"]

    # 5. Remove member
    response = await client.delete(
        f"/api/v1/organizations/{org_id}/members/{str(new_user.id)}",
        headers=test_user_token_headers,
    )
    assert response.status_code == 204


@pytest.mark.anyio
async def test_unauthorized_access(
    client: AsyncClient,
    test_user: User,
    test_user_token_headers: dict,
    db_session: AsyncSession,
):
    # Create org as test_user
    response = await client.post(
        "/api/v1/organizations",
        json={"name": "Secure Org", "slug": "secure-org"},
        headers=test_user_token_headers,
    )
    org_id = response.json()["id"]

    # Create a completely different user
    new_user = User(
        id=uuid.uuid4(),
        email="hacker@example.com",
        hashed_password="fake",
        role=UserRole.USER,
    )
    db_session.add(new_user)
    await db_session.commit()

    from src.core.security import create_access_token

    hacker_token = create_access_token(subject=str(new_user.id), role=new_user.role.value)
    hacker_headers = {"Authorization": f"Bearer {hacker_token}"}

    # Hacker tries to get the org
    response = await client.get(f"/api/v1/organizations/{org_id}", headers=hacker_headers)
    assert response.status_code == 403

    # Hacker tries to invite someone
    response = await client.post(
        f"/api/v1/organizations/{org_id}/invite",
        json={"user_id": str(new_user.id), "role_id": str(OWNER_ROLE_ID)},
        headers=hacker_headers,
    )
    assert response.status_code == 403
