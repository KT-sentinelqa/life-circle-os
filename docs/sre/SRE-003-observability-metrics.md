# SRE-003: Observability & Metrics Policy

## 1. Objective
To define what the Cloud Trust Platform emits for monitoring, strictly adhering to `SEC-024` (no raw payload logging).

## 2. Structured Logging
* All backend logs must be JSON formatted.
* Required fields: `timestamp`, `level`, `trace_id` (for request correlation), `event_type`.
* Banned fields: PII, Task Titles, Sync Payloads, Peace Index Scores.

## 3. Prometheus Metrics (Required Instrumentation)
FastAPI must expose a `/metrics` endpoint generating the following:
* `http_requests_total{method="POST", path="/api/v1/sync/ingest", status="200"}`
* `http_request_duration_seconds_bucket` (for SLI tracking)
* `sync_events_ingested_total{schema_version="1"}`
* `signature_verification_failures_total`
* `redis_queue_depth_current`

## 4. Distributed Tracing (OpenTelemetry)
* Every incoming request to FastAPI must generate a `trace_id`.
* The `trace_id` must be passed downstream into the Redis Queue payload so that background workers (Phase 4.4C) can correlate queue processing logs back to the original HTTP request.
