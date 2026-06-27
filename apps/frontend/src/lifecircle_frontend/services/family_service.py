"""
LifeCircle OS — Family client proxy service.
"""

import httpx

from lifecircle_frontend.config import get_settings


class FamilyService:
    """Service communicating with the backend family endpoints."""

    def __init__(self) -> None:
        self.settings = get_settings()

    async def create_family(self, name: str, token: str) -> httpx.Response:
        """Call backend family creation endpoint with JWT."""
        headers = {"Authorization": f"Bearer {token}"}
        async with httpx.AsyncClient() as client:
            return await client.post(
                f"{self.settings.backend_api_url}/api/v1/families",
                json={"name": name},
                headers=headers,
            )
