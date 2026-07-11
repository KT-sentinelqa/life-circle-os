# Outbox Specification

**Status:** Proposed (SEC-006)

This document maps the precise lifecycle of data mutations acting within the offline-first Outbox queue. The Outbox serves as the single source of truth for unsynchronized client operations.

## 1. Outbox Schema

Every operation MUST be stored locally as an `OutboxRecord`:
```json
{
  "operationId": "uuid",
  "entityId": "uuid",
  "entityType": "Medicine",
  "mutationType": "CREATE | UPDATE | DELETE",
  "payload": "<json-blob>",
  "timestamp": "iso-utc",
  "status": "PENDING | IN_FLIGHT | FAILED",
  "retryCount": 0
}
```

## 2. The Lifecycle

1. **Enqueue:** The Repository commits the entity to the local DB *and* the Outbox within the same atomic SQL transaction. `status` = `PENDING`.
2. **Drain:** The Sync Worker polls `PENDING` records. 
3. **Lock:** The Worker updates `status` to `IN_FLIGHT` to prevent concurrent sync loops from grabbing the same records.
4. **Transmit:** The Worker bundles the records into a `SyncBatch` and securely transmits them (via `SyncEnvelope`).
5. **Resolution:** 
   - On `ACK`: The Outbox deletes the records permanently.
   - On `CONFLICT`: The Outbox flags the record and defers to the Conflict Engine.
   - On `NETWORK_ERROR`: The Outbox resets the status to `PENDING` and increments `retryCount`.

## 3. Backoff and Dead-Letter
If `retryCount` exceeds the `MAX_RETRIES` (e.g. 10), the record status is changed to `FAILED`. It is treated as a dead-letter queue item. The UI will alert the user that a specific operation failed to sync indefinitely, requiring manual intervention or deletion.
