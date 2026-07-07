# SEC-025: Backend Privacy Model (The Dumb Pipeline)

## 1. Objective
The most secure data is data that is never stored. The Cloud Trust Platform must minimize its knowledge of the family's life.

## 2. The Dumb Pipeline Principle
The Cloud is a coordinator, not an aggregator. 
* The Cloud **does not calculate** the `FamilyPeaceIndex`. It relies entirely on the local devices to calculate it using their offline Isar databases (`ADR-022`).
* The Cloud simply accepts state mutations (e.g., `ResponsibilityCompleted`) and places them in an Inbox for other devices to pull.

## 3. Data Ephemerality
* The Cloud's Sync Outbox is a transient queue. Once all active devices in a `Family` have pulled a sync event, the event payload should be hard-deleted from the PostgreSQL operational tables, leaving only the eventual consistent materialized view of the `FamilyResponsibility`.

## 4. E2EE Future-Proofing
By treating the backend as a dumb pipeline now, we pave the way for true End-to-End Encryption (E2EE) in Phase 5, where sync payloads are encrypted by a shared Family Key, rendering the Cloud mathematically incapable of reading the task names.
