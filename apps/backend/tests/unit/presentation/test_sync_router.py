from __future__ import annotations

import uuid
from collections.abc import Generator
from unittest.mock import patch

import httpx
import pytest
from fastapi import FastAPI
from httpx import ASGITransport

from lifecircle.main import create_app
from lifecircle.presentation.api.v1.auth.router import get_current_user_id

pytestmark = pytest.mark.asyncio


@pytest.fixture
def sync_app() -> Generator[FastAPI, None, None]:
    """Provide a FastAPI application instance with mocked authentication."""
    app = create_app()
    app.dependency_overrides[get_current_user_id] = lambda: uuid.uuid4()
    yield app
    app.dependency_overrides.clear()


async def test_sync_outbox_unauthorized() -> None:
    """Verify that a request without auth returns 401."""
    app = create_app()
    async with httpx.AsyncClient(
        transport=ASGITransport(app=app), base_url="http://testserver"
    ) as client:
        response = await client.post(
            "/api/v1/sync/outbox",
            json={
                "events": [
                    {
                        "id": "event-1",
                        "event_type": "user.registered",
                        "payload": {},
                        "idempotency_key": "idem-1",
                        "created_at": 1234567890,
                    }
                ]
            },
        )
        assert response.status_code == 401


async def test_sync_outbox_unsupported_event_type(sync_app: FastAPI) -> None:
    """Verify that unsupported event types are rejected in results envelope."""
    async with httpx.AsyncClient(
        transport=ASGITransport(app=sync_app), base_url="http://testserver"
    ) as client:
        response = await client.post(
            "/api/v1/sync/outbox",
            json={
                "events": [
                    {
                        "id": "event-1",
                        "event_type": "unknown.unsupported.type",
                        "payload": {},
                        "idempotency_key": "idem-1",
                        "created_at": 1234567890,
                    }
                ]
            },
            headers={"Authorization": "Bearer dummy-token"},
        )
        assert response.status_code == 200
        body = response.json()
        assert body["success"] is True
        results = body["data"]["results"]
        assert len(results) == 1
        assert results[0]["status"] == "rejected"
        assert "Unknown event type" in results[0]["reason"]


async def test_sync_outbox_redis_failure_fails_open(sync_app: FastAPI) -> None:
    """Verify that sync outbox fails open if Redis is down, accepting the events."""
    with patch("redis.asyncio.from_url") as mock_from_url:
        mock_from_url.side_effect = Exception("Redis error")

        async with httpx.AsyncClient(
            transport=ASGITransport(app=sync_app), base_url="http://testserver"
        ) as client:
            response = await client.post(
                "/api/v1/sync/outbox",
                json={
                    "events": [
                        {
                            "id": "event-2",
                            "event_type": "user.registered",
                            "payload": {"user_id": str(uuid.uuid4())},
                            "idempotency_key": "idem-2",
                            "created_at": 1234567890,
                        }
                    ]
                },
                headers={"Authorization": "Bearer dummy-token"},
            )
            assert response.status_code == 200
            body = response.json()
            assert body["success"] is True
            assert body["data"]["accepted_count"] == 1
