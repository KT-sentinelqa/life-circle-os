"""
LifeCircle OS — Application configuration.

Sources values from:
  1. Environment variables (docker-compose .env.local)
  2. Doppler (CI/CD and production)

Never instantiate Settings directly in business logic — inject via FastAPI Depends.
"""

from __future__ import annotations

from functools import lru_cache

from pydantic import Field, PostgresDsn, RedisDsn, SecretStr
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Immutable application configuration.

    All fields are validated at startup. Missing required fields raise an error
    immediately, preventing the application from booting with incomplete config.
    """

    model_config = SettingsConfigDict(
        env_file=".env.local",
        env_file_encoding="utf-8",
        case_sensitive=False,
        extra="ignore",
    )

    # ── Application ───────────────────────────────────────────────────────────
    app_env: str = Field(default="local", description="Deployment environment")
    app_debug: bool = Field(default=False, description="Enable debug mode")
    app_port: int = Field(default=8000, description="Server port")
    log_level: str = Field(default="INFO", description="Structlog log level")

    # ── Database ──────────────────────────────────────────────────────────────
    database_url: PostgresDsn = Field(description="Async PostgreSQL DSN (postgresql+asyncpg://...)")

    # ── Redis ─────────────────────────────────────────────────────────────────
    redis_url: RedisDsn = Field(description="Redis DSN (redis://:pass@host:port/db)")

    # ── RabbitMQ ──────────────────────────────────────────────────────────────
    rabbitmq_url: str = Field(description="AMQP DSN (amqp://user:pass@host:port/vhost)")

    # ── JWT ───────────────────────────────────────────────────────────────────
    jwt_secret: SecretStr = Field(
        description="HMAC-SHA256 signing secret (min 32 chars). Sourced from Doppler."
    )
    jwt_algorithm: str = Field(default="HS256")
    jwt_expiry_minutes: int = Field(default=15, ge=5, le=60)

    # ── Email (SMTP) ──────────────────────────────────────────────────────────
    smtp_host: str = Field(default="localhost")
    smtp_port: int = Field(default=1025)
    smtp_use_tls: bool = Field(default=False)
    smtp_username: str = Field(default="")
    smtp_password: SecretStr = Field(default=SecretStr(""))
    email_from: str = Field(default="noreply@lifecircle.local")

    # ── Rate Limiting ─────────────────────────────────────────────────────────
    rate_limit_register_per_minute: int = Field(
        default=5,
        ge=1,
        le=100,
        description="Max registration requests per minute per IP",
    )

    # ── OpenTelemetry ─────────────────────────────────────────────────────────
    otlp_endpoint: str = Field(
        default="http://localhost:4317",
        description="OTLP gRPC endpoint for Jaeger / OTel Collector",
    )
    otel_service_name: str = Field(
        default="lifecircle-backend",
        description="Service name reported in traces",
    )
    otel_use_console: bool = Field(
        default=False,
        description="Print spans to stdout (local debug only)",
    )


@lru_cache(maxsize=1)
def get_settings() -> Settings:
    """Return the singleton Settings instance.

    Cached after first call. Use FastAPI's Depends(get_settings) for injection.
    """
    return Settings()
