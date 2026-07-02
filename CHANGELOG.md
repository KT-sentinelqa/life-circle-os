# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0-alpha] - 2026-07-02

### Added
- **Outbox Pattern**: Reliable, transactional event publishing architecture.
- **Async Email Delivery**: Decoupled email sending using `aiosmtplib` and background workers.
- **Observability Layer**: 
  - Structured JSON logging via `structlog`.
  - OpenTelemetry auto-instrumentation for FastAPI and SQLAlchemy.
  - Prometheus metrics (`/metrics`) tracking HTTP latencies, outbox depth, and worker duration.
- **Health Probes**: `/health/live` and `/health/ready` endpoints with Postgres/Redis checks.
- **Docker Production Artifacts**: Created `Dockerfile` and `docker-compose.prod.yml`.
- **CI/CD Quality Gates**: Enforced strict 85% test coverage gate.

### Changed
- Refactored `src/core/database.py` to decouple it entirely from telemetry tooling.
- Migrated legacy `InvitationService` from synchronous SMTP calls to event-driven email delivery.
- Moved `AuditLog` domain out of core into its own bounded context.

### Fixed
- Re-established 40/40 passing test suite across all bounded contexts.
