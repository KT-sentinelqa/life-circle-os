"""
LifeCircle OS — Frontend Application entry point.
"""

from pathlib import Path

from fastapi import Depends, FastAPI
from fastapi.staticfiles import StaticFiles

from lifecircle_frontend.middleware.auth import SessionAuthMiddleware
from lifecircle_frontend.middleware.correlation import CorrelationMiddleware
from lifecircle_frontend.middleware.csrf import CsrfCookieMiddleware, validate_csrf
from lifecircle_frontend.routes import auth, dashboard, family

# Root paths
APP_DIR = Path(__file__).resolve().parent

app = FastAPI(
    title="LifeCircle OS Frontend",
    description="FastAPI + Jinja2 + HTMX frontend client.",
    version="0.1.0",
    dependencies=[Depends(validate_csrf)],
)

# Register middlewares (executed in reverse order)
app.add_middleware(SessionAuthMiddleware)
app.add_middleware(CsrfCookieMiddleware)
app.add_middleware(CorrelationMiddleware)

# Mount static files directory
static_dir = APP_DIR / "static"
static_dir.mkdir(parents=True, exist_ok=True)
app.mount("/static", StaticFiles(directory=str(static_dir)), name="static")

# Include routing sub-modules
app.include_router(auth.router)
app.include_router(dashboard.router)
app.include_router(family.router)
