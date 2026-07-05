# Event Storming: Responsibility Engine

The Responsibility Engine operates on an Event-Sourced model to guarantee eventual consistency across the family's devices when operating offline.

## Core Events

### 1. `ResponsibilityCreated`
* **Trigger**: A user creates a new family task.
* **Payload**: `uuid`, `name`, `primaryOwnerId`, `dueDate`.
* **Conflict Resolution**: Last-Write-Wins (LWW) based on local device timestamp.

### 2. `ResponsibilityCompleted`
* **Trigger**: User marks task as done.
* **Payload**: `responsibilityUuid`, `completedById`, `completionEvidenceUri`, `timestamp`.
* **Conflict Resolution**: If both Primary and Backup mark it complete while offline, the earliest `timestamp` wins the Confidence Score, but the state reliably resolves to `COMPLETED`.

### 3. `ResponsibilityEscalated`
* **Trigger**: The local Cron/WorkManager detects the SLA has breached.
* **Payload**: `responsibilityUuid`, `escalatedAt`.
* **Cloud Sync Rule**: This event is highly prioritized. The moment network is restored, this event bypasses the standard sync queue to immediately alert the `backupOwner`.

### 4. `OwnershipTransferred`
* **Trigger**: Primary owner delegates task to Backup owner permanently.
* **Payload**: `responsibilityUuid`, `newPrimaryOwnerId`, `timestamp`.
* **Security Gate**: The `newPrimaryOwnerId` must cryptographically sign an `OwnershipAccepted` event before the transition is finalized in the database (ADR-021).
