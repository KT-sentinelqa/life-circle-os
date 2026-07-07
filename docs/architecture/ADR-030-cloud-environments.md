# ADR-030: Cloud Environments & Operations

## Context
As we begin implementing the backend (Phase 4.4C) and deploying the Synchronization Engine, we need a disciplined operational model to prevent regressions and secure secrets.

## Decision
We establish a **Strict Promotion Pipeline** with three distinct environments:

### 1. Development (DEV)
* **Purpose**: Active feature implementation.
* **Data**: Mock data, wiped nightly.
* **Access**: All engineers.
* **Infrastructure**: Ephemeral containers or local Docker Compose.

### 2. Staging (STG)
* **Purpose**: Exact replica of Production for QA and Integration Testing.
* **Data**: Synthetic/anonymized data only. No real family data.
* **Promotion Rule**: Code must pass all MASVS automated security checks and CI/CD tests before merging to Staging.

### 3. Production (PRD)
* **Purpose**: The live Cloud Trust Platform.
* **Access**: Zero direct developer access to PostgreSQL or Redis. All actions via audited CI/CD or Break-Glass SRE procedures.
* **Secrets**: Managed exclusively via HashiCorp Vault or AWS/GCP Secret Manager. No `.env` files in PRD.

## Consequences
* Ensures we never test against real family data.
* Mandates CI/CD from day one of backend development.
