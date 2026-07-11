# LifeCircle OS — ADR Lifecycle Policy

**Status**: Approved
**Owner**: Architecture Lead
**Effective**: Phase 4 Sprint 5

## Purpose
As the platform grows, ADRs must evolve. This document defines the formal lifecycle states and transition rules for all Architecture Decision Records.

---

## Lifecycle States

```
Proposed → Approved → Superseded
                    → Deprecated
```

| State | Meaning |
| :--- | :--- |
| **Proposed** | ADR is drafted and under Architecture Review Board review. No implementation may begin. |
| **Approved** | ARB has formally approved the decision. Implementation may proceed. |
| **Superseded** | A newer ADR has replaced this one. This ADR remains readable for historical context. |
| **Deprecated** | The decision is no longer applicable (e.g., a feature was removed). Preserved for audit trail only. |

---

## Transition Rules

### Proposed → Approved
- Requires explicit `APPROVED` from the Architecture Review Board.
- ARB review must occur within 5 business days of proposal submission.

### Approved → Superseded
- A new ADR must reference the superseded ADR by number.
- The superseded ADR must be updated with `Status: Superseded by ADR-XXX`.
- The new ADR's `Context` section must explain why the previous decision is no longer sufficient.

### Approved → Deprecated
- Requires Architecture Lead sign-off.
- Must include a reason for deprecation.
- Does not require a replacement ADR.

---

## ADR Index (Phase 4 Complete)

| ADR | Title | Status |
| :--- | :--- | :--- |
| ADR-001 | Clean Architecture Boundaries | Approved |
| ADR-002 | Offline-First with Outbox Pattern | Approved |
| ADR-003 | Domain-Driven Design Aggregate Rules | Approved |
| ADR-004 | Authorization Platform Separation | Approved |
| ADR-005 | Public SDK Capability Boundaries | Approved |
| ADR-006 | Domain Event Contract | Approved |
| ADR-007 | Event-Driven Architecture Freeze | Approved |
| ADR-008 | Subscriber Execution Ordering | Approved |
| ADR-009 | Production Readiness Declaration | Approved |

---

## Rules for New ADRs

1. ADR numbers are **sequential and never recycled**.
2. Every ADR must include: Status, Date, Context, Decision, and Consequences.
3. Every ADR must be reviewed by the ARB before implementation begins.
4. Breaking changes to existing ADRs require a new superseding ADR, not an edit.
5. ADRs live in `docs/architecture/` and are tracked in this index.
