from __future__ import annotations

import base64
import json
import time
from collections.abc import Awaitable, Callable

from starlette.middleware.base import BaseHTTPMiddleware
from starlette.requests import Request
from starlette.responses import RedirectResponse, Response


def decode_jwt_payload(token: str) -> dict[str, object] | None:
    """Decode and extract claims from a JWT token, verifying expiration."""
    try:
        parts = token.split(".")
        if len(parts) != 3:
            return None
        payload_b64 = parts[1]
        padding = "=" * (4 - len(payload_b64) % 4)
        payload_json = base64.urlsafe_b64decode(payload_b64 + padding).decode("utf-8")
        payload = json.loads(payload_json)

        exp = payload.get("exp")
        if isinstance(exp, int | float) and exp < time.time():
            return None  # Expired
        return dict(payload)
    except Exception:
        return None


class SessionAuthMiddleware(BaseHTTPMiddleware):
    """Middleware to parse user session cookies and enforce route protection."""

    async def dispatch(
        self,
        request: Request,
        call_next: Callable[[Request], Awaitable[Response]],
    ) -> Response:
        path = request.url.path
        is_protected = path.startswith("/dashboard") or path.startswith("/family")

        token = request.cookies.get("lifecircle_session")
        user = decode_jwt_payload(token) if token else None
        request.state.user = user

        # Redirect logged-in users trying to access auth forms
        if (path == "/login" or path == "/register") and request.state.user:
            return RedirectResponse("/dashboard", status_code=303)

        if is_protected and not request.state.user:
            # Handle HTMX dynamic requests gracefully
            if request.headers.get("hx-request") == "true":
                return Response(status_code=200, headers={"HX-Redirect": "/login"})
            return RedirectResponse("/login", status_code=303)

        response: Response = await call_next(request)
        return response
