# LifeCircle OS — Repository Structure Specification

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** Executive Architecture Board & Principal Architects
* **Review Board:** Executive Architecture Board, Security & Privacy Board, Reliability & Platform Board, Quality Engineering Board, UX & Human Factors Board, Long-Term Governance Board
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026

---

## Multi-Role Review Status

### Participating Roles
* **Chief Solution Architect:** APPROVED (Confirms that monorepo directory structures isolate bounded contexts and packages).
* **Enterprise Architect:** APPROVED (Validates that shared package boundaries and promotion policies align with service decoupling rules).
* **Principal Mobile Architect:** APPROVED (Confirms that mobile features-first layouts match clean architecture constraints).
* **Backend Architect:** APPROVED (Validates that backend folder mappings isolate routers, services, repositories, and entities).
* **Domain Architect:** APPROVED (Enforces strict domain folder isolation, ensuring zero outer framework dependencies).
* **API Governance Architect:** APPROVED (Confirms shared contract schemas are managed under their own package boundaries).
* **Integration Architect:** APPROVED (Ensures that shared event formats and messaging schemas sit in dedicated packages).
* **Security Architect:** APPROVED (Validates that encryption libraries and authentication models are isolated in private packages).
* **Privacy Architect:** APPROVED (Confirms that PII-handling code segments are isolated within specific features structures).
* **Identity Architect:** APPROVED (Ensures IAM configurations and account verification paths map to dedicated folders).
* **DevSecOps Architect:** APPROVED (Confirms that pipeline check linting rules verify dependency boundaries in CI).
* **Cryptography Reviewer:** APPROVED (Validates that cryptographic modules reside in secure, isolated packages).
* **Compliance Officer:** APPROVED (Ensures that consent log schemas are protected in identity features).
* **Observability Architect:** APPROVED (Confirms observability exporter packages are isolated and reusable).
* **Site Reliability Architect (SRE):** APPROVED (Validates that operational directories contain auto-scaling and failover templates).
* **Disaster Recovery Board:** APPROVED (Confirms backup scripts and PITR WAL utilities sit in infrastructure folders).
* **Platform Architect:** APPROVED (Validates that Redis caching configurations are isolated to infrastructure packages).
* **Infrastructure Architect:** APPROVED (Ensures Terraform sub-modules sit inside declared IaC directories).
* **Release Governance Board:** APPROVED (Enforces that version tagging configurations are central to the monorepo root).
* **Chief QA Architect:** APPROVED (Confirms QA testing packages are isolated in the testing-kit folder).
* **Test Automation Architect:** APPROVED (Ensures testing modules support API and mobile widget testing pipelines).
* **Performance Testing Architect:** APPROVED (Enforces query execution and capacity allocation configurations).
* **Security Testing Board:** APPROVED (Validates checkov/tfsec scanning configurations).
* **Mutation Testing Board:** APPROVED (Ensures mutation testing rules protect domain repositories).
* **Contract Testing Board:** APPROVED (Confirms contract test assertions sit inside the testing-kit package).
* **Test Data Governance Board:** APPROVED (Ensures test data seeding uses anonymized fixtures).
* **UX Guardian:** APPROVED WITH CONDITIONS (Ensures design-system packages are compiled and distributed without breaking layout tokens).
* **Design System Architect:** APPROVED (Confirms typography, colors, and layout metrics are isolated in the design-system package).
* **Elder Experience Specialist:** APPROVED WITH CONDITIONS (Ensures elder mode widgets sit inside standard presentation folders).
* **Localization Architect:** APPROVED (Validates localized dictionary JSONs are managed in dedicated localization packages).
* **Human Factors Reviewer:** APPROVED (Ensures buttons ergonomics files map to presentation widgets).
* **Legacy Governance Board:** APPROVED (Enforces strict naming conventions, folder structures, and rejects tribal configurations).
* **Documentation Governance Board:** APPROVED (Ensures spec documents are structured cleanly under the docs/ folder).
* **Dependency Governance Board:** APPROVED (Enforces package.json and requirements.txt vulnerability check-offs).
* **Open Source Governance Board:** APPROVED (Confirms monorepo license structures are open-source compliant).
* **Financial Sustainability Board:** APPROVED (Ensures compute parameters are optimized to fit cloud resource limits).
* **Change Advisory Board (CAB):** APPROVED (Validates shared folder promotion policies, public API boundaries, circular dependency detection, and bootstrap standards under LOCKED v1.0 constraints).

### Abstained Roles
* **Mobile Testing Architect:** ABSTAINED. Reason: Unit widget automated tests are executed locally by developers, not defined by monorepo layouts.
* **Accessibility Testing Board:** ABSTAINED. Reason: Screen reader accessibility audits are client-side check-offs.

---

## 1. Monorepo Directory Map

To guarantee consistent quality controls, simplify dependency updates, and prevent architectural fragmentation, LifeCircle OS adopts a unified **Monorepo** strategy:

```
LifeCircle-OS/ (Monorepo Root)
├── apps/
│   ├── mobile/               # Flutter mobile application
│   ├── backend/              # FastAPI backend coordination service
│   └── admin/                # Administrator dashboard portal (Future phase)
│
├── packages/
│   ├── design-system/        # Shared mobile design system tokens and widgets
│   ├── shared-contracts/     # Dynamic OpenAPI / Pact API schemas
│   ├── shared-domain/        # Shared core value objects and validation interfaces
│   ├── observability/        # OpenTelemetry exporters, logs filters
│   └── testing-kit/          # Test mocks, database transaction transaction triggers
│
├── infrastructure/           # Terraform IaC templates, environment modules
├── docs/                     # Specifications, ADRs, IDRs, runbooks
├── scripts/                  # Deploy scripts, release tags automation
├── tools/                    # Local development linters, config scripts
└── governance/               # ARB constitutions, charter reviews, GDRs
```

### Repository Evolution Matrix
To guide long-term codebase expansions, the following repository states are defined. This prevents future architectural drift:

| Phase | Repository State | Key Milestone / Description |
| :--- | :--- | :--- |
| **Phase 1** | Single monorepo | Unified codebase for mobile, backend, and core documentation |
| **Phase 2** | Shared packages extracted | Promotion of reusable modules to the `/packages` directory |
| **Phase 3** | Admin application introduced | Introduction of the `/apps/admin` coordination portal |
| **Phase 4** | Plugin ecosystem | Sandboxed plugin integration hooks and external interfaces |
| **Phase 5** | External SDKs | Public API distribution for third-party fiduciary integrations |

---

## 2. Feature-First Architecture Doctrine

LifeCircle OS enforces a strict **Feature-First** organization standard. Features contain their architectural layers internally. Architectural layers **SHALL NOT** contain feature folders:

* **Allowed Organization Pattern:**
  ```
  features/
  └── medicines/
      ├── domain/             # Pure entities, domain rules (No SQLModel / Flutter)
      ├── application/        # Use-cases, coordinators, inputs validation
      ├── infrastructure/     # SQL databases Repositories, RabbitMQ publishers
      └── presentation/       # API router endpoints, UI views, controllers
  ```
* **Forbidden Organization Pattern:**
  ```
  routers/                    # Global layers containing feature details (BANNED)
  models/                     # BANNED
  repositories/               # BANNED
  ```

This ensures that features can be developed, tested, and deleted independently without causing ripple modifications across global folder layers.

---

## 3. Repository Directory Ownership & CODEOWNERS

### Repository Directory Ownership Matrix
To prevent unowned folders and maintain clear accountability across the codebase, directories are mapped to primary and secondary architect owners:

| Directory Path | Primary Owner Role | Secondary Owner Role |
| :--- | :--- | :--- |
| `/apps/mobile` | Principal Mobile Architect | Mobile Testing Architect |
| `/apps/api` | Backend Architect | Chief Solution Architect |
| `/packages/design-system` | Design System Architect | UX Guardian |
| `/packages/shared-contracts` | API Governance Architect | Contract Testing Board |
| `/infrastructure` | Infrastructure Architect | Platform Architect |
| `/docs` | Documentation Governance Board | Founder Office |
| `/governance` | Executive Architecture Board | Change Advisory Board (CAB) |

*All sub-folders inherit directory ownership rules unless explicitly documented via a child repository decision record.*

### CODEOWNERS Governance & Branch Protection
* **Mandatory CODEOWNERS Mapping:**
  ```
  /apps/mobile/               @principal-mobile @mobile-testing
  /apps/api/              @backend-architect
  /packages/design-system/    @design-system
  /infrastructure/            @infra-board
  /docs/                      @docs-board
  ```

* **Protected Branches:**
  * `main`
  * `release/*`
  * `governance/*`

* **Review Gate:** Code changes require approval from the mapped CODEOWNERS. *No self-approval.*

---

## 4. Layer Dependency Rules & Pipeline Enforcement

Dependency imports must flow strictly in a single downward direction:

```
Presentation Layer (HTTP API Routers / Flutter UI Screens)
                 ↓
Application Layer (Use Cases / Orchestrator Services)
                 ↓
Infrastructure Layer (SQL DB Repositories / Message Broker)
                 ↓
Domain Layer (Pure Python/Dart Entities & Business Rules)
```

### Dependency Rules
1. **Domain Purity:** The `domain` layer has zero outer dependencies. Under no circumstances shall domain files import backend frameworks (`fastapi`, `sqlalchemy`) or mobile UI libraries (`flutter`).
2. **Infrastructure Decoupling:** The `domain` and `application` layers are decoupled from database dialects or external APIs.
3. **No Upward Imports:** Application classes must not import routers; domain classes must not import repositories.
4. **No Direct Ingress:** Presentation layers **SHALL NOT** import infrastructure directories directly; all requests must flow through the application layer.

### Public API Boundary Policy
Every package MUST expose:

```
packages/design-system/
└── lib/
    ├── design_system.dart   ← PUBLIC API ONLY
    └── src/                 ← PRIVATE
```

**Rule:**
* **ALLOWED:** `import 'package:design_system/design_system.dart'`
* **FORBIDDEN:** `import 'package:design_system/src/...'`

*CI must fail on violations. Large monorepos rely on explicit public APIs and automated boundary enforcement to avoid architectural erosion.*

### Circular Dependency Detection Policy
The target threshold for cyclic relationships is:

```
Circular Dependencies = 0
```

#### Required Tools
* **Backend:**
  * `import-linter`
  * `pydeps`
* **Mobile:**
  * `dart_code_metrics`
  * custom analyzer rules

#### Pipeline Integration
```yaml
check-boundaries:
    - import-linter
    - pydeps
    - dart analyze
    - dart_code_metrics
```
*No merge without green architectural checks.*

---

## 5. Shared Package Promotion Policy

To prevent premature abstraction, messy folder structures, and utility dumping grounds, codebase promotion follows the **Rule of Three**:

```
[1x Used] -> Confined inside the feature directory (Local scoping).
     ↓
[2x Used] -> Technical review. Copy-pasting allowed to keep features isolated.
     ↓
[3x Used] -> Promoted to shared package (e.g. moved to /packages/ shared module).
```

* **Anti-Utility Rule:** The creation of global utility repositories (such as `packages/common/` or `packages/utils/`) is strictly prohibited. Packages must be domain-specific and single-purpose (e.g. `packages/observability`).

### Package Lifecycle Governance
Every package requires metadata. Unowned packages are institutional debt. The required metadata schema includes:

* **OWNER:** Designated ARB role owner.
* **PURPOSE:** Functional domain focus.
* **PUBLIC API:** Exposed entry point files.
* **DEPENDENCIES:** Approved parent packages.
* **CONSUMERS:** Downstream applications or packages.
* **CREATED:** Date of first release tag.
* **LAST REVIEWED:** Date of the last check-off.
* **RETIREMENT CONDITIONS:** Criteria for package deprecation/retirement.

---

## 6. Repository Anti-Patterns Registry

The following patterns are constitutional violations. Detected occurrences must be immediately refactored according to the remediation guidelines:

| Anti-Pattern | Description | Mandatory Remediation Procedure |
| :--- | :--- | :--- |
| ❌ **common/ or utils/** | Generic utility dumping grounds. | Extract logic, refactor under specific domain/feature or package. |
| ❌ **misc/ or temp/** | Temporary untracked script directories. | Prune directory; operational tools must sit in `/tools`. |
| ❌ **v2_final_final/** | Manual file-based versioning markers. | Delete; enforce Git branch tags and repository release commits. |
| ❌ **Duplicate Code** | Redundant implementations of sync/logic. | Consolidate logic under a shared package. |
| ❌ **Circular Imports** | Cyclic dependencies between directories. | Refactor code flow using dependency inversion (interfaces). |
| ❌ **Orphan Modules** | Dead code files without active consumers. | Prune files from the repository immediately. |
| ❌ **Unowned Folders** | Folders lacking active ARB ownership. | Map folder scope under the Directory Ownership Matrix. |

---

## 7. Repository Health Metrics Matrix

The SRE team and the CAB track and audit the following metrics quarterly to maintain monorepo health:

| Metric | Target KPI | Verification Mechanism |
| :--- | :--- | :--- |
| **Circular Dependencies** | **0** | `import-linter` scan runs |
| **Orphan Modules** | **0** | Static dead-code detection script audits |
| **Unowned Directories** | **0** | Folder matrix coverage audit validation |
| **Duplicate Code** | **< 5%** | SonarQube / code duplication checks |
| **Shared Package Violations** | **0** | CI/CD pipeline gate checks |
| **Boundary Violations** | **0** | Import structure linter analysis checks |
| **Documentation Freshness** | **< 180 days** | Documentation Governance Board audits |

---

## 8. Repository Bootstrap Standards
The repository MUST define the following configuration and build orchestration files to enforce standards locally:
* `melos.yaml`
* `Makefile`
* `.pre-commit-config.yaml`
* `.editorconfig`
* `.gitignore`
* `.github/workflows/`

Required commands:
* `make setup` — Bootstrap dependencies, Melos setups, and Doppler secret templates.
* `make lint` — Formatter and linter executions (TFLint, Ruff, Dart analyze).
* `make test` — Execute full unit and integration test runs.
* `make verify` — Perform security checks (tfsec, checkov, GitGuardian).
* `make architecture` — Run circular dependency and API boundary checks.

*Enterprise repositories optimize onboarding and verification from day one.*

---

## 9. Repository Readiness Gate (MANDATORY)
Before implementation begins:

□ Ownership assigned
□ Public APIs defined
□ Import rules enforced
□ Circular detection enabled
□ CODEOWNERS active
□ Documentation generated
□ Shared packages reviewed
□ CI pipelines green
□ No orphan modules
□ RRD records approved

If any item fails:
**IMPLEMENTATION CANNOT START**

---

## 10. Repository Decision Records (RRD)

All structural changes to the monorepo, packaging boundaries, or import rules must be recorded as RRDs inside `docs/rrd/`.
* **RRD-001:** Monorepo doctrine.
* **RRD-002:** Feature-first architecture.
* **RRD-003:** Shared package promotion rules.
* **RRD-004:** Dependency boundary enforcement.
* **RRD-005:** Repository ownership model.

---

## 11. Institutional Principle

> **Core Philosophy:**  
> Clean code repository structures yield clean systems. How we organize files dictates the modularity of our architecture. Reject clutter, enforce boundaries, and assign ownership.

**Build once. Evolve forever.**

🙏 श्री गणेशाय नमः
