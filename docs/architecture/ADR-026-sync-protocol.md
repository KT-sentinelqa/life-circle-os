# ADR-026: Synchronization Protocol

## Context
We need a robust, offline-tolerant mechanism to synchronize `FamilyResponsibility` events between devices without blocking the UI.

## Decision
We will implement an **Inbox/Outbox Pattern with Idempotent Replay**.

### The Flow
1. **Device Mutation**: The UI mutates the local Isar database.
2. **Outbox**: An Event (e.g., `ResponsibilityCompleted`) is immediately appended to a local `Outbox` table.
3. **Background Sync**: A WorkManager reads the `Outbox` and POSTs events to the Cloud API.
4. **Cloud Processing**: The Cloud acknowledges (ACK) the event. The device deletes it from the `Outbox`.
5. **Inbox**: The device periodically GETs an `/events` stream (with a `last_sync_token`). New events are written to the local `Inbox` and merged into the active Isar tables.

## Consequences
* High offline tolerance. If the network drops, the `Outbox` simply queues events.
* Requires strict Idempotency (ADR-027) so duplicate POSTs (due to network retries) don't create duplicate states.
