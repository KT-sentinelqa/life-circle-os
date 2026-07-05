# ADR-021: Responsibility Ownership & Offline Resolution Model

## Context
LifeCircle OS is an offline-first application. Families rely on it for critical health and financial coordination. A major edge case arises when ownership of a task (e.g., "Give Dad Medicine") is transferred, or when a task escalates while the primary device is offline.

## Decision
We will implement an **Explicit Acceptance** model for ownership transfers, and an **Optimistic Escalation** model for offline SLA breaches.

### Ownership Transfer Rule
If User A transfers a responsibility to User B, the state in User A's database changes to `TRANSFER_PENDING`. User A remains the legal owner of the task (and their device will still trigger local alarms) until User B's device syncs, accepts the transfer, and syncs the `OwnershipAccepted` event back to User A. 
**Rationale**: We cannot drop a medical responsibility into the void because of a bad network connection.

### Optimistic Escalation Rule
Escalation SLA triggers (e.g., "Notify backup owner 30 minutes after missed medicine") are calculated and fired by the **Cloud Backend** as a fallback.
When a task is created, the cloud schedules a delayed job. If the local device does *not* sync a `ResponsibilityCompleted` event before that delayed job fires, the cloud optimistically assumes the local device failed/missed the task, and fires a push notification to the Backup Owner.
**Rationale**: Exception-based alerting only works if the system is paranoid. If a device dies, the cloud must act as the ultimate failsafe to protect the family.

## Consequences
* Increases backend complexity (delayed jobs required).
* Eliminates the risk of a dead battery causing a missed medication.
* Perfectly aligns with the "Trust Infrastructure" and "Peace of Mind" directives.
