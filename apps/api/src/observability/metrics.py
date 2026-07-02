from prometheus_client import Counter, Gauge, Histogram

# HTTP Metrics
HTTP_REQUEST_DURATION = Histogram(
    "http_request_duration_seconds",
    "Duration of HTTP requests in seconds",
    ["method", "endpoint", "status"],
)

# Outbox Metrics
OUTBOX_PROCESSING_DURATION = Histogram(
    "outbox_processing_duration_seconds",
    "Duration of processing outbox events",
    ["event_type", "status"],
)

OUTBOX_QUEUE_DEPTH = Gauge("outbox_queue_depth", "Number of pending events in the outbox queue")

# Email Metrics
EMAIL_DELIVERY_TOTAL = Counter(
    "email_delivery_total",
    "Total number of emails processed",
    ["status"],  # e.g., 'success', 'failure'
)
