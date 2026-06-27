from __future__ import annotations

from opentelemetry import trace

from lifecircle.infrastructure.observability.tracing import configure_tracing, get_tracer


def test_configure_tracing_local() -> None:
    """Verify that configure_tracing initializes global tracer provider successfully."""
    configure_tracing(
        service_name="test-service",
        otlp_endpoint="http://localhost:4317",
        environment="local",
        use_console_exporter=True,
    )
    tracer = get_tracer("test-tracer")
    assert tracer is not None
    assert trace.get_tracer_provider() is not None


def test_configure_tracing_error_fallback() -> None:
    """Verify that configure_tracing fails open if the OTLP exporter throws an exception."""
    # Passing an invalid OTLP endpoint schema to trigger OTLPSpanExporter exception
    configure_tracing(
        service_name="test-service",
        otlp_endpoint="invalid://localhost:abc",
        environment="production",
        use_console_exporter=False,
    )
    tracer = get_tracer("test-tracer")
    assert tracer is not None
