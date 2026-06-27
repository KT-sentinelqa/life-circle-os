from __future__ import annotations

import uuid
from datetime import UTC, datetime
from unittest.mock import patch

import httpx
import pytest
from httpx import ASGITransport
from jose import ExpiredSignatureError, JWTError

from lifecircle.domain.auth.entities import User, UserRole
from lifecircle.main import create_app

pytestmark = pytest.mark.asyncio


async def test_expired_token_returns_401() -> None:
    """Verify that an expired JWT token returns a 401 status with TOKEN_EXPIRED code."""
    app = create_app()
    with patch("lifecircle.presentation.api.v1.auth.router.jwt.decode") as mock_decode:
        mock_decode.side_effect = ExpiredSignatureError("Token expired")

        async with httpx.AsyncClient(
            transport=ASGITransport(app=app), base_url="http://testserver"
        ) as client:
            response = await client.post(
                "/api/v1/families",
                json={"name": "Test Family"},
                headers={"Authorization": "Bearer expired-token"},
            )
            assert response.status_code == 401
            assert response.json()["error"]["code"] == "TOKEN_EXPIRED"


async def test_invalid_token_returns_401() -> None:
    """Verify that an invalid JWT token returns a 401 status with TOKEN_INVALID code."""
    app = create_app()
    with patch("lifecircle.presentation.api.v1.auth.router.jwt.decode") as mock_decode:
        mock_decode.side_effect = JWTError("Invalid token")

        async with httpx.AsyncClient(
            transport=ASGITransport(app=app), base_url="http://testserver"
        ) as client:
            response = await client.post(
                "/api/v1/families",
                json={"name": "Test Family"},
                headers={"Authorization": "Bearer invalid-token"},
            )
            assert response.status_code == 401
            assert response.json()["error"]["code"] == "TOKEN_INVALID"


async def test_missing_bearer_prefix_returns_401() -> None:
    """Verify that a missing Bearer prefix returns a 401 status with MISSING_TOKEN code."""
    app = create_app()
    async with httpx.AsyncClient(
        transport=ASGITransport(app=app), base_url="http://testserver"
    ) as client:
        response = await client.post(
            "/api/v1/families",
            json={"name": "Test Family"},
            headers={"Authorization": "InvalidHeaderFormat"},
        )
        assert response.status_code == 401
        assert response.json()["error"]["code"] == "MISSING_TOKEN"


async def test_rate_limiter_fails_open_on_redis_error() -> None:
    """Verify that registration succeeds (fails open) if Redis connection fails."""
    app = create_app()
    with patch("redis.asyncio.from_url") as mock_from_url:
        mock_from_url.side_effect = Exception("Redis down")

        async with httpx.AsyncClient(
            transport=ASGITransport(app=app), base_url="http://testserver"
        ) as client:
            response = await client.post(
                "/api/v1/auth/register",
                json={
                    "email": "failsopen@qa-lifecircle.dev",
                    "password": "SecurePass123!",
                    "full_name": "Fails Open User",
                    "role": "guardian",
                },
            )
            # Should succeed or return duplicate, but not block with 429
            assert response.status_code in (201, 409)


async def test_login_success() -> None:
    """Verify that successful login returns 200 OK and valid JWT token."""
    app = create_app()
    mock_user = User(
        id=uuid.uuid4(),
        email="loginuser@qa-lifecircle.dev",
        password_hash="argon2id$hash",
        full_name="Login User",
        role=UserRole.GUARDIAN,
        is_verified=True,
        created_at=datetime.now(UTC),
        updated_at=datetime.now(UTC),
    )

    with (
        patch(
            "lifecircle.presentation.api.v1.auth.router.SqlAlchemyUserRepository.find_by_email",
            return_value=mock_user,
        ),
        patch(
            "lifecircle.presentation.api.v1.auth.router.VerifyPasswordUseCase.verify",
            return_value=True,
        ),
    ):
        async with httpx.AsyncClient(
            transport=ASGITransport(app=app), base_url="http://testserver"
        ) as client:
            response = await client.post(
                "/api/v1/auth/login",
                json={
                    "email": "loginuser@qa-lifecircle.dev",
                    "password": "SecurePassword123!",
                },
            )
            assert response.status_code == 200
            assert "access_token" in response.json()["data"]
            assert response.json()["data"]["user"]["email"] == "loginuser@qa-lifecircle.dev"


async def test_login_invalid_password() -> None:
    """Verify that login fails with 401 if password verification fails."""
    app = create_app()
    mock_user = User(
        id=uuid.uuid4(),
        email="loginuser@qa-lifecircle.dev",
        password_hash="argon2id$hash",
        full_name="Login User",
        role=UserRole.GUARDIAN,
        is_verified=True,
        created_at=datetime.now(UTC),
        updated_at=datetime.now(UTC),
    )

    with (
        patch(
            "lifecircle.presentation.api.v1.auth.router.SqlAlchemyUserRepository.find_by_email",
            return_value=mock_user,
        ),
        patch(
            "lifecircle.presentation.api.v1.auth.router.VerifyPasswordUseCase.verify",
            return_value=False,
        ),
    ):
        async with httpx.AsyncClient(
            transport=ASGITransport(app=app), base_url="http://testserver"
        ) as client:
            response = await client.post(
                "/api/v1/auth/login",
                json={
                    "email": "loginuser@qa-lifecircle.dev",
                    "password": "WrongPassword!",
                },
            )
            assert response.status_code == 401
            assert response.json()["error"]["code"] == "UNAUTHORIZED"


async def test_login_user_not_found() -> None:
    """Verify that login fails with 401 if user email is not found."""
    app = create_app()

    with patch(
        "lifecircle.presentation.api.v1.auth.router.SqlAlchemyUserRepository.find_by_email",
        return_value=None,
    ):
        async with httpx.AsyncClient(
            transport=ASGITransport(app=app), base_url="http://testserver"
        ) as client:
            response = await client.post(
                "/api/v1/auth/login",
                json={
                    "email": "nonexistent@qa-lifecircle.dev",
                    "password": "SecurePassword123!",
                },
            )
            assert response.status_code == 401
            assert response.json()["error"]["code"] == "UNAUTHORIZED"
