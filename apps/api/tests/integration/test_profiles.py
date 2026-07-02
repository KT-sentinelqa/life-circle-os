import pytest
from httpx import AsyncClient

from src.users.models import User


@pytest.mark.anyio
async def test_get_my_profile(client: AsyncClient, test_user: User, test_user_token_headers: dict):
    response = await client.get("/api/v1/profile", headers=test_user_token_headers)
    assert response.status_code == 200
    data = response.json()
    assert data["user_id"] == str(test_user.id)
    assert data["full_name"] is None  # Auto-created is empty


@pytest.mark.anyio
async def test_update_my_profile(
    client: AsyncClient, test_user: User, test_user_token_headers: dict
):
    response = await client.put(
        "/api/v1/profile",
        json={"full_name": "Integration Profile", "timezone": "UTC"},
        headers=test_user_token_headers,
    )
    assert response.status_code == 200
    data = response.json()
    assert data["full_name"] == "Integration Profile"
    assert data["timezone"] == "UTC"
