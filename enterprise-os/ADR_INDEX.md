# Life Circle OS — Architectural Decision Records (ADR) Index

> **STATUS:** Approved
> **OWNER:** Architecture Office
> **REVIEW BOARD:** Executive Architecture Board

This index is the single source of truth for all accepted architectural decisions in Life Circle OS. 

**Rule:** No engineering implementation may deviate from an accepted ADR without a superseding ADR being proposed and approved through the [OPERATING_AGREEMENT.md](file:///Users/krishnatiwari/Life%20Circle%20OS/enterprise-os/OPERATING_AGREEMENT.md).

---

### ADR Status Taxonomy
* **Proposed:** Under review by the ARB.
* **Accepted:** Approved and active. Must be followed.
* **Deprecated:** Scheduled for removal.
* **Superseded:** Replaced by a newer ADR.
* **Rejected:** Review failed; do not implement.
* **Experimental:** Approved for limited proof-of-concept only.

---

## Active Decisions

*(This index is a high-level aggregate. Detailed decision records are located in `docs/adr/`)*

| ID | Title | Status | Date |
|:---|:---|:---|:---|
| ADR-001 | Adoption of Clean Architecture | Accepted | Initial Bootstrap |
| ADR-002 | Use of FastAPI for Backend Services | Accepted | Initial Bootstrap |
| ADR-003 | Use of PostgreSQL as Primary Datastore | Accepted | Initial Bootstrap |
| ADR-004 | Use of Playwright for E2E Testing | Accepted | Initial Bootstrap |
| ADR-005 | Messaging Backbone Selection | Accepted | Phase 3B Sprint 3 |
| ADR-006 | Frontend Platform Strategy | Accepted | Phase 3B Sprint 3 |
| ADR-016 | Multi-Tenancy Architecture | Proposed | Sprint 1 Review |
| ADR-017 | Data Classification & Retention Framework | Proposed | Sprint 1 Review |
| ADR-018 | Release Orchestration & Rollback | Proposed | Sprint 1 Review |

## Deprecated Decisions

| ID | Title | Replaced By | Date |
|:---|:---|:---|:---|
| (None currently) | - | - | - |

---

### How to Propose a New ADR

1.  Copy the ADR template from `docs/adr/template.md`.
2.  Assign the next available sequential ID.
3.  Draft the context, decision, and consequences.
4.  Submit for review via the 39-Role ARB.
5.  Upon approval, merge into `docs/adr/` and update this index.
