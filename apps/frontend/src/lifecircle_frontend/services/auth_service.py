from collections.abc import Mapping

import httpx

from lifecircle_frontend.config import get_settings


class AuthService:
    """Service communicating with the backend auth endpoints."""

    def __init__(self) -> None:
        self.settings = get_settings()

    async def register(
        self, payload: Mapping[str, object], correlation_id: str | None = None
    ) -> httpx.Response:
        """Call backend register user endpoint."""
        headers = {}
        if correlation_id:
            headers["X-Correlation-ID"] = correlation_id
        async with httpx.AsyncClient() as client:
            return await client.post(
                f"{self.settings.backend_api_url}/api/v1/auth/register",
                json=payload,
                headers=headers,
            )

    async def login(
        self, payload: Mapping[str, object], correlation_id: str | None = None
    ) -> httpx.Response:
        """Call backend login endpoint."""
        headers = {}
        if correlation_id:
            headers["X-Correlation-ID"] = correlation_id
        async with httpx.AsyncClient() as client:
            return await client.post(
                f"{self.settings.backend_api_url}/api/v1/auth/login",
                json=payload,
                headers=headers,
            )
