# Life Circle OS — Technology Layer Architecture

> **STATUS:** Approved
> **OWNER:** Chief Solution Architect
> **REVIEW BOARD:** Executive Architecture Board
> **LAST REVIEW DATE:** 2026-06-27

This document serves as the entry point to the Life Circle OS technical architecture, providing a high-level map of the system boundaries, communication protocols, and technology stack.

---

## 1. System Topology

Life Circle OS is designed using a **Clean Architecture** approach with strict bounded contexts. The system is composed of:

*   **Frontend Apps:** Next.js (Web), Flutter (Mobile) *[Ref: ADR-006]*
*   **Backend Services:** FastAPI (Python 3.12).
*   **Data Persistence:** PostgreSQL (Transactional), Redis (Caching/State).
*   **Asynchronous Messaging:** RabbitMQ (Event Bus / Outbox Pattern) *[Ref: ADR-005]*

## 2. Core Principles

1.  **Domain Isolation:** The core business rules (`domain/`) must never depend on frameworks, databases, or external APIs.
2.  **API First:** All client-server communication occurs over strictly typed REST/GraphQL APIs (governed by OpenAPI schemas).
3.  **Event-Driven Evolution:** Cross-boundary communication utilizes asynchronous events to minimize synchronous coupling.
4.  **Zero-Trust Security:** Every request must be authenticated, authorized, and validated at the boundary edge.

## 3. Detailed Architecture References

For deep dives into specific subsystems, refer to the canonical documents in the Knowledge Layer:

*   **Backend Architecture:** [docs/backend-architecture.md](file:///Users/krishnatiwari/Life%20Circle%20OS/docs/backend-architecture.md)
*   **Frontend/Mobile Architecture:** [docs/mobile-architecture.md](file:///Users/krishnatiwari/Life%20Circle%20OS/docs/mobile-architecture.md)
*   **Database Architecture:** [docs/database-architecture.md](file:///Users/krishnatiwari/Life%20Circle%20OS/docs/database-architecture.md)
*   **Infrastructure Architecture:** [docs/infrastructure-architecture.md](file:///Users/krishnatiwari/Life%20Circle%20OS/docs/infrastructure-architecture.md)
*   **Security & Identity:** [docs/security-pipeline.md](file:///Users/krishnatiwari/Life%20Circle%20OS/docs/security-pipeline.md)

*Any changes to these fundamental boundaries require a formal ADR and approval via the [OPERATING_AGREEMENT.md](file:///Users/krishnatiwari/Life%20Circle%20OS/enterprise-os/OPERATING_AGREEMENT.md).*
