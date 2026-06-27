"""
LifeCircle OS — Dashboard router for rendering main HTML screens.
"""

from fastapi import APIRouter, Request, Response

from lifecircle_frontend.templates import templates

router = APIRouter(tags=["dashboard"])


@router.get("/")
async def landing_page(request: Request) -> Response:
    """Render the landing / onboarding splash screen."""
    return templates.TemplateResponse(request, "dashboard/index.html", {})


@router.get("/dashboard")
async def dashboard_page(request: Request) -> Response:
    """Render the user home dashboard layout."""
    return templates.TemplateResponse(request, "dashboard/index.html", {})
