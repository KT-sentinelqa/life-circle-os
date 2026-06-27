"""
LifeCircle OS — FastAPI application factory.

Governed by: docs/coding-standards.md | docs/observability-pipeline.md
"""

from __future__ import annotations

from collections.abc import AsyncGenerator
from contextlib import asynccontextmanager

import structlog
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

from lifecircle.config import get_settings
from lifecircle.infrastructure.observability.tracing import configure_tracing
from lifecircle.presentation.api.v1.auth.router import router as auth_router
from lifecircle.presentation.api.v1.sync.router import router as sync_router

logger = structlog.get_logger(__name__)


@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncGenerator[None, None]:
    """Application lifespan manager (startup / shutdown hooks)."""
    settings = get_settings()

    # Configure OpenTelemetry tracing
    configure_tracing(
        service_name=settings.otel_service_name,
        otlp_endpoint=settings.otlp_endpoint,
        environment=settings.app_env,
        use_console_exporter=settings.otel_use_console,
    )

    # Auto-instrument FastAPI
    try:
        from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor
        from opentelemetry.instrumentation.sqlalchemy import SQLAlchemyInstrumentor

        FastAPIInstrumentor.instrument_app(app)
        SQLAlchemyInstrumentor().instrument()
    except Exception as exc:
        logger.warning("OTel auto-instrumentation failed: %s", exc)

    logger.info(
        "LifeCircle OS backend starting",
        env=settings.app_env,
        debug=settings.app_debug,
    )
    yield
    logger.info("LifeCircle OS backend shutting down")
    from opentelemetry import trace

    provider = trace.get_tracer_provider()
    if hasattr(provider, "shutdown"):
        try:
            provider.shutdown()
        except Exception as exc:
            logger.warning("Failed to shutdown OTel provider: %s", exc)


def create_app() -> FastAPI:
    """Application factory — creates and configures the FastAPI instance."""
    settings = get_settings()

    app = FastAPI(
        title="LifeCircle OS API",
        description=("Family life management platform API. " "Governed by docs/api-guidelines.md."),
        version="0.1.0",
        docs_url="/docs" if settings.app_debug else None,
        redoc_url="/redoc" if settings.app_debug else None,
        openapi_url="/openapi.json" if settings.app_debug else None,
        lifespan=lifespan,
    )

    # ── CORS (local development only) ─────────────────────────────────────────
    if settings.app_env == "local":
        app.add_middleware(
            CORSMiddleware,
            allow_origins=["http://localhost:*"],
            allow_credentials=True,
            allow_methods=["*"],
            allow_headers=["*"],
        )

    # ── Global Exception Handler ───────────────────────────────────────────────
    @app.exception_handler(Exception)
    async def unhandled_exception_handler(
        request: Request,
        exc: Exception,
    ) -> JSONResponse:
        logger.error("Unhandled exception", exc_info=exc, path=request.url.path)
        return JSONResponse(
            status_code=500,
            content={
                "success": False,
                "error": {
                    "code": "INTERNAL_SERVER_ERROR",
                    "message": "An unexpected error occurred.",
                    "trace_id": None,
                },
            },
        )

    from fastapi import HTTPException
    from fastapi.exceptions import RequestValidationError

    @app.exception_handler(HTTPException)
    async def http_exception_handler(
        request: Request,
        exc: HTTPException,
    ) -> JSONResponse:
        """Ensure all HTTP exceptions follow the standard error response envelope."""
        detail = exc.detail
        if isinstance(detail, dict) and "error" in detail:
            content = detail
        else:
            content = {
                "success": False,
                "error": {
                    "code": "HTTP_ERROR",
                    "message": str(detail),
                    "trace_id": None,
                },
            }
        return JSONResponse(
            status_code=exc.status_code,
            content=content,
            headers=exc.headers,
        )

    @app.exception_handler(RequestValidationError)
    async def validation_exception_handler(
        request: Request,
        exc: RequestValidationError,
    ) -> JSONResponse:
        """Handle request schema validation errors, returning standard envelopes."""
        errors_str = "; ".join(
            f"{'.'.join(str(loc) for loc in err['loc'])}: {err['msg']}" for err in exc.errors()
        )
        return JSONResponse(
            status_code=422,
            content={
                "success": False,
                "error": {
                    "code": "VALIDATION_FAILED",
                    "message": f"Request validation failed: {errors_str}",
                    "trace_id": None,
                },
            },
        )

    # ── Health Check ──────────────────────────────────────────────────────────
    @app.get("/health", tags=["ops"], include_in_schema=False)
    async def health() -> dict[str, str]:
        """Liveness probe endpoint."""
        return {"status": "ok", "env": settings.app_env}

    # ── Routers ───────────────────────────────────────────────────────────────
    app.include_router(auth_router)
    app.include_router(sync_router)

    return app


# Application instance (used by uvicorn)
app = create_app()
