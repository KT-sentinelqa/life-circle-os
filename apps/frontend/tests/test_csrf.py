from __future__ import annotations

from unittest.mock import MagicMock, patch

import pytest
from fastapi.testclient import TestClient


def test_csrf_cookie_generated_on_get(client: TestClient) -> None:
    """Verify that a GET request sets the lifecircle_csrf cookie."""
    response = client.get("/login")
    assert response.status_code == 200
    assert "lifecircle_csrf" in response.cookies
    assert len(response.cookies["lifecircle_csrf"]) > 0


def test_csrf_post_without_cookie_fails(client: TestClient) -> None:
    """Verify that POST request without lifecircle_csrf cookie fails with 403."""
    response = client.post(
        "/login", data={"email": "test@example.com", "password": "SecurePassword123!"}
    )
    assert response.status_code == 403
    assert "CSRF token validation failed." in response.json()["detail"]


def test_csrf_post_mismatch_fails(client: TestClient) -> None:
    """Verify that POST request with mismatching CSRF token fails with 403."""
    client.cookies.update({"lifecircle_csrf": "correct-token"})
    data = {
        "csrf_token": "wrong-token",
        "email": "test@example.com",
        "password": "SecurePassword123!",
    }
    response = client.post("/login", data=data)
    assert response.status_code == 403
    assert "CSRF token validation failed." in response.json()["detail"]


@pytest.mark.asyncio
async def test_csrf_post_matching_form_header_passes(client: TestClient) -> None:
    """Verify that POST request with matching token via form header passes validation."""
    mock_res = MagicMock()
    mock_res.status_code = 401
    mock_res.json.return_value = {"error": "unauthorized"}

    client.cookies.update({"lifecircle_csrf": "matching-token"})
    headers = {"X-CSRF-Token": "matching-token"}
    data = {"email": "test@example.com", "password": "SecurePassword123!"}

    with patch("lifecircle_frontend.routes.auth.AuthService.login", return_value=mock_res):
        response = client.post("/login", headers=headers, data=data)
        # Should bypass CSRF check and hit route handler (which returns 200 with errors payload)
        assert response.status_code == 200


def test_csrf_post_with_non_string_token_fails(client: TestClient) -> None:
    """Verify that a POST request with an invalid/mismatching token fails."""
    client.cookies.update({"lifecircle_csrf": "some-csrf-token"})
    response = client.post(
        "/login",
        data={"csrf_token": ""},
        headers={"X-CSRF-Token": "mismatch-or-missing"},
    )
    assert response.status_code == 403
