"""
LifeCircle OS — Authentication router for rendering and handling HTML forms.
"""
# ruff: noqa: S105

import re

from fastapi import APIRouter, Form, Request, Response
from fastapi.responses import RedirectResponse

from lifecircle_frontend.config import get_settings
from lifecircle_frontend.services.auth_service import AuthService
from lifecircle_frontend.templates import templates

router = APIRouter(tags=["auth"])
auth_service = AuthService()

# Password complexity regex matches backend
_PASSWORD_PATTERN = re.compile(r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+]).{12,}$")


def validate_registration_payload(
    full_name: str,
    email: str,
    password: str,
    confirm_password: str,
    role: str,
) -> dict[str, str]:
    """Validate registration payload attributes, returning dict of validation errors."""
    errors = {}
    if len(full_name.strip()) < 2:
        errors["full_name"] = "Full name must be at least 2 characters."
    if not email or "@" not in email:
        errors["email"] = "Please enter a valid email address."
    if len(password) < 12:
        errors["password"] = "Password must be at least 12 characters."
    elif not _PASSWORD_PATTERN.match(password):
        errors["password"] = (
            "Password must contain at least one uppercase, "
            "one lowercase, one digit, and one special character (!@#$%^&*()_+)."
        )
    if password != confirm_password:
        errors["confirm_password"] = "Passwords do not match."
    if role not in ("guardian", "helper", "dependent"):
        errors["role"] = "Invalid role type selected."
    return errors


@router.get("/login")
async def login_page(request: Request) -> Response:
    """Render the login page template."""
    registered = request.query_params.get("registered") == "true"
    return templates.TemplateResponse(request, "auth/login.html", {"registered": registered})


@router.post("/login")
async def login_action(
    request: Request,
    email: str = Form(""),
    password: str = Form(""),
) -> Response:
    """Handle login form submission, setting HTTP-only secure session cookies."""
    errors = {}
    if not email:
        errors["email"] = "Email is required."
    if not password:
        errors["password"] = "Password is required."

    if not errors:
        correlation_id = getattr(request.state, "correlation_id", None)
        res = await auth_service.login(
            {"email": email, "password": password},
            correlation_id=correlation_id,
        )
        if res.status_code == 200:
            data = res.json()["data"]
            token = data["access_token"]

            settings = get_settings()
            response = Response(status_code=200)

            if request.headers.get("hx-request") == "true":
                response.headers["HX-Redirect"] = "/dashboard"
            else:
                response = RedirectResponse("/dashboard", status_code=303)

            response.set_cookie(
                "lifecircle_session",
                token,
                httponly=True,
                secure=settings.cookie_secure,
                samesite=settings.cookie_samesite,
            )
            return response
        else:
            errors["general"] = "Invalid email or password."

    context = {"errors": errors, "email": email, "request": request}
    if request.headers.get("hx-request") == "true":
        return templates.TemplateResponse(request, "auth/partials/login_form.html", context)
    return templates.TemplateResponse(request, "auth/login.html", context)


@router.get("/register")
async def register_page(request: Request) -> Response:
    """Render the registration page template."""
    return templates.TemplateResponse(request, "auth/register.html", {})


@router.post("/register")
async def register_action(
    request: Request,
    full_name: str = Form(""),
    email: str = Form(""),
    password: str = Form(""),
    confirm_password: str = Form(""),
    role: str = Form("guardian"),
) -> Response:
    """Handle registration submission, calling backend API proxy."""
    errors = validate_registration_payload(full_name, email, password, confirm_password, role)

    if not errors:
        correlation_id = getattr(request.state, "correlation_id", None)
        payload = {
            "email": email,
            "password": password,
            "full_name": full_name,
            "role": role,
        }
        res = await auth_service.register(payload, correlation_id=correlation_id)
        if res.status_code == 201:
            response = Response(status_code=200)
            if request.headers.get("hx-request") == "true":
                response.headers["HX-Redirect"] = "/login?registered=true"
            else:
                response = RedirectResponse("/login?registered=true", status_code=303)
            return response
        elif res.status_code == 409:
            errors["email"] = "An account with this email address already exists."
        else:
            errors["general"] = "Registration failed. Please try again."

    context = {
        "errors": errors,
        "full_name": full_name,
        "email": email,
        "role": role,
        "request": request,
    }
    if request.headers.get("hx-request") == "true":
        return templates.TemplateResponse(request, "auth/partials/register_form.html", context)
    return templates.TemplateResponse(request, "auth/register.html", context)


@router.post("/logout")
async def logout_action(request: Request) -> Response:
    """Clears the secure session cookie and redirects user back to login."""
    response = Response(status_code=200)
    if request.headers.get("hx-request") == "true":
        response.headers["HX-Redirect"] = "/login"
    else:
        response = RedirectResponse("/login", status_code=303)
    response.delete_cookie("lifecircle_session")
    return response
