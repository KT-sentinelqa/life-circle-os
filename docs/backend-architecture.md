# LifeCircle OS — Backend Architecture Specification

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** Backend Architect
* **Review Board:** Executive Architecture Board, Security & Privacy Board, Reliability & Platform Board, Quality Engineering Board, UX & Human Factors Board, Long-Term Governance Board
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026

---

## Multi-Role Review Status

### Participating Roles
* **Chief Solution Architect:** APPROVED (Validates DDD bounded context boundaries in backend directory structures).
* **Enterprise Architect:** APPROVED (Ensures service decoupling patterns facilitate long-term maintenance).
* **Principal Mobile Architect:** APPROVED (Confirms API endpoints conform to mobile client deserialization schemas).
* **Backend Architect:** APPROVED (Validates FastAPI, SQLAlchemy, and clean architecture specs).
* **Domain Architect:** APPROVED (Ensures business rule logic inside `domain/` is pure and framework-independent).
* **API Governance Architect:** APPROVED (Validates URL paths, version patterns, and OpenAPI specs).
* **Integration Architect:** APPROVED (Confirms backend RabbitMQ handlers and sync outbox conflict managers).
* **Security Architect:** APPROVED (Enforces WAF controls, rate-limiting, and RBAC validations).
* **Privacy Architect:** APPROVED (Ensures column-level encryption and DPDP/GDPR storage rules).
* **Identity Architect:** APPROVED (Validates JWT authentication flows, session revocations, and role scopes).
* **DevSecOps Architect:** APPROVED (Ensures automated backend checks run in Git pipelines).
* **Cryptography Reviewer:** APPROVED (Validates database encryption-at-rest keys and TLS settings).
* **Compliance Officer:** APPROVED (Validates backend data alignment with local fiduciaries guidelines).
* **Observability Architect:** APPROVED (Confirms OpenTelemetry logger formatting and Correlation-ID injection).
* **Site Reliability Architect (SRE):** APPROVED (Validates that API performance metrics conform to SRE availability SLOs).
* **Disaster Recovery Board:** APPROVED (Confirms continuous WAL snapshots and recovery objectives).
* **Platform Architect:** APPROVED (Validates hosting configurations and caching layers).
* **Infrastructure Architect:** APPROVED (Ensures infrastructure provisioning specs map to Terraform code).
* **Release Governance Board:** APPROVED (Enforces database migration backward compatibility rules).
* **Chief QA Architect:** APPROVED (Validates unit, integration, and load testing coverage requirements).
* **Test Automation Architect:** APPROVED (Ensures API integration tests run against isolated containers).
* **Performance Testing Architect:** APPROVED (Validates load testing setups conform to latency targets).
* **Security Testing Board:** APPROVED (Confirms backend SAST and dynamic vulnerability checking scopes).
* **Contract Testing Board:** APPROVED (Validates Pact provider verification checks).
* **Test Data Governance Board:** APPROVED (Ensures test data seeding factories are isolated from production databases).
* **UX Guardian:** APPROVED (Ensures API endpoints return appropriate localization keys).
* **Legacy Governance Board:** APPROVED (Ensures backend codebase structure is clean and readable).
* **Documentation Governance Board:** APPROVED (Ensures OpenAPI specifications are generated dynamically).
* **Dependency Governance Board:** APPROVED (Enforces license checks and package freshness policies).
* **Change Advisory Board (CAB):** APPROVED (Validates database schema migrations).

### Abstained Roles
* **Accessibility Testing Board:** ABSTAINED. Reason: Backend JSON payloads are independent of client WCAG rendering checks.
* **Mobile Testing Architect:** ABSTAINED. Reason: Widget golden tests and mobile rendering tests are outside the scope of backend APIs.
* **Design System Architect:** ABSTAINED. Reason: Visual design tokens do not alter backend API router definitions.
* **Elder Experience Specialist:** ABSTAINED. Reason: Mobile UI accessibility scale layouts do not change FastAPI routers.
* **Localization Architect:** ABSTAINED. Reason: UI visual expansion checks do not impact API routers.
* **Human Factors Reviewer:** ABSTAINED. Reason: Mobile physical targets do not impact backend logic.
* **Open Source Governance Board:** ABSTAINED. Reason: Self-hosting fallbacks are governed under the Business Model.
* **Financial Sustainability Board:** ABSTAINED. Reason: Operational cost specifications are managed under the Cost Model.

---

## 1. Architectural Patterns & Layering Boundaries

The LifeCircle OS backend coordination platform is built using FastAPI (Python 3.12+) implementing **Clean Architecture** and **Hexagonal Architecture** (Ports and Adapters) patterns. 

The codebase is organized using a **feature-first** directory structure:

### Backend Module Layout
```
backend/
└── src/
    ├── core/                   # Shared system utilities
    │   ├── security/           # JWT, passwords, KMS crypto
    │   ├── observability/      # OpenTelemetry and structured logging
    │   └── configuration/      # Config validation (Pydantic settings)
    │
    ├── features/               # Bounded Contexts
    │   ├── medicines/          # Context: Medicines
    │   │   ├── domain/         # Pure Entities and domain rules (No SQLModel/FastAPI)
    │   │   ├── application/    # Use cases, orchestrators, and validation DTOs
    │   │   ├── infrastructure/ # SQLAlchemy DB repositories, RabbitMQ publishers
    │   │   └── presentation/   # FastAPI routers, endpoints, and input schemas
    │   │
    │   ├── finance/            # Context: Finance (Bills/EMIs)
    │   └── household/          # Context: Household (Tasks/Helpers)
    │
    └── bootstrap/
        ├── main.py             # FastAPI App initialization
        ├── middleware.py       # Global CORS, Logging, and Correlation middleware
        └── lifecycle.py        # Startup/Shutdown connection pooling hooks
```

### Backend Runtime Architecture
```
Internet
    ↓
API Gateway
    ↓
FastAPI Presentation Layer
    ↓
Application Services
    ↓
Domain Layer
    ↓
Infrastructure Adapters
    ├── PostgreSQL
    ├── Redis
    └── RabbitMQ
```

---

## 2. Layer Execution Rules

To enforce clean dependency flow and protect core domain rules:
* **Presentation Layer:** FastAPI HTTP routers validate input schemas (Pydantic) and delegate tasks to application services. No database queries or business operations are executed in routers.
* **Application Layer:** Use cases coordinate entities, invoke domains, and call infrastructure ports. Contains no database dialect syntax or framework logic.
* **Domain Layer:** Pure Python code holding validation schemas, value objects, and business rules. Has **zero imports** from database libraries (SQLAlchemy, SQLModel) or framework packages (FastAPI).
* **Infrastructure Layer:** Concrete implementations of repositories (SQLAlchemy 2.0 Async ORM queries, RabbitMQ publishing operations, and Redis caches).
* *Layer violations (e.g., Domain layer importing FastAPI or infrastructure modules) are caught in the CI/CD pipeline and fail the build.*

### Repository Standards
* Repositories return domain entities only.
* Repositories must never expose raw database ORM models to outer layers.
* Repositories must never leak SQLAlchemy sessions.
* Repositories must never contain business rules.
* Repositories must remain bounded-context specific.

### Transaction Management Rules
* **One request = one Unit of Work:** The lifecycle of a database transaction is bound to a single HTTP request context.
* **Application services boundary:** Application services own transaction boundaries, initiating and concluding the Unit of Work.
* **Domain purity:** Domain entities never commit transactions.
* **Nested transactions:** Nested transactions require explicit ADR approval.
* **Cross-context transactions:** Cross-context transactions (transactions spanning multiple bounded contexts) are strictly forbidden.

### Dependency Injection Rules
* **Allowed Patterns:**
  * FastAPI `Depends` in the presentation layer.
  * Constructor injection in application services.
* **Forbidden Patterns:**
  * Service locators patterns.
  * Global mutable state.
  * Hidden singleton repositories.
  * Runtime reflection-based injection.

---

## 3. Technology Stack & Resource Pooling

To guarantee P95 latencies under <300ms:
* **FastAPI Engine:** Leverages asynchronous executions (`async/await`) and standard `asyncio` event loops.
* **PostgreSQL Connection Pool:** PostgreSQL queries are routed asynchronously via `asyncpg` connection pools. Standard queries are indexed, and sequential scans are blocked.
* **Redis Cache & Session Store:** Caches sessions, API rate-limiting records, and JWT blacklists.
* **RabbitMQ Message Broker:** Coordinates all backend asynchronous domain events, notification queues, and background worker queues.
  * *Redis is restricted to caching and sessions; it is prohibited from acting as the system event backbone.*

### Database Standard
* **SQLAlchemy 2.0 Async:** SQLAlchemy 2.0 Async ORM is mandatory for database interactions.
* **asyncpg Driver:** `asyncpg` is used exclusively as the asynchronous PostgreSQL driver beneath the ORM layer.
* **Direct SQL execution:** Direct SQL execution is permitted only for documented performance-critical paths.
* **Alembic Migrations:** Alembic governs all database schema migrations.

### Background Processing Rules
* **Allowed Operations:**
  * Notifications delivery dispatch.
  * Database backup jobs.
  * Device synchronization workflows.
  * Aggregated report generation.
* **Forbidden Operations:**
  * Direct user request handling.
  * Critical synchronous business validation.
  * Authentication and authorization logic.

### Migration Standards
* **Forward-only migrations:** All schema updates must be forward-only.
* **Rollback scripts mandatory:** Every migration must be accompanied by a validated rollback script.
* **Zero destructive migrations:** Destructive migrations (e.g., dropping columns/tables) are forbidden without ADR approval.
* **Phased rollouts:** Long-running migrations (e.g., retrofitting indexes or large data migrations) require phased rollout plans.
* **Blue-green compatibility:** All schema changes must maintain backward compatibility to support blue-green zero-downtime production upgrades.

---

## 4. API Security & OWASP ASVS 5.0 Compliance

All backend routers comply with OWASP ASVS 5.0 and API Security Top 10 guidelines:
* **Input Sanitization:** Inbound parameters are verified at the schema layer (Pydantic), validating types, sanitizing strings against XSS, and validating ranges.
* **Granular Role-Based Access Controls (RBAC):** Every endpoint checks active session scopes (derived from verified JWTs) against the user's family role (Coordinator, Co-Pilot, Elder, Guest).
* **Authorization Verification (BOLA/BFLA Prevention):** Endpoints verify that resource IDs belong to the requesting user’s family context before database writes are processed.
* **Session Lifecycle:** JWT sessions expire in 15 minutes. Rotated refresh tokens are tracked in Redis, allowing immediate revocation upon logout.

---

## 5. Distributed Tracing & Observability

* **OpenTelemetry Middleware:** Every incoming HTTP request or message consumer queue event is intercepted to verify the presence of `X-Correlation-ID` and `X-Trace-ID` headers.
* **Trace Propagation:** Correlation IDs are automatically injected into the logging context and propagated to RabbitMQ event headers.
* **Audit Trails:** Administrative changes (role updates, bill payments) write immutable logs carrying Audit IDs.

---

## 6. Infrastructure Reliability & Platform Continuity

* **Failure Isolation:** Bounded contexts run inside isolated database schemas or micro-services. A failure in the `Household` context must never disrupt `Medicines` schedules.

### Circuit Breaker Standards
* **Protected Integrations:**
  * SMS providers.
  * Email providers.
  * Push notification systems.
* **Circuit Breaker Policy:**
  * Exponential backoff.
  * Jitter enabled on retries to avoid thundering herd problems.
  * Half-open recovery state implementation.
  * Dead-letter queues (DLQ) for permanent failures.

### Health Endpoints
* **GET `/health/live`:** Monitors process liveness (process alive check only).
* **GET `/health/ready`:** Monitors readiness by checking connectivity and health of:
  * PostgreSQL database connection pool.
  * Redis cache/session store.
  * RabbitMQ event broker.
  * Configuration parameter validation.
* **GET `/health/startup`:** Validates startup completeness:
  * Database migration completion status.
  * Secrets availability and accessibility.
  * Initial service dependency checks.

---

## 7. Institutional Backend Principle

> **Core Philosophy:**  
> The backend platform is the final validator of the system's business rules. Client constraints are for user experience; backend constraints are for data integrity.

**Build once. Evolve forever.**

🙏 श्री गणेशाय नमः
