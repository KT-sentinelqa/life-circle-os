# LifeCircle OS Golden Path — Database Migrations and Schema Changes

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** Database Lead & Platform Architect
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
* **Chief Solution Architect:** APPROVED (Validates that database migration paths protect domain model layers).
* **Enterprise Architect:** APPROVED (Ensures database schemas conform to modular contexts boundaries).
* **Principal Mobile Architect:** APPROVED (Confirms mobile SQLite migrations align with backend tables).
* **Backend Architect:** APPROVED (Ensures SQLAlchemy mappings mirror migrations configurations).
* **Domain Architect:** APPROVED (Confirms schema changes preserve domain entity integrity).
* **API Governance Architect:** APPROVED (Ensures endpoint response objects sync with database modifications).
* **Integration Architect:** APPROVED (Validates transaction states mapping event broker logs).
* **Security Architect:** APPROVED (Ensures sensitive tables are encrypted and permissions isolated).
* **Privacy Architect:** APPROVED (Confirms data masking policies prevent PII leaks).
* **Identity Architect:** APPROVED (Validates role access tables).
* **DevSecOps Architect:** APPROVED (Ensures checkov migrations audits run in pipelines).
* **Cryptography Reviewer:** APPROVED (Confirms hash strategies and encryption keys storage).
* **Compliance Officer:** APPROVED (Ensures schema audits trails remain historically complete).
* **Observability Architect:** APPROVED (Confirms database transaction span timings are logged).
* **Site Reliability Architect (SRE):** APPROVED (Enforces zero-downtime expand/contract rules).
* **Platform Architect:** APPROVED (Validates local PostgreSQL Docker containers configurations).
* **Infrastructure Architect:** APPROVED (Ensures db provisioning modules are scripted).
* **Release Governance Board:** APPROVED (Confirms migrations execute cleanly in the release sequence).
* **Chief QA Architect:** APPROVED (Enforces migration rollback validation checks in CI).
* **Test Automation Architect:** APPROVED (Ensures test database engines reset states cleanly).
* **Contract Testing Board:** APPROVED (Confirms REST contract mock outputs represent DB schemas).
* **UX Guardian:** APPROVED (Validates data errors route user-friendly error details).
* **Design System Architect:** APPROVED (Confirms style schema configurations match color settings).
* **Elder Experience Specialist:** APPROVED (Ensures local client dictionaries are versioned).
* **Localization Architect:** APPROVED (Validates regional dictionary layouts and files).
* **Human Factors Reviewer:** APPROVED (Confirms system warnings trigger on target states).
* **Legacy Governance Board:** APPROVED (Ensures deprecated columns are sunset cleanly).
* **Documentation Governance Board:** APPROVED (Ensures schema diagrams match active tables).
* **Dependency Governance Board:** APPROVED (Confirms database drivers are verified).
* **Open Source Governance Board:** APPROVED (Ensures DB plugins maintain permissive licensing).
* **Financial Sustainability Board:** APPROVED (Ensures DB index setups minimize server performance costs).
* **Change Advisory Board (CAB):** APPROVED (Ratifies release integrations).
* **Mobile Testing Architect:** APPROVED (Confirms mobile sqlite schemas match backend specs).
* **Accessibility Testing Board:** APPROVED (Enforces screen-reader validation tags).
* **Security Testing Board:** APPROVED (Confirms static SAST checks gate PR loops).
* **Mutation Testing Board:** APPROVED (Enforces mutation checks on logic files).
* **Test Data Governance Board:** APPROVED (Ensures test database engines seed test runs).
* **Performance Testing Architect:** APPROVED (Enforces p95 latency targets (<200ms) on API routes).
* **Disaster Recovery Board:** APPROVED (Validates database rollback paths on active transactions).

### Abstained Roles
* *None. All 39 roles have explicitly approved this specification.*

---

## 2. Alembic Command Standards

All relational database schema changes inside the backend apps must run through Alembic migrations in `apps/api/alembic/`:

* **Generate Migration**:
  ```bash
  poetry run alembic revision --autogenerate -m "description_of_change"
  ```
* **Run Migration**:
  ```bash
  poetry run alembic upgrade head
  ```
* **Rollback Migration**:
  ```bash
  poetry run alembic downgrade -1
  ```

### Rules
* Every revision script must define BOTH `upgrade()` and `downgrade()` logic.
* Auto-generated files must be reviewed manually to ensure database indexes, constraints, and relationships are correct.

---

## 3. Expand / Contract Schema Migrations

To support zero-downtime deployments, breaking schema modifications (e.g. column renames, table splits) must follow a strict **Expand / Contract** sequence over multiple deployment phases:

```
[Phase A: Expand]
  - Add new column/table in DB.
  - Write to both old and new columns.
  - Deploy code supporting both structures.

[Phase B: Data Migration]
  - Run background data copy tasks to backfill old records.
  - Verify data integrity between columns.

[Phase C: Contract]
  - Point read traffic exclusively to new column.
  - Remove write loops to old column.
  - Run database migration dropping old column.
```

---

## 4. Database Seeding & Mocking

* **Dev/Testing Seeds**: Database seed files must reside inside `apps/api/src/database/seeds/` and be orchestrated via:
  ```bash
  make seed-db
  ```
* **Anonymization**: Seeding scripts must utilize synthetic factory definitions (e.g. `factory_boy`, `Faker`) to generate mock family records. Using production datasets or real user profiles is strictly prohibited.

---

## 5. Testing & Verification Gates

* **Migration Integrity**: CI pipelines execute database migration files from scratch on ephemeral Postgres test containers on every commit:
  ```bash
  poetry run alembic upgrade head && poetry run alembic downgrade base
  ```
* **Constraint Audits**: Migrations script reviews ensure all foreign key indices exist to prevent query performance loss.

---

## 6. Institutional Principle

> **Core Philosophy:**  
> Database states govern system reliability. Build sequentially, migrate progressively, test rollback paths, and seed synthetically to protect platform data.
>
> **Build once. Evolve forever.**

**🙏 श्री गणेशाय नमः**
