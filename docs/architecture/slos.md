# Service Level Objectives (SLOs)

This document outlines the target Service Level Objectives (SLOs) for critical background and asynchronous operations in Life Circle OS.

## 1. Notification Delivery Latency

**Objective**: Notifications (in-app, push, and email) should be delivered quickly after an event is triggered.
- **SLI (Service Level Indicator)**: The time elapsed from when an `OutboxEvent` is created in the database to when the third-party delivery provider (e.g., SMTP server, APNS) acknowledges receipt.
- **Target SLO**: 
  - 95% of notifications delivered within **5 seconds**.
  - 99% of notifications delivered within **15 seconds**.
- **Monitoring**: OpenTelemetry metrics on `OutboxEvent.created_at` vs `OutboxEvent.processed_at`.

## 2. Outbox Processing Guarantees

**Objective**: The Outbox pattern guarantees at-least-once delivery. Events should not languish in the `PENDING` state indefinitely.
- **SLI**: The queue depth (count of `PENDING` events) and the age of the oldest `PENDING` event.
- **Target SLO**:
  - Outbox polling interval: Every **1 second** max.
  - Maximum queue depth: **< 1000 events**.
  - Oldest `PENDING` event age: **< 1 minute** (excluding events stuck in exponential backoff retry).

## 3. Worker Uptime Objectives

**Objective**: The background worker tier (ARQ) must be highly available to ensure asynchronous tasks process reliably.
- **SLI**: The percentage of time the worker process is running and successfully communicating with Redis and PostgreSQL.
- **Target SLO**: **99.9% uptime** per month.
- **Remediation**: Kubernetes health checks on worker pods and automated restarts on transient database/Redis disconnects.

## 4. Dead-Letter Queue (DLQ) Remediation

**Objective**: Events that fail permanently (e.g., malformed payload, permanent SMTP rejection) must be isolated without blocking the queue.
- **SLI**: The number of events in the `FAILED` state.
- **Target SLO**: `FAILED` events must trigger an alert to the engineering team within **5 minutes**, with a target resolution/remediation time of **< 24 hours**.
