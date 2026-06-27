from __future__ import annotations

import uuid
from collections.abc import Awaitable, Callable

from starlette.middleware.base import BaseHTTPMiddleware
from starlette.requests import Request
from starlette.responses import Response
from structlog.contextvars import bind_contextvars


class CorrelationMiddleware(BaseHTTPMiddleware):
    """Middleware to inject, track, and propagate X-Correlation-ID."""

    async def dispatch(
        self,
        request: Request,
        call_next: Callable[[Request], Awaitable[Response]],
    ) -> Response:
        correlation_id = request.headers.get("X-Correlation-ID") or str(uuid.uuid4())
        request.state.correlation_id = correlation_id

        # Bind correlation ID to the logging contextvars
        bind_contextvars(correlation_id=correlation_id)

        response: Response = await call_next(request)
        response.headers["X-Correlation-ID"] = correlation_id
        return response
