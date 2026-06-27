from __future__ import annotations

from pathlib import Path
from typing import Any

from fastapi import Request
from fastapi.templating import Jinja2Templates

APP_DIR = Path(__file__).resolve().parent


def global_context(request: Request) -> dict[str, Any]:
    """Provide CSRF token and user session to all templates."""
    return {
        "csrf_token": getattr(request.state, "csrf_token", "")
        or request.cookies.get("lifecircle_csrf", ""),
        "user": getattr(request.state, "user", None),
    }


templates = Jinja2Templates(
    directory=str(APP_DIR / "templates"),
    context_processors=[global_context],
)
