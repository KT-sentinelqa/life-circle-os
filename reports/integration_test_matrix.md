# Integration Test Matrix (Phase 3B)

This document defines the formal behavioral tests required to prove the resilience of the Event-Driven Architecture.

| Scenario ID | Test Condition | Expected Architectural Outcome |
| :--- | :--- | :--- |
| `INT-001` | **Subscriber Crash Isolation**<br>Simulate a crash in `ReminderSubscriber` when processing `BillCreated`. | The `BillAggregate` transaction MUST succeed. `OutboxSubscriber` MUST successfully queue the event. `TimelineSubscriber` MUST successfully log the event. |
| `INT-002` | **Reference Validation Failure**<br>Trust Domain attempts to add a `TrustedContact` with a `memberId` that doesn't exist in Family Domain. | `ReferenceRegistry` MUST reject the query. `TrustNetworkAggregate` MUST throw a Domain Exception. No events are fired. |
| `INT-003` | **Outbox Idempotency**<br>`EventBus` re-delivers `VehicleRegistered` twice due to a timeout. | `OutboxSubscriber` MUST deduplicate using `eventId`. The database MUST contain exactly 1 Outbox entry. |
| `INT-004` | **SDK Barrier**<br>UI layer attempts to mutate an aggregate property directly (e.g., `DocumentAggregate.status = archived`). | Compilation MUST fail. Aggregates expose internal state as `final`. |
| `INT-005` | **Offline Sink**<br>Device goes entirely offline. User logs a `ServiceRecord`. | `VehicleAggregate` MUST mutate state locally. `OutboxSubscriber` MUST write to local SQLite. Event MUST NOT be lost. |
| `INT-006` | **Timeline Immutability**<br>UI attempts to delete a `MedicineTaken` event from the `TimelineAggregate`. | `TimelineAggregate` MUST reject manual deletions of system-generated domain events to preserve auditable history. |
