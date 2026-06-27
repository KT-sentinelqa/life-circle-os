"""
LifeCircle OS — E2E tests for the User Registration + Family Creation vertical slice.

Validates the complete flow from HTTP request through to database persistence,
event publication, and rollback path.

Requires a running local stack:
  make dev-up && make migrate && make backend-dev

Run with:
  make test-e2e

All tests are marked @pytest.mark.integration and excluded from unit test runs.

Governed by: docs/sprint-1-backlog.md §6 | docs/testing-pipeline.md | LC-S1-010
"""

from __future__ import annotations

import httpx
import pytest

pytestmark = [pytest.mark.integration, pytest.mark.asyncio]


# ── Health Check ──────────────────────────────────────────────────────────────


class TestHealthEndpoint:
    """Gate 0: The server must be reachable before all other E2E tests."""

    async def test_health_endpoint_returns_ok(self, live_client: httpx.AsyncClient) -> None:
        """GET /health must return 200 with status=ok."""
        response = await live_client.get("/health")
        assert response.status_code == 200
        body = response.json()
        assert body["status"] == "ok"


# ── User Registration Flow ────────────────────────────────────────────────────


class TestRegistrationFlow:
    """End-to-end validation of POST /api/v1/auth/register."""

    async def test_full_registration_returns_201_with_jwt(
        self,
        live_client: httpx.AsyncClient,
        valid_payload: dict[str, str],
    ) -> None:
        """Valid registration must return 201 with a JWT access token."""
        response = await live_client.post("/api/v1/auth/register", json=valid_payload)

        assert response.status_code == 201, response.text
        body = response.json()
        assert body["success"] is True
        data = body["data"]
        assert "user_id" in data
        assert data["email"] == valid_payload["email"]
        assert data["role"] == "guardian"
        assert "token" in data
        assert len(data["token"]) > 20, "Token appears too short"

    async def test_registration_response_has_standard_envelope(
        self,
        live_client: httpx.AsyncClient,
        valid_payload: dict[str, str],
    ) -> None:
        """Response must use the standard {success, data, meta} envelope."""
        response = await live_client.post("/api/v1/auth/register", json=valid_payload)
        body = response.json()

        assert "success" in body
        assert "data" in body
        assert "meta" in body

    async def test_registration_includes_correlation_id_header(
        self,
        live_client: httpx.AsyncClient,
        valid_payload: dict[str, str],
    ) -> None:
        """Response must include X-Correlation-ID header."""
        response = await live_client.post("/api/v1/auth/register", json=valid_payload)
        assert "x-correlation-id" in response.headers

    async def test_duplicate_email_returns_409(
        self,
        live_client: httpx.AsyncClient,
        valid_payload: dict[str, str],
    ) -> None:
        """Registering the same email twice must return 409 Conflict."""
        # First registration — must succeed
        r1 = await live_client.post("/api/v1/auth/register", json=valid_payload)
        assert r1.status_code == 201, f"First registration failed: {r1.text}"

        # Second registration — must conflict
        r2 = await live_client.post("/api/v1/auth/register", json=valid_payload)
        assert r2.status_code == 409
        body = r2.json()
        assert body["success"] is False
        assert body["error"]["code"] == "EMAIL_ALREADY_REGISTERED"

    async def test_weak_password_returns_400(
        self,
        live_client: httpx.AsyncClient,
        unique_email: str,
    ) -> None:
        """Registration with a weak password must return 400 Bad Request."""
        response = await live_client.post(
            "/api/v1/auth/register",
            json={
                "email": unique_email,
                "password": "weak",
                "full_name": "Weak Password",
                "role": "guardian",
            },
        )
        assert response.status_code in (400, 422), response.text

    async def test_invalid_email_returns_422(
        self,
        live_client: httpx.AsyncClient,
    ) -> None:
        """Malformed email must be rejected by Pydantic schema validation."""
        response = await live_client.post(
            "/api/v1/auth/register",
            json={
                "email": "not-an-email",
                "password": "SecurePass123!",
                "full_name": "Test User",
                "role": "guardian",
            },
        )
        assert response.status_code == 422


# ── Family Creation Flow ──────────────────────────────────────────────────────


class TestFamilyCreationFlow:
    """End-to-end validation of POST /api/v1/families."""

    async def test_guardian_can_create_family(
        self,
        live_client: httpx.AsyncClient,
        valid_payload: dict[str, str],
    ) -> None:
        """A registered guardian must be able to create a family."""
        # Register first
        reg_response = await live_client.post("/api/v1/auth/register", json=valid_payload)
        assert reg_response.status_code == 201
        token = reg_response.json()["data"]["token"]

        # Create family
        family_response = await live_client.post(
            "/api/v1/families",
            json={"name": "E2E Test Family"},
            headers={"Authorization": f"Bearer {token}"},
        )
        assert family_response.status_code == 201, family_response.text
        body = family_response.json()
        assert body["success"] is True
        data = body["data"]
        assert data["name"] == "E2E Test Family"
        assert "family_id" in data
        assert "owner_id" in data

    async def test_family_creation_without_jwt_returns_401(
        self,
        live_client: httpx.AsyncClient,
    ) -> None:
        """Family creation without Authorization header must return 401."""
        response = await live_client.post(
            "/api/v1/families",
            json={"name": "Unauthorized Family"},
        )
        assert response.status_code == 401


# ── Rate Limiting ─────────────────────────────────────────────────────────────


class TestRateLimiting:
    """Verify the sliding window rate limiter (5 req/min/IP)."""

    @pytest.mark.slow
    async def test_rate_limit_returns_429_on_sixth_request(
        self,
        live_client: httpx.AsyncClient,
    ) -> None:
        """The 6th registration attempt within 60 seconds must return 429."""
        import uuid as _uuid

        responses = []
        for i in range(6):
            r = await live_client.post(
                "/api/v1/auth/register",
                json={
                    "email": f"ratelimit-{_uuid.uuid4().hex[:6]}@qa-lifecircle.dev",
                    "password": "SecurePass123!",
                    "full_name": f"Rate Limit Test {i}",
                    "role": "guardian",
                },
            )
            responses.append(r.status_code)

        # At least one response must be 429
        assert 429 in responses, f"Expected a 429 rate limit response among {responses}"


# ── Sync Outbox ───────────────────────────────────────────────────────────────


class TestSyncOutbox:
    """Validate POST /api/v1/sync/outbox endpoint."""

    async def test_sync_outbox_accepts_valid_event(
        self,
        live_client: httpx.AsyncClient,
        valid_payload: dict[str, str],
    ) -> None:
        """A valid outbox event must be accepted with status='accepted'."""
        import uuid as _uuid

        # Register to get a JWT
        reg = await live_client.post("/api/v1/auth/register", json=valid_payload)
        assert reg.status_code == 201
        token = reg.json()["data"]["token"]
        user_id = reg.json()["data"]["user_id"]

        sync_response = await live_client.post(
            "/api/v1/sync/outbox",
            json={
                "events": [
                    {
                        "id": str(_uuid.uuid4()),
                        "event_type": "user.registered",
                        "payload": {"user_id": user_id},
                        "idempotency_key": f"reg-{user_id}",
                        "created_at": 1719403200000,
                    }
                ]
            },
            headers={"Authorization": f"Bearer {token}"},
        )
        assert sync_response.status_code == 200
        body = sync_response.json()
        assert body["success"] is True
        assert body["data"]["accepted_count"] >= 1

    async def test_sync_outbox_deduplicates_idempotent_replay(
        self,
        live_client: httpx.AsyncClient,
        valid_payload: dict[str, str],
    ) -> None:
        """Replaying the same idempotency_key must return status='duplicate'."""
        import uuid as _uuid

        reg = await live_client.post("/api/v1/auth/register", json=valid_payload)
        assert reg.status_code == 201
        token = reg.json()["data"]["token"]
        user_id = reg.json()["data"]["user_id"]

        event = {
            "id": str(_uuid.uuid4()),
            "event_type": "user.registered",
            "payload": {"user_id": user_id},
            "idempotency_key": f"idem-{user_id}",
            "created_at": 1719403200000,
        }
        headers = {"Authorization": f"Bearer {token}"}

        # First submission
        r1 = await live_client.post(
            "/api/v1/sync/outbox", json={"events": [event]}, headers=headers
        )
        assert r1.status_code == 200

        # Second submission — same idempotency_key
        r2 = await live_client.post(
            "/api/v1/sync/outbox", json={"events": [event]}, headers=headers
        )
        assert r2.status_code == 200
        body = r2.json()
        # At least one result must be a duplicate
        results = body["data"]["results"]
        statuses = [r["status"] for r in results]
        assert "duplicate" in statuses, f"Expected duplicate in {statuses}"
