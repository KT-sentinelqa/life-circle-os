from __future__ import annotations

import base64
import json
import time

from fastapi.testclient import TestClient


def create_valid_test_token() -> str:
    """Generate a syntactically valid JWT token with a future exp claim."""
    header = base64.b64encode(b'{"alg":"HS256","typ":"JWT"}').decode("utf-8").rstrip("=")
    payload_dict = {
        "sub": "89078d46-bc5b-42ea-a417-21a41285ab32",
        "email": "guardian@example.com",
        "role": "guardian",
        "exp": int(time.time()) + 3600,
    }
    payload = base64.b64encode(json.dumps(payload_dict).encode("utf-8")).decode("utf-8").rstrip("=")
    return f"{header}.{payload}."


def test_session_middleware_unauthenticated_protected_route_redirects(client: TestClient) -> None:
    """Verify that accessing a protected route without a session cookie redirects to /login."""
    response = client.get("/dashboard", follow_redirects=False)
    assert response.status_code == 303
    assert response.headers["location"] == "/login"


def test_session_middleware_unauthenticated_htmx_redirects(client: TestClient) -> None:
    """Verify that accessing protected route via HTMX without cookie returns HX-Redirect header."""
    headers = {"hx-request": "true"}
    response = client.get("/dashboard", headers=headers)
    assert response.status_code == 200
    assert response.headers["HX-Redirect"] == "/login"


def test_session_middleware_authenticated_continues(client: TestClient) -> None:
    """Verify that accessing protected route with a valid session cookie renders the page."""
    client.cookies.update({"lifecircle_session": create_valid_test_token()})
    response = client.get("/dashboard")
    assert response.status_code == 200
    assert "Tiwari Family Dashboard" in response.text


def test_session_middleware_authenticated_auth_page_redirects(client: TestClient) -> None:
    """Verify that accessing /login with a valid session cookie redirects to /dashboard."""
    client.cookies.update({"lifecircle_session": create_valid_test_token()})
    response = client.get("/login", follow_redirects=False)
    assert response.status_code == 303
    assert response.headers["location"] == "/dashboard"


def test_family_route_authenticated(client: TestClient) -> None:
    """Verify that accessing a protected family route with a valid session renders correctly."""
    client.cookies.update({"lifecircle_session": create_valid_test_token()})
    response = client.get("/family/create")
    assert response.status_code == 200
    assert "LifeCircle" in response.text


def test_session_expired_token(client: TestClient) -> None:
    """Verify that an expired JWT session redirects to /login."""
    header = base64.b64encode(b'{"alg":"HS256","typ":"JWT"}').decode("utf-8").rstrip("=")
    payload_dict = {
        "sub": "uuid-here",
        "exp": int(time.time()) - 3600,  # expired 1 hr ago
    }
    payload = base64.b64encode(json.dumps(payload_dict).encode("utf-8")).decode("utf-8").rstrip("=")
    token = f"{header}.{payload}.dummy-signature"
    client.cookies.update({"lifecircle_session": token})
    response = client.get("/dashboard", follow_redirects=False)
    assert response.status_code == 303


def test_session_invalid_jwt_structure(client: TestClient) -> None:
    """Verify that a token with non-standard parts redirects to /login."""
    client.cookies.update({"lifecircle_session": "not.three.parts"})
    response = client.get("/dashboard", follow_redirects=False)
    assert response.status_code == 303


def test_session_invalid_json_payload(client: TestClient) -> None:
    """Verify that a session token with invalid payload JSON structure redirects to /login."""
    header = base64.b64encode(b'{"alg":"HS256"}').decode("utf-8").rstrip("=")
    token = f"{header}.invalidpayload.sig"
    client.cookies.update({"lifecircle_session": token})
    response = client.get("/dashboard", follow_redirects=False)
    assert response.status_code == 303


def test_session_invalid_exp_type(client: TestClient) -> None:
    """Verify that a session token with non-numeric exp allows request to proceed."""
    header = base64.b64encode(b'{"alg":"HS256"}').decode("utf-8").rstrip("=")
    payload_dict = {
        "sub": "89078d46-bc5b-42ea-a417-21a41285ab32",
        "email": "guardian@example.com",
        "role": "guardian",
        "exp": "invalid",
    }
    payload = base64.b64encode(json.dumps(payload_dict).encode("utf-8")).decode("utf-8").rstrip("=")
    token = f"{header}.{payload}."
    client.cookies.update({"lifecircle_session": token})
    response = client.get("/dashboard", follow_redirects=False)
    assert response.status_code == 200
