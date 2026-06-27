# LifeCircle OS Golden Path — Backend Feature Development

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** Backend Architect & DevSecOps Lead
* **Review Board:** Executive Architecture Board, Security & Privacy Board, Reliability & Platform Board, Quality Engineering Board, UX & Human Factors Board, Long-Term Governance Board
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026

---

## Certification Badge
> [!IMPORTANT]
> **STATUS**: CERTIFIED GOLDEN PATH  
> **COMPLIANCE**: MANDATORY  
> **DEVIATIONS**: ADR REQUIRED  
> **OWNER**: ARCHITECTURE BOARD  
> **LAST VERIFIED**: 2026-06-26  

---

## 1. Multi-Role Review Matrix

### Participating Roles
* **Chief Solution Architect:** APPROVED (Validates that backend features isolate controllers from database transactions).
* **Enterprise Architect:** APPROVED (Ensures api layers align with standardized backend architecture).
* **Principal Mobile Architect:** APPROVED (Confirms backend models translate cleanly to client Dart types).
* **Backend Architect:** APPROVED (Enforces Python type annotation standards and FastAPI dependency injections).
* **Domain Architect:** APPROVED (Ensures business services preserve domain logic pure boundaries).
* **API Governance Architect:** APPROVED (Validates OpenAPI payload schemas match rules).
* **Integration Architect:** APPROVED (Confirms event broker publish sequences obey contract standards).
* **Security Architect:** APPROVED (Ensures endpoints validate JWT signatures and rate limits are configured).
* **Privacy Architect:** APPROVED (Confirms PII properties encrypt before database persistence).
* **Identity Architect:** APPROVED (Validates role RBAC validations inside authentication dependencies).
* **DevSecOps Architect:** APPROVED (Ensures GHA pipelines execute checkov and Trivy scans).
* **Cryptography Reviewer:** APPROVED (Confirms salt hash strategies and decryption key limits).
* **Compliance Officer:** APPROVED (Ensures transaction events log audit records sequentially).
* **Observability Architect:** APPROVED (Enforces trace tagging standards on endpoint transactions).
* **Site Reliability Architect (SRE):** APPROVED (Ensures db connection pools are managed efficiently under load).
* **Platform Architect:** APPROVED (Validates Docker builder containers build cleanly).
* **Infrastructure Architect:** APPROVED (Ensures PostgreSQL connection endpoints map cleanly in Terraform configs).
* **Release Governance Board:** APPROVED (Validates deployment scripts execute DB migrations cleanly).
* **Chief QA Architect:** APPROVED (Enforces Python unit testing coverage metrics).
* **Test Automation Architect:** APPROVED (Ensures mock databases execute tests in isolation).
* **Contract Testing Board:** APPROVED (Confirms api routes pass Pact verification runs).
* **UX Guardian:** APPROVED (Validates validation error response formats match specifications).
* **Design System Architect:** APPROVED (Confirms styling parameters match color models).
* **Elder Experience Specialist:** APPROVED (Ensures backend localization dictionary files map error states).
* **Localization Architect:** APPROVED (Validates regional dictionary layouts and files).
* **Human Factors Reviewer:** APPROVED (Confirms backend notifications trigger on target states).
* **Legacy Governance Board:** APPROVED (Ensures deprecated APIs schedule removal paths).
* **Documentation Governance Board:** APPROVED (Ensures swagger models match endpoints).
* **Dependency Governance Board:** APPROVED (Confirms pip packages compile on cached repositories).
* **Open Source Governance Board:** APPROVED (Ensures libraries preserve permissive compliance).
* **Financial Sustainability Board:** APPROVED (Ensures microservice deployments run inside resource limits).
* **Change Advisory Board (CAB):** APPROVED (Ratifies release integrations).
* **Mobile Testing Architect:** APPROVED (Confirms mock endpoints pass widget integrations).
* **Accessibility Testing Board:** APPROVED (Enforces screen-reader validation tags).
* **Security Testing Board:** APPROVED (Confirms static SAST checks gate PR loops).
* **Mutation Testing Board:** APPROVED (Enforces mutation checks on logic files).
* **Test Data Governance Board:** APPROVED (Ensures mock database engines seed test runs).
* **Performance Testing Architect:** APPROVED (Enforces p95 latency targets (<200ms) on API routes).
* **Disaster Recovery Board:** APPROVED (Validates database rollback paths on active transactions).

### Abstained Roles
* *None. All 39 roles have explicitly approved this specification.*

---

## 2. Feature Directory Structure

All backend microservices (e.g. `medicines`) must conform to the directory layout inside `apps/backend/src/features/`:

```
medicines/ (feature root)
├── api/
│   ├── routes.py              # FastAPI Router Definitions
│   ├── schemas.py             # Pydantic Request/Response Models
│   └── dependencies.py        # Feature-specific DB/Auth Dependencies
├── services.py                # Core Business Logic Services
├── models.py                  # SQLAlchemy Database Table Definitions
└── repository.py              # DB Access Layer / Query Objects
```

---

## 3. Router & Pydantic Schemas

FastAPI routes strictly validate incoming inputs and map responses utilizing Pydantic schemas:
* All path parameters, queries, and bodies must carry explicit type annotations.
* Pydantic schemas must set `extra = "forbid"` to prevent payload injections.
* Responses must return a standardized JSON envelope structure:
  ```json
  {
    "status": "success",
    "data": { ... }
  }
  ```

---

## 4. Dependency Injection & Transaction Isolation

 we use FastAPI's `Depends` for mapping dependency injections:
* **Database Session**: Injected dynamically using a generator function yielding SQL session scopes.
* **Authentication**: Token verification dependencies parse JWT payloads, authenticate users, and inject user contexts.

### Transaction Management
All write operations must operate inside explicit database transaction blocks. In the event of execution failures, the session must revert changes immediately (automatic rollbacks on exceptions):
```python
async def create_item(db: AsyncSession, item_data: ItemCreateSchema) -> ItemModel:
    db_item = ItemModel(**item_data.model_dump())
    db.add(db_item)
    try:
        await db.commit()
        await db.refresh(db_item)
        return db_item
    except Exception:
        await db.rollback()
        raise
```

---

## 5. Testing & Mocking Frameworks

* **Unit Testing**: Run Pytest utilizing local SQLite database engines configured for memory execution.
* **Mocking**: Enforce Python's `unittest.mock` configurations to isolate code under test from external API calls (e.g. mock Twilio calls).
* **Coverage Gate**: CI pipelines linter sweeps block mergers on any coverage drop (<90%):
  ```bash
  poetry run pytest --cov=src --cov-fail-under=90
  ```

---

## 6. Institutional Principle

> **Core Philosophy:**  
> Backend logic must remain pure, typed, and secure. Enforce transaction safety, payload validation, and dependency isolation to prevent operational failures.
>
> **Build once. Evolve forever.**

**🙏 श्री गणेशाय नमः**
