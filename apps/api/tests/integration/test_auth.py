import pytest
from httpx import AsyncClient

from src.users.models import User


@pytest.mark.anyio
async def test_register_user(client: AsyncClient):
    response = await client.post(
        "/api/v1/auth/register",
        json={
            "email": "newuser@example.com",
            "password": "strongpassword123",
            "full_name": "New User",
        },
    )
    assert response.status_code == 201
    data = response.json()
    assert data["email"] == "newuser@example.com"
    assert "id" in data


@pytest.mark.anyio
async def test_login_user(client: AsyncClient, test_user: User):
    response = await client.post(
        "/api/v1/auth/login",
        data={"username": "test@example.com", "password": "supersecret"},
    )
    assert response.status_code == 200
    data = response.json()
    assert "access_token" in data
    assert "refresh_token" in data


@pytest.mark.anyio
async def test_refresh_token(client: AsyncClient, test_user: User):
    # First login
    login_resp = await client.post(
        "/api/v1/auth/login",
        data={"username": "test@example.com", "password": "supersecret"},
    )
    assert login_resp.status_code == 200
    tokens = login_resp.json()
    refresh_token = tokens["refresh_token"]

    # Now refresh
    refresh_resp = await client.post("/api/v1/auth/refresh", json={"refresh_token": refresh_token})
    assert refresh_resp.status_code == 200
    new_tokens = refresh_resp.json()
    assert "access_token" in new_tokens
    assert "refresh_token" in new_tokens
    assert new_tokens["refresh_token"] != refresh_token


@pytest.mark.anyio
async def test_logout(client: AsyncClient, test_user: User):
    login_resp = await client.post(
        "/api/v1/auth/login",
        data={"username": "test@example.com", "password": "supersecret"},
    )
    assert login_resp.status_code == 200
    tokens = login_resp.json()

    # Try logout
    logout_resp = await client.post(
        "/api/v1/auth/logout",
        headers={"Authorization": f"Bearer {tokens['access_token']}"},
        json={"refresh_token": tokens["refresh_token"]},
    )
    assert logout_resp.status_code == 204

    # Using the same access token on a protected route should now fail
    # because it is blacklisted (if blacklisting is fake, FakeBlacklist handles it)
    me_resp = await client.get(
        "/api/v1/profile", headers={"Authorization": f"Bearer {tokens['access_token']}"}
    )
    assert me_resp.status_code == 401


@pytest.mark.anyio
async def test_verify_email_stub(client: AsyncClient):
    response = await client.post("/api/v1/auth/verify-email", json={"token": "some-token"})
    assert response.status_code == 200


@pytest.mark.anyio
async def test_reset_password_stub(client: AsyncClient):
    response = await client.post("/api/v1/auth/reset-password", json={"email": "test@example.com"})
    assert response.status_code == 200


@pytest.mark.anyio
async def test_audit_logs_created(client: AsyncClient, test_user: User, db_session):
    from sqlalchemy.future import select

    from src.outbox.models import OutboxEvent

    # Login
    login_resp = await client.post(
        "/api/v1/auth/login",
        data={"username": "test@example.com", "password": "supersecret"},
    )
    assert login_resp.status_code == 200

    # Check DB for login outbox event
    result = await db_session.execute(select(OutboxEvent).filter_by(event_type="audit_log_v1"))
    events = result.scalars().all()
    # At least one event for login
    assert any("login" in e.payload for e in events)

    tokens = login_resp.json()

    # Logout
    logout_resp = await client.post(
        "/api/v1/auth/logout",
        headers={"Authorization": f"Bearer {tokens['access_token']}"},
        json={"refresh_token": tokens["refresh_token"]},
    )
    assert logout_resp.status_code == 204

    # Check DB for logout outbox event
    result = await db_session.execute(select(OutboxEvent).filter_by(event_type="audit_log_v1"))
    events = result.scalars().all()
    # At least one event for logout
    assert any("logout" in e.payload for e in events)
