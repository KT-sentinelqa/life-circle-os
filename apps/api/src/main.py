from fastapi import FastAPI
from starlette_prometheus import PrometheusMiddleware, metrics

from src.auth.router import router as auth_router
from src.core.config import settings
from src.core.database import engine
from src.core.logger import setup_logger
from src.health.router import router as health_router
from src.notifications.router import router as notifications_router
from src.observability.tracing import setup_tracing
from src.organizations.router import router as org_router
from src.profiles.router import router as profile_router
from src.users.router import router as users_router

setup_logger()

app = FastAPI(
    title=settings.PROJECT_NAME,
    openapi_url=f"{settings.API_V1_STR}/openapi.json",
    docs_url="/docs",
    redoc_url="/redoc",
)

# Apply Prometheus Middleware
app.add_middleware(PrometheusMiddleware)
app.add_route("/metrics", metrics)

# Setup OpenTelemetry
setup_tracing(engine=engine.sync_engine)
try:
    from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor

    FastAPIInstrumentor.instrument_app(app)
except ImportError:
    pass

app.include_router(auth_router, prefix=settings.API_V1_STR)
app.include_router(users_router, prefix=settings.API_V1_STR)
app.include_router(org_router, prefix=settings.API_V1_STR)
app.include_router(profile_router, prefix=settings.API_V1_STR)
app.include_router(notifications_router, prefix=settings.API_V1_STR)
app.include_router(health_router)
