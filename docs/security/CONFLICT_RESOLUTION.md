# Conflict Resolution Engine

**Status:** Proposed (SEC-006)

This document dictates how the backend and client resolve divergent states when multiple offline clients mutate the same entity simultaneously.

## 1. Core Philosophy
There is NO global "Last Write Wins" (LWW) strategy. LWW inherently risks data loss for concurrent business logic. Instead, LifeCircle OS implements **Entity-Specific Merge Policies**.

## 2. The Conflict Matrix

| Domain Entity | Conflict Strategy | Description |
| --- | --- | --- |
| **Medicine Schedule** | Domain Merge | Both schedules are merged. If identical time slots conflict, they are explicitly appended. |
| **Emergency Contacts** | Manual Review | Both states are saved. The UI presents a resolution dialog to the primary Family Owner. |
| **Family Ownership** | Server Authoritative | Absolute server time and existing state wins. Rejects conflicting parallel transfers. |
| **Audit Logs** | Append-Only | Impossible to conflict. All logs are simply appended monotonically. |
| **Notifications** | Idempotent | Duplicate "mark as read" events are collapsed harmlessly. |
| **Responsibilities** | Merge by Operation| Assigning/resolving chores merges fine-grained properties rather than the entire entity object. |

## 3. Conflict Payload Handling
When the Server detects a conflict that requires client resolution (e.g. `Manual Review`), the Server responds to the `SyncEnvelope` push with a `SyncDecision: CONFLICT`.

**The Conflict Object:**
```json
{
  "entityId": "uuid",
  "entityType": "EmergencyContact",
  "clientVersion": 3,
  "serverVersion": 4,
  "serverPayload": "<base64-encrypted>",
  "clientPayload": "<base64-encrypted>",
  "resolutionRequired": true
}
```
The Sync Engine saves this conflict into the `Local Database` and notifies the UI to render the resolution workflow.
