from __future__ import annotations

from unittest.mock import patch

import httpx
import pytest
from fastapi import FastAPI
from httpx import ASGITransport

from lifecircle.config import Settings
from lifecircle.main import create_app


@pytest.mark.asyncio
async def test_create_app() -> None:
    """Verify that create_app builds a valid FastAPI instance with correct titles."""
    app = create_app()
    assert isinstance(app, FastAPI)
    assert app.title == "LifeCircle OS API"


@pytest.mark.asyncio
async def test_health_check() -> None:
    """Verify health probe returns status=ok."""
    app = create_app()
    async with httpx.AsyncClient(
        transport=ASGITransport(app=app), base_url="http://testserver"
    ) as client:
        response = await client.get("/health")
        assert response.status_code == 200
        assert response.json()["status"] == "ok"


@pytest.mark.asyncio
async def test_unhandled_exception_handler() -> None:
    """Verify that unhandled exceptions are caught by the global error envelope middleware."""
    app = create_app()

    @app.get("/test-unhandled-error")
    async def trigger_error() -> None:
        raise ValueError("Simulated unhandled exception")

    async with httpx.AsyncClient(
        transport=ASGITransport(app=app, raise_app_exceptions=False),
        base_url="http://testserver",
    ) as client:
        response = await client.get("/test-unhandled-error")
        assert response.status_code == 500
        body = response.json()
        assert body["success"] is False
        assert body["error"]["code"] == "INTERNAL_SERVER_ERROR"
        assert body["error"]["message"] == "An unexpected error occurred."


@pytest.mark.asyncio
async def test_app_lifespan() -> None:
    """Verify that create_app starts up and shuts down OTel and lifespan hooks cleanly."""
    app = create_app()
    async with app.router.lifespan_context(app):
        # Lifespan startup hooks have run
        pass


@pytest.mark.asyncio
async def test_app_lifespan_otel_failure() -> None:
    """Verify that OTel instrumentation failures fail open gracefully."""
    import sys
    from unittest.mock import MagicMock

    mock_module = MagicMock()
    mock_module.FastAPIInstrumentor.instrument_app.side_effect = Exception("Instrument fail")

    with patch.dict(
        sys.modules,
        {"opentelemetry.instrumentation.fastapi": mock_module},
    ):
        app = create_app()
        async with app.router.lifespan_context(app):
            pass


def test_create_app_local_env() -> None:
    """Verify create_app registers CORS middleware in local environment."""
    local_settings = Settings(app_env="local")
    with patch("lifecircle.main.get_settings", return_value=local_settings):
        app = create_app()
        # Verify that CORSMiddleware is in app's middleware stack
        middleware_names = [m.cls.__name__ for m in app.user_middleware]
        assert "CORSMiddleware" in middleware_names


@pytest.mark.asyncio
async def test_validation_exception_handler() -> None:
    """Verify that validation errors return a standard 422 validation error response."""
    app = create_app()
    async with httpx.AsyncClient(
        transport=ASGITransport(app=app), base_url="http://testserver"
    ) as client:
        # Invalid registration payload (email formatting validation failure)
        response = await client.post(
            "/api/v1/auth/register",
            json={
                "email": "bademail",
                "password": "123",
                "full_name": "A",
                "role": "guardian",
            },
        )
        assert response.status_code == 422
        body = response.json()
        assert body["success"] is False
        assert body["error"]["code"] == "VALIDATION_FAILED"
        assert "Request validation failed" in body["error"]["message"]


@pytest.mark.asyncio
async def test_http_exception_handler() -> None:
    """Verify that HTTPExceptions return the standard error response envelope."""
    app = create_app()
    async with httpx.AsyncClient(
        transport=ASGITransport(app=app), base_url="http://testserver"
    ) as client:
        # Missing Authorization header on protected route raises HTTPException
        response = await client.post("/api/v1/families", json={"name": "Test Family"})
        assert response.status_code == 401
        body = response.json()
        assert body["success"] is False
        assert body["error"]["code"] == "MISSING_TOKEN"
