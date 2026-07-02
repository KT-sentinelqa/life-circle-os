import pytest
from httpx import AsyncClient

from src.main import app


@pytest.mark.asyncio
async def test_health_live():
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.get("/health/live")
        assert response.status_code == 200
        data = response.json()
        assert data["status"] == "ok"
        assert data["service"] == "life-circle-api"


@pytest.mark.asyncio
async def test_health_ready(db_session, monkeypatch):
    # Mock get_redis to return a fake redis client
    class FakeRedis:
        async def ping(self):
            return True

    async def fake_get_redis():
        return FakeRedis()

    monkeypatch.setattr("src.health.router.get_redis", fake_get_redis)

    # We must patch get_db dependency to use the test session
    from src.core.database import get_db

    app.dependency_overrides[get_db] = lambda: db_session

    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.get("/health/ready")
        assert response.status_code == 200
        data = response.json()
        assert data["status"] == "ready"
        assert data["dependencies"]["postgres"] == "up"
        assert data["dependencies"]["redis"] == "up"

    app.dependency_overrides.clear()
