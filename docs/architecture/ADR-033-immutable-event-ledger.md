# ADR-033: Immutable Event Ledger

## Context
When synchronizing state across multiple offline-first devices, mutating historical records in the backend database destroys forensic traceability and makes conflict debugging nearly impossible.

## Decision
The PostgreSQL `SyncEventRecord` table is an **Immutable Event Ledger**. 

### The Rules
1. **Append Only**: `UPDATE` and `DELETE` SQL operations are strictly forbidden on the `sync_events` table (except for automated 90-day pruning tasks defined by the retention policy).
2. **Never Mutate History**: If a user completes a task, it's one event. If they un-complete it, it's a *new* event appended to the ledger, not an update to the original event.
3. **Deterministic Reconstruction**: Any device syncing from a new installation can pull the ledger for its `FamilyId` and reconstruct the exact current state deterministically by replaying the events in `logical_timestamp` order using Last-Write-Wins (`ADR-027`).

## Consequences
* Dramatically simplifies backend debugging. If a sync conflict occurs, SREs can view the exact chronological order of received events.
* Increases database row count linearly with user activity. Retention pruning (`SEC-007`) becomes critical to long-term cost management.
