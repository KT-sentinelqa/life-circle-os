from uuid import uuid4

import pytest
from httpx import AsyncClient
from sqlalchemy.ext.asyncio import AsyncSession

from src.notifications.models import Notification


@pytest.fixture
async def setup_notifications(db_session: AsyncSession, test_user):
    n1 = Notification(
        id=uuid4(),
        user_id=test_user.id,
        type="test",
        title="Test 1",
        message="Message 1",
        is_read=False,
    )
    n2 = Notification(
        id=uuid4(),
        user_id=test_user.id,
        type="test",
        title="Test 2",
        message="Message 2",
        is_read=True,
    )

    from src.users.models import User, UserRole

    other_user = User(
        id=uuid4(),
        email="other@example.com",
        hashed_password="fake",
        role=UserRole.USER,
        is_active=True,
    )
    db_session.add(other_user)
    await db_session.commit()

    n3 = Notification(
        id=uuid4(),
        user_id=other_user.id,
        type="test",
        title="Test 3",
        message="Message 3",
        is_read=False,
    )

    db_session.add(n1)
    db_session.add(n2)
    db_session.add(n3)
    await db_session.commit()

    return n1, n2, n3


@pytest.mark.asyncio
async def test_list_notifications(
    client: AsyncClient, test_user_token_headers, setup_notifications
):
    response = await client.get("/api/v1/notifications", headers=test_user_token_headers)
    assert response.status_code == 200
    data = response.json()
    assert len(data) == 2
    # Only test_user notifications should be returned, n3 is excluded
    assert any(n["title"] == "Test 1" for n in data)
    assert any(n["title"] == "Test 2" for n in data)
    assert not any(n["title"] == "Test 3" for n in data)


@pytest.mark.asyncio
async def test_mark_read(client: AsyncClient, test_user_token_headers, setup_notifications):
    n1, n2, n3 = setup_notifications

    response = await client.patch(
        f"/api/v1/notifications/{n1.id}/read", headers=test_user_token_headers
    )
    assert response.status_code == 200
    data = response.json()
    assert data["id"] == str(n1.id)
    assert data["is_read"] is True
    assert data["read_at"] is not None


@pytest.mark.asyncio
async def test_unauthorized_access(
    client: AsyncClient, test_user_token_headers, setup_notifications
):
    n1, n2, n3 = setup_notifications

    # Trying to mark another user's notification as read
    response = await client.patch(
        f"/api/v1/notifications/{n3.id}/read", headers=test_user_token_headers
    )
    assert response.status_code == 403


@pytest.mark.asyncio
async def test_mark_read_not_found(client: AsyncClient, test_user_token_headers):
    response = await client.patch(
        f"/api/v1/notifications/{uuid4()}/read", headers=test_user_token_headers
    )
    assert response.status_code == 404
