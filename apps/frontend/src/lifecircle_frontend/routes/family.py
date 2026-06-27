"""
LifeCircle OS — Family router for rendering family management layout.
"""

from fastapi import APIRouter, Form, Request, Response
from fastapi.responses import RedirectResponse

from lifecircle_frontend.services.family_service import FamilyService
from lifecircle_frontend.templates import templates

router = APIRouter(prefix="/family", tags=["family"])
family_service = FamilyService()


@router.get("/create")
async def create_family_page(request: Request) -> Response:
    """Render the family creation screen."""
    return templates.TemplateResponse(request, "auth/family_create.html", {})


@router.post("/create")
async def create_family_action(
    request: Request,
    name: str = Form(""),
) -> Response:
    """Handle family creation form submission."""
    errors = {}
    name_stripped = name.strip()
    if len(name_stripped) < 2:
        errors["name"] = "Family name must be at least 2 characters."

    token = request.cookies.get("lifecircle_session", "")

    if not errors:
        res = await family_service.create_family(name_stripped, token)
        if res.status_code == 201:
            response = Response(status_code=200)
            if request.headers.get("hx-request") == "true":
                response.headers["HX-Redirect"] = "/dashboard"
            else:
                response = RedirectResponse("/dashboard", status_code=303)
            return response
        elif res.status_code in (401, 403):
            try:
                error_data = res.json()
                errors["general"] = error_data["error"]["message"]
            except Exception:
                errors["general"] = "Unauthorized. Only guardians can create families."
        else:
            errors["general"] = "Family creation failed. Please try again."

    context = {"errors": errors, "name": name, "request": request}
    if request.headers.get("hx-request") == "true":
        return templates.TemplateResponse(request, "auth/partials/family_create_form.html", context)
    return templates.TemplateResponse(request, "auth/family_create.html", context)
