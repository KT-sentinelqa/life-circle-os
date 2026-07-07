# ADR-032: Sync State Machine

## Context
Distributed systems are notoriously difficult to debug if synchronization is implicit. We must model synchronization as an explicit lifecycle.

## Decision
We define the **Deterministic Event Lifecycle**.

### Lifecycle States
1. **PENDING**: The UI has initiated the mutation. Written to Isar Outbox.
2. **SIGNED**: `DeviceCryptoService` has successfully cryptographically signed the payload.
3. **QUEUED**: Event is picked up by the background sync worker.
4. **SENDING**: HTTP POST in flight.
5. **ACKNOWLEDGED**: Backend responded with HTTP 201 or HTTP 200 (idempotent duplicate).
6. **APPLIED**: Event merged into local state (for Inbox items).
7. **ARCHIVED**: Event safely deleted from local Outbox/Inbox tables to preserve storage.

### Error Paths
* **FAILED**: Network error, timeout, or 500 response.
* **RETRYING**: Worker applies exponential backoff and re-enters `QUEUED`.
* **DEAD_LETTER**: Max retries exceeded (e.g., permanent 400 Bad Request due to schema mismatch).

## Consequences
* Makes observability trivial. We can query exact counts of events in `FAILED` or `DEAD_LETTER` states.
* Enforces at-least-once delivery safety.
