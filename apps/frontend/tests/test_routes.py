from __future__ import annotations

from fastapi.testclient import TestClient


def test_landing_page(client: TestClient) -> None:
    """Verify the root landing route renders HTML content correctly."""
    response = client.get("/")
    assert response.status_code == 200
    assert "LifeCircle" in response.text


def test_login_page(client: TestClient) -> None:
    """Verify the login route renders HTML content correctly."""
    response = client.get("/login")
    assert response.status_code == 200
    assert "Welcome Back" in response.text


def test_register_page(client: TestClient) -> None:
    """Verify the register route renders HTML content correctly."""
    response = client.get("/register")
    assert response.status_code == 200
    assert "Create Account" in response.text


def test_dashboard_page(client: TestClient) -> None:
    """Verify the dashboard route renders HTML content correctly."""
    response = client.get("/dashboard")
    assert response.status_code == 200
    assert "LifeCircle" in response.text


def test_create_family_page(client: TestClient) -> None:
    """Verify the create family route renders HTML content correctly."""
    response = client.get("/family/create")
    assert response.status_code == 200
    assert "LifeCircle" in response.text
