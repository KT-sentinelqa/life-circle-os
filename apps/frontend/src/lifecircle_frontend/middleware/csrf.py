from __future__ import annotations

import secrets
from collections.abc import Awaitable, Callable

from fastapi import HTTPException, Request, Response, status
from starlette.middleware.base import BaseHTTPMiddleware

from lifecircle_frontend.config import get_settings


class CsrfCookieMiddleware(BaseHTTPMiddleware):
    """Ensures a CSRF token cookie is generated and bound to request context."""

    async def dispatch(
        self,
        request: Request,
        call_next: Callable[[Request], Awaitable[Response]],
    ) -> Response:
        csrf_cookie = request.cookies.get("lifecircle_csrf")
        token = csrf_cookie or secrets.token_hex(32)
        request.state.csrf_token = token

        response: Response = await call_next(request)

        # Set cookie if it wasn't already in request
        if not csrf_cookie and request.method == "GET":
            settings = get_settings()
            response.set_cookie(
                "lifecircle_csrf",
                token,
                httponly=True,
                secure=settings.cookie_secure,
                samesite=settings.cookie_samesite,
            )
        return response


async def validate_csrf(request: Request) -> None:
    """Dependency that validates CSRF token for mutating requests."""
    if request.method in ("POST", "PUT", "PATCH", "DELETE"):
        cookie_token = request.cookies.get("lifecircle_csrf")

        # Read from header first (for AJAX/HTMX) or form body
        token: str | None = request.headers.get("X-CSRF-Token")
        if not token:
            try:
                form = await request.form()
                raw_token = form.get("csrf_token")
                token = raw_token if isinstance(raw_token, str) else None
            except Exception:
                token = None

        if not cookie_token or not token or cookie_token != token:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="CSRF token validation failed.",
            )
