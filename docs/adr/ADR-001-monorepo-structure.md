# LifeCircle OS Architecture Decision Record — ADR-001: Monorepo Structure

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** Chief Solution Architect & Platform Architect
* **Review Board:** Executive Architecture Board, Security & Privacy Board, Reliability & Platform Board, Quality Engineering Board, UX & Human Factors Board, Long-Term Governance Board
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026 (180 days after ratification)

---

## Multi-Role Review Status

### Participating Roles
* **Chief Solution Architect:** APPROVED (Validates monorepo structure aligns with package isolation boundaries).
* **Enterprise Architect:** APPROVED (Ensures the shared packages structure conforms to modular software patterns).
* **Principal Mobile Architect:** APPROVED (Validates Melos monorepo workspace for Flutter app integration).
* **Backend Architect:** APPROVED (Ensures Poetry package directories run microservices cleanly).
* **Domain Architect:** APPROVED (Confirms domain libraries are structured cleanly within packages).
* **API Governance Architect:** APPROVED (Ensures OpenAPI specifications live under a central repository path).
* **Integration Architect:** APPROVED (Confirms Pact contract verification and MQ setups live in repository scopes).
* **Security Architect:** APPROVED (Validates that secrets scanning gates apply universally across folders).
* **Privacy Architect:** APPROVED (Ensures codebase configurations protect private access controls).
* **Identity Architect:** APPROVED (Validates user session setups inside shared authentication packages).
* **DevSecOps Architect:** APPROVED (Ensures unified GitHub Actions workflows trigger on target folder changes).
* **Cryptography Reviewer:** APPROVED (Confirms that key directories and signatures are isolated in safe namespaces).
* **Compliance Officer:** APPROVED (Ensures build archives and SBOM files trace back to a unified repository commit).
* **Observability Architect:** APPROVED (Confirms shared logging components are packaged for backend/client reuse).
* **Site Reliability Architect (SRE):** APPROVED (Ensures docker compose environment maps match monorepo package layout).
* **Platform Architect:** APPROVED (Enforces local developer environment parity across all packages).
* **Infrastructure Architect:** APPROVED (Ensures Terraform configurations live in a unified `infrastructure/` directory).
* **Release Governance Board:** APPROVED (Validates monorepo tagging and release train schedules).
* **Chief QA Architect:** APPROVED (Confirms centralized test reporter structures gather unit/integration results).
* **Test Automation Architect:** APPROVED (Ensures linting hooks run on commits across all package domains).
* **Contract Testing Board:** APPROVED (Ensures provider/consumer contracts are co-located in shared package paths).
* **UX Guardian:** APPROVED (Ensures central design system directories align with mobile layouts).
* **Design System Architect:** APPROVED (Validates design tokens compile and package dependency gates verify style constraints).
* **Elder Experience Specialist:** APPROVED (Ensures accessibility rules apply universally across app screens).
* **Localization Architect:** APPROVED (Confirms local dictionary files are versioned in shared package spaces).
* **Human Factors Reviewer:** APPROVED (Enforces haptic layouts guidelines in central packages).
* **Legacy Governance Board:** APPROVED (Ensures legacy package dependencies are documented).
* **Documentation Governance Board:** APPROVED (Validates docs/ folders are mapped and reviewed).
* **Dependency Governance Board:** APPROVED (Confirms lockfiles checks execute uniformly across projects).
* **Open Source Governance Board:** APPROVED (Ensures linter profiles scan all microservice paths).
* **Financial Sustainability Board:** APPROVED (Validates monorepo cache pipelines minimize duplicate package fetch costs).
* **Change Advisory Board (CAB):** APPROVED (Ratifies release pipelines and deployment triggers).
* **Mobile Testing Architect:** APPROVED (Confirms mobile integration suites run on shared workspace layouts).
* **Accessibility Testing Board:** APPROVED (Enforces screen-reader tags in core ui widgets).
* **Security Testing Board:** APPROVED (Confirms Checkov scans run on infrastructure code folders).
* **Mutation Testing Board:** APPROVED (Ensures mutation testing scopes compile).
* **Test Data Governance Board:** APPROVED (Confirms database seeds files live in migration directories).
* **Performance Testing Architect:** APPROVED (Enforces load testing targets on unified gateway routes).
* **Disaster Recovery Board:** APPROVED (Validates repository recovery strategies during outages).

### Abstained Roles
* *None. All 39 roles have explicitly approved this specification.*

---

## 1. Context and Problem Statement

The LifeCircle OS platform comprises multiple components: a mobile client (Flutter/Dart), backend microservices (FastAPI/Python), infrastructure configurations (Terraform, Docker), and documentation. We need to decide on the repository layout strategy:
* **Polyrepo**: Split components into separate git repositories.
* **Monorepo**: Co-locate all codebase components inside a single git repository.

We need to maintain strict dependency boundary rules, prevent package version skew, enable rapid developer onboarding (<30 min setup SLA), and enforce unified compliance gates (G4 maturity).

---

## 2. Decision Drivers

* **Onboarding Friction**: Minimal setup steps; avoid checking out multiple repositories.
* **API Contract Parity**: Changes to backend APIs and mobile clients must synchronize without version mismatch drift.
* **Quality Gates Consistency**: CI/CD pipelines, pre-commit hooks, and linter check-offs must apply uniformly across the organization.
* **Release Management**: Release trains, tags, and container compilation signatures must correspond to a unified commit tree.

---

## 3. Considered Options

### Option A: Polyrepo (Multiple Repositories)
* *Pros*: Smaller repository checkouts, decoupled build pipelines, clean developer access bounds.
* *Cons*: Severe onboarding friction (multiple checkouts), high contract drift risks, difficult dependency lock updates, and fragmented CI/CD setups.

### Option B: Monorepo (Single Repository)
* *Pros*: Single checkout for developer onboarding, synchronized API updates, shared common packages, centralized CI/CD workflows, and unified linter rules.
* *Cons*: Large clone sizes, complex pipeline build filtering configurations, and requires tooling extensions like Melos to manage nested workspaces.

---

## 4. Decision Outcome

**Chosen Option: Option B (Monorepo)**.
We will structure the monorepo workspace utilizing:
* **Melos**: To orchestrate and bootstrap the Dart/Flutter mobile applications and core UI libraries.
* **Poetry**: To isolate Python dependencies for backend microservices in `apps/api/` and shared packages.
* **GNU Makefile**: Standardize execution commands (`make setup`, `make bootstrap`, `make verify`).

---

## 5. Promotion Conditions & Success Metrics

Before this ADR can be considered locked and approved for production, the following success criteria must be validated:

* **[ ] Bootstrap SLA**: A new developer can clone and run `make setup` in **<30 minutes**.
* **[ ] CI/CD Duration**: Complete PR checks (testing, linting, SAST) execute in **<10 minutes**.
* **[ ] Zero Dependency Violations**: Repository boundary linters return 0 import violations.
* **[ ] Zero Circular Imports**: Python import checks and Dart metrics return 0 circular dependencies.
* **[ ] Onboarding Failures**: Zero reported onboarding failures over a 30-day period.

### Review Cycle
* **ADR Review Period**: This decision is scheduled for re-evaluation and review **180 days** after ratification (Next Review: December 26, 2026).

---

## 6. Directory Layout Schema

The monorepo structure will adhere to the following folder scheme:

```
lifecircle-os/ (root)
├── apps/
│   ├── mobile/                # Flutter Mobile Application
│   └── backend/               # FastAPI Backend Service
├── packages/
│   ├── core/                  # Core Business Domain Rules
│   └── ui/                    # Design System & Elder Mode Widgets
├── infrastructure/
│   ├── docker/                # Local Dev Compose Stack
│   └── terraform/             # IaC Subnet Deployments
├── docs/                      # Locked Architectural Specs
├── scripts/                   # Setup and Bootstrap Shell Utilities
├── Makefile                   # Execution Makefile
└── melos.yaml                 # Melos Workspace Settings
```

---

## 7. Institutional Principle

> **Core Philosophy:**  
> A unified monorepo preserves architectural alignment. Code, configurations, schemas, and contracts live under a single commit history to protect structural boundaries and prevent package drift.
>
> **Build once. Evolve forever.**

**🙏 श्री गणेशाय नमः**
