---
last_updated: "2026-07-11T23:15:00Z"
---
# Active Architectural Decisions (ADR Summary)

- **Routing:** `GoRouter` with strict state-machine interception (`AuthStage`).
- **Identity:** Mobile Number & Email only. No social logins.
- **Storage:** `Isar` (Encrypted offline-first local source of truth).
- **State:** `Riverpod` with code generation.
- **Conflict Resolution:** 
  - Medicines = Last-Write-Wins (LWW)
  - Tasks = Optimistic Concurrency Control (OCC)
  - Finance = Immutable Append-Only Ledger
- **Governance:** JSON ARB evidence required for all merges.
