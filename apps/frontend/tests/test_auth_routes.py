from __future__ import annotations

from unittest.mock import MagicMock, patch

import pytest
from fastapi.testclient import TestClient


def test_login_page_renders(client: TestClient) -> None:
    """Verify GET /login returns 200 and loads page."""
    response = client.get("/login")
    assert response.status_code == 200
    assert "Welcome Back" in response.text


def test_register_page_renders(client: TestClient) -> None:
    """Verify GET /register returns 200 and loads page."""
    response = client.get("/register")
    assert response.status_code == 200
    assert "Create Account" in response.text


@pytest.mark.asyncio
async def test_login_action_success(client: TestClient) -> None:
    """Verify POST /login with valid payload sets session cookie and redirects."""
    mock_res = MagicMock()
    mock_res.status_code = 200
    mock_res.json.return_value = {
        "data": {
            "access_token": "valid-session-jwt",
            "token_type": "bearer",
            "user": {
                "user_id": "89078d46-bc5b-42ea-a417-21a41285ab32",
                "email": "guardian@example.com",
                "full_name": "Krishna Tiwari",
                "role": "guardian",
            },
        }
    }

    client.cookies.update({"lifecircle_csrf": "my-csrf-token"})
    data = {
        "csrf_token": "my-csrf-token",
        "email": "guardian@example.com",
        "password": "SecurePassword123!",
    }

    with patch(
        "lifecircle_frontend.routes.auth.AuthService.login", return_value=mock_res
    ) as mock_login:
        response = client.post("/login", data=data, follow_redirects=False)
        assert response.status_code == 303
        assert response.headers["location"] == "/dashboard"
        assert "lifecircle_session" in response.cookies
        assert response.cookies["lifecircle_session"] == "valid-session-jwt"
        mock_login.assert_called_once()


@pytest.mark.asyncio
async def test_login_action_htmx_success(client: TestClient) -> None:
    """Verify POST /login with HTMX headers returns HX-Redirect."""
    mock_res = MagicMock()
    mock_res.status_code = 200
    mock_res.json.return_value = {
        "data": {
            "access_token": "valid-session-jwt",
            "token_type": "bearer",
            "user": {
                "user_id": "89078d46-bc5b-42ea-a417-21a41285ab32",
                "email": "guardian@example.com",
                "full_name": "Krishna Tiwari",
                "role": "guardian",
            },
        }
    }

    client.cookies.update({"lifecircle_csrf": "my-csrf-token"})
    data = {
        "csrf_token": "my-csrf-token",
        "email": "guardian@example.com",
        "password": "SecurePassword123!",
    }

    with patch(
        "lifecircle_frontend.routes.auth.AuthService.login", return_value=mock_res
    ) as mock_login:
        headers = {"hx-request": "true"}
        response = client.post("/login", data=data, headers=headers)
        assert response.status_code == 200
        assert response.headers["HX-Redirect"] == "/dashboard"
        mock_login.assert_called_once()


@pytest.mark.asyncio
async def test_login_action_failure_missing_inputs(client: TestClient) -> None:
    """Verify POST /login with missing inputs returns inline errors."""
    client.cookies.update({"lifecircle_csrf": "my-csrf-token"})
    data = {"csrf_token": "my-csrf-token", "email": "", "password": ""}
    response = client.post("/login", data=data)
    assert response.status_code == 200
    assert "Email is required." in response.text
    assert "Password is required." in response.text


@pytest.mark.asyncio
async def test_login_action_failure_invalid_credentials(client: TestClient) -> None:
    """Verify POST /login with invalid credentials returns inline alert."""
    mock_res = MagicMock()
    mock_res.status_code = 401
    mock_res.json.return_value = {"error": "Invalid email or password"}

    client.cookies.update({"lifecircle_csrf": "my-csrf-token"})
    data = {
        "csrf_token": "my-csrf-token",
        "email": "wrong@example.com",
        "password": "WrongPassword123!",
    }

    with patch("lifecircle_frontend.routes.auth.AuthService.login", return_value=mock_res):
        response = client.post("/login", data=data)
        assert response.status_code == 200
        assert "Invalid email or password." in response.text


@pytest.mark.asyncio
async def test_register_action_success(client: TestClient) -> None:
    """Verify POST /register with valid payload redirects to login."""
    mock_res = MagicMock()
    mock_res.status_code = 201

    client.cookies.update({"lifecircle_csrf": "my-csrf-token"})
    data = {
        "csrf_token": "my-csrf-token",
        "full_name": "Krishna Tiwari",
        "email": "guardian@example.com",
        "password": "SecurePassword123!",
        "confirm_password": "SecurePassword123!",
        "role": "guardian",
    }

    with patch(
        "lifecircle_frontend.routes.auth.AuthService.register", return_value=mock_res
    ) as mock_register:
        response = client.post("/register", data=data, follow_redirects=False)
        assert response.status_code == 303
        assert response.headers["location"] == "/login?registered=true"
        mock_register.assert_called_once()


@pytest.mark.parametrize(
    ("full_name", "email", "password", "confirm", "expected_err"),
    [
        (
            "Krishna Tiwari",
            "bad-email",
            "Password123!",
            "Password123!",
            "Please enter a valid email address.",
        ),
        (
            "Krishna Tiwari",
            "guardian@example.com",
            "short",
            "short",
            "Password must be at least 12 characters.",
        ),
        (
            "Krishna Tiwari",
            "guardian@example.com",
            "SecurePassword123!",
            "MismatchPassword123!",
            "Passwords do not match.",
        ),
        (
            "K",
            "guardian@example.com",
            "SecurePassword123!",
            "SecurePassword123!",
            "Full name must be at least 2 characters.",
        ),
        (
            "Krishna Tiwari",
            "guardian@example.com",
            "weakpassword123",
            "weakpassword123",
            "Password must contain at least one uppercase",
        ),
    ],
)
def test_register_validation_edges(
    client: TestClient,
    full_name: str,
    email: str,
    password: str,
    confirm: str,
    expected_err: str,
) -> None:
    """Verify registration form boundaries and complex constraints validation."""
    client.cookies.update({"lifecircle_csrf": "my-csrf-token"})
    data = {
        "csrf_token": "my-csrf-token",
        "full_name": full_name,
        "email": email,
        "password": password,
        "confirm_password": confirm,
        "role": "guardian",
    }
    response = client.post("/register", data=data)
    assert response.status_code == 200
    assert expected_err in response.text


@pytest.mark.asyncio
async def test_register_action_duplicate_email(client: TestClient) -> None:
    """Verify POST /register with duplicate email returns error message."""
    mock_res = MagicMock()
    mock_res.status_code = 409

    client.cookies.update({"lifecircle_csrf": "my-csrf-token"})
    data = {
        "csrf_token": "my-csrf-token",
        "full_name": "Krishna Tiwari",
        "email": "duplicate@example.com",
        "password": "SecurePassword123!",
        "confirm_password": "SecurePassword123!",
        "role": "guardian",
    }

    with patch("lifecircle_frontend.routes.auth.AuthService.register", return_value=mock_res):
        response = client.post("/register", data=data)
        assert response.status_code == 200
        assert "An account with this email address already exists." in response.text


@pytest.mark.asyncio
async def test_register_action_failure_500(client: TestClient) -> None:
    """Verify POST /register handles backend 500 error gracefully."""
    mock_res = MagicMock()
    mock_res.status_code = 500

    client.cookies.update({"lifecircle_csrf": "my-csrf-token"})
    data = {
        "csrf_token": "my-csrf-token",
        "full_name": "Krishna Tiwari",
        "email": "error500@example.com",
        "password": "SecurePassword123!",
        "confirm_password": "SecurePassword123!",
        "role": "guardian",
    }

    with patch("lifecircle_frontend.routes.auth.AuthService.register", return_value=mock_res):
        response = client.post("/register", data=data)
        assert response.status_code == 200
        assert "Registration failed. Please try again." in response.text


@pytest.mark.asyncio
async def test_logout_action(client: TestClient) -> None:
    """Verify POST /logout deletes session cookie and redirects."""
    client.cookies.update(
        {"lifecircle_csrf": "my-csrf-token", "lifecircle_session": "active-token"}
    )
    data = {"csrf_token": "my-csrf-token"}
    response = client.post("/logout", data=data, follow_redirects=False)
    assert response.status_code == 303
    assert response.headers["location"] == "/login"
    assert (
        "lifecircle_session" not in response.cookies or response.cookies["lifecircle_session"] == ""
    )


def test_logout_without_session_cookie(client: TestClient) -> None:
    """Verify that posting to /logout without active session behaves idempotently."""
    client.cookies.update({"lifecircle_csrf": "my-csrf-token"})
    data = {"csrf_token": "my-csrf-token"}
    response = client.post("/logout", data=data, follow_redirects=False)
    assert response.status_code == 303
    assert response.headers["location"] == "/login"
