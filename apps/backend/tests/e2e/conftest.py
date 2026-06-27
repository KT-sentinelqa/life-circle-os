"""
LifeCircle OS — E2E test fixtures.

Provides a live httpx.AsyncClient pointed at the running local FastAPI server.
Requires:
  make dev-up && make migrate && make backend-dev  (in separate terminal)

These tests are marked @pytest.mark.integration and are excluded from the
default 'make backend-test' run. Run them explicitly with:
  make test-e2e

Governed by: docs/testing-pipeline.md | LC-S1-010
"""

from __future__ import annotations

import os
import uuid
from collections.abc import AsyncGenerator

import httpx
import pytest
import pytest_asyncio
from httpx import ASGITransport
from sqlalchemy import text

from lifecircle.config import get_settings
from lifecircle.infrastructure.database.connection import Base, build_engine

USE_LIVE_SERVER = os.getenv("E2E_USE_LIVE_SERVER", "false").lower() == "true"
BASE_URL = os.getenv("API_BASE_URL", "http://localhost:8000")


@pytest_asyncio.fixture(scope="session", autouse=True)
async def setup_database() -> None:
    """Ensure the database schema exists at the start of the E2E test session."""
    if not USE_LIVE_SERVER:
        settings = get_settings()
        engine = build_engine(settings)
        async with engine.begin() as conn:
            await conn.run_sync(Base.metadata.create_all)
        await engine.dispose()


@pytest_asyncio.fixture(autouse=True)
async def db_cleanup() -> AsyncGenerator[None, None]:
    """Truncate database tables and clear Redis rate limits.

    Runs before and after each test to ensure a clean slate.
    """
    if not USE_LIVE_SERVER:
        settings = get_settings()
        engine = build_engine(settings)

        async def _clean():
            # Clean Postgres
            async with engine.begin() as conn:
                await conn.execute(text("TRUNCATE TABLE families, users RESTART IDENTITY CASCADE;"))
            # Clean Redis
            import redis.asyncio as aioredis

            redis_client = aioredis.from_url(str(settings.redis_url))
            async with redis_client as r:
                keys = await r.keys("rl:*")
                if keys:
                    await r.delete(*keys)

        await _clean()
        yield
        await _clean()
        await engine.dispose()
    else:
        yield


@pytest_asyncio.fixture(scope="session", autouse=True)
async def preflight_check() -> None:
    """Preflight check to ensure the live backend is running if live testing is enabled."""
    if USE_LIVE_SERVER:
        try:
            async with httpx.AsyncClient(timeout=3.0) as client:
                response = await client.get(f"{BASE_URL}/health")
                if response.status_code != 200 or response.json().get("status") != "ok":
                    pytest.exit(
                        "Backend not running. " "Execute make backend-dev before running E2E tests."
                    )
        except Exception as exc:
            pytest.exit(
                "Backend not running. "
                "Execute make backend-dev before running E2E tests. "
                f"(Error: {exc})"
            )


@pytest_asyncio.fixture
async def live_client() -> AsyncGenerator[httpx.AsyncClient, None]:
    """Async HTTP client pointed at the FastAPI application.

    Uses ASGITransport(app=app) by default for self-contained E2E execution.
    If E2E_USE_LIVE_SERVER=true, connects to the live local server.
    """
    if USE_LIVE_SERVER:
        async with httpx.AsyncClient(
            base_url=BASE_URL,
            headers={
                "Content-Type": "application/json",
                "X-API-Version": "1.0.0",
            },
            timeout=15.0,
        ) as client:
            yield client
    else:
        from lifecircle.main import app

        async with httpx.AsyncClient(
            transport=ASGITransport(app=app),
            base_url="http://testserver",
            headers={
                "Content-Type": "application/json",
                "X-API-Version": "1.0.0",
            },
            timeout=15.0,
        ) as client:
            yield client


@pytest_asyncio.fixture
def unique_email() -> str:
    """Generate a unique email address for each test to prevent conflicts."""
    return f"e2e-{uuid.uuid4().hex[:8]}@qa-lifecircle.dev"


@pytest_asyncio.fixture
def valid_payload(unique_email: str) -> dict[str, str]:
    """A valid registration payload with a unique email."""
    return {
        "email": unique_email,
        "password": "SecureE2EPass123!",
        "full_name": "E2E Test User",
        "role": "guardian",
    }
