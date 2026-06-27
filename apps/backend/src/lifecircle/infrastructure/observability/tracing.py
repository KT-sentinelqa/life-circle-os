"""
LifeCircle OS — OpenTelemetry tracing configuration.

Initialises the TracerProvider with:
  - OTLP gRPC exporter → Jaeger (local) or OTLP collector (production)
  - BatchSpanProcessor for async export
  - Resource attributes: service.name, deployment.environment, service.version

PII Scrubbing:
  Email addresses and password hashes MUST NOT appear in span attributes.
  All user-identifying data is represented by [user_id] (UUID) only.

Governed by: docs/observability-pipeline.md | LC-S1-008
"""

from __future__ import annotations

import logging

from opentelemetry import trace
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.resources import Resource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor, ConsoleSpanExporter
from opentelemetry.semconv.resource import ResourceAttributes

logger = logging.getLogger(__name__)


def configure_tracing(
    service_name: str,
    otlp_endpoint: str,
    environment: str,
    service_version: str = "0.1.0",
    use_console_exporter: bool = False,
) -> None:
    """Initialise the global OpenTelemetry TracerProvider.

    Args:
        service_name:          e.g. 'lifecircle-backend'
        otlp_endpoint:         OTLP gRPC endpoint, e.g. 'http://localhost:4317'
        environment:           Deployment environment ('local', 'staging', 'production')
        service_version:       Application version string.
        use_console_exporter:  If True, also prints spans to stdout (local debug).
    """
    resource = Resource.create(
        {
            ResourceAttributes.SERVICE_NAME: service_name,
            ResourceAttributes.SERVICE_VERSION: service_version,
            ResourceAttributes.DEPLOYMENT_ENVIRONMENT: environment,
        }
    )

    provider = TracerProvider(resource=resource)

    # ── OTLP Exporter (Jaeger / Collector) ────────────────────────────────────
    try:
        otlp_exporter = OTLPSpanExporter(endpoint=otlp_endpoint, insecure=True)
        provider.add_span_processor(BatchSpanProcessor(otlp_exporter))
        logger.info("OTel OTLP exporter configured", extra={"endpoint": otlp_endpoint})
    except Exception as exc:
        # Fail open — tracing failure must not crash the application
        logger.warning("OTel OTLP exporter init failed: %s", exc)

    # ── Console Exporter (local dev only) ─────────────────────────────────────
    if use_console_exporter:
        provider.add_span_processor(BatchSpanProcessor(ConsoleSpanExporter()))

    trace.set_tracer_provider(provider)
    logger.info(
        "OpenTelemetry TracerProvider configured",
        extra={
            "service": service_name,
            "env": environment,
        },
    )


def get_tracer(name: str) -> trace.Tracer:
    """Return a named tracer from the global provider.

    Usage in use cases:
        tracer = get_tracer("lifecircle.auth")
        with tracer.start_as_current_span("auth.register_user") as span:
            span.set_attribute("user.role", user.role.value)
            # NOTE: Never set span.set_attribute("user.email", ...) — PII
    """
    return trace.get_tracer(name)
