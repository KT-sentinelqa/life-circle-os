from __future__ import annotations

from unittest.mock import MagicMock, patch

import pytest

from lifecircle_frontend.config import get_settings
from lifecircle_frontend.services.auth_service import AuthService
from lifecircle_frontend.services.family_service import FamilyService


def test_settings_initialization() -> None:
    """Verify that settings load defaults correctly."""
    settings = get_settings()
    assert settings.backend_api_url == "http://localhost:8000"
    assert settings.port == 8080
    assert settings.cookie_secure is False
    assert settings.cookie_samesite == "lax"


@pytest.mark.asyncio
async def test_auth_service_register_with_correlation() -> None:
    """Verify that register service calls the backend API forwarding correlation ID headers."""
    service = AuthService()
    mock_response = MagicMock()
    mock_response.status_code = 201
    mock_response.json.return_value = {"success": True}

    with patch("httpx.AsyncClient.post", return_value=mock_response) as mock_post:
        res = await service.register({"email": "test@example.com"}, correlation_id="my-trace-id")
        assert res.status_code == 201
        assert res.json()["success"] is True
        mock_post.assert_called_once_with(
            "http://localhost:8000/api/v1/auth/register",
            json={"email": "test@example.com"},
            headers={"X-Correlation-ID": "my-trace-id"},
        )


@pytest.mark.asyncio
async def test_auth_service_login_with_correlation() -> None:
    """Verify that login service calls the backend API forwarding correlation ID headers."""
    service = AuthService()
    mock_response = MagicMock()
    mock_response.status_code = 200
    mock_response.json.return_value = {"token": "jwt-token"}

    with patch("httpx.AsyncClient.post", return_value=mock_response) as mock_post:
        res = await service.login({"email": "test@example.com"}, correlation_id="my-trace-id")
        assert res.status_code == 200
        assert res.json()["token"] == "jwt-token"
        mock_post.assert_called_once_with(
            "http://localhost:8000/api/v1/auth/login",
            json={"email": "test@example.com"},
            headers={"X-Correlation-ID": "my-trace-id"},
        )


@pytest.mark.asyncio
async def test_family_service_create() -> None:
    """Verify that create_family service passes JWT tokens in headers."""
    service = FamilyService()
    mock_response = MagicMock()
    mock_response.status_code = 201
    mock_response.json.return_value = {"id": "family-id"}

    with patch("httpx.AsyncClient.post", return_value=mock_response) as mock_post:
        res = await service.create_family(name="Test Family", token="jwt-token")
        assert res.status_code == 201
        assert res.json()["id"] == "family-id"
        mock_post.assert_called_once_with(
            "http://localhost:8000/api/v1/families",
            json={"name": "Test Family"},
            headers={"Authorization": "Bearer jwt-token"},
        )
