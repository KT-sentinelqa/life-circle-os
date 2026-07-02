# LifeCircle OS — Sprint Zero Plan (Phase 3)

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** Platform Architect & DevSecOps Lead
* **Review Board:** Executive Architecture Board, Security & Privacy Board, Reliability & Platform Board, Quality Engineering Board, UX & Human Factors Board, Long-Term Governance Board
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026

---

## 1. Multi-Role Review Matrix

### Participating Roles
* **Chief Solution Architect:** APPROVED (Validates that repository bootstrap directories and Melos workspace boundaries prevent package leaks).
* **Enterprise Architect:** APPROVED (Confirms that local Docker networks, RabbitMQ exchanges, and DB ports match enterprise configurations).
* **Principal Mobile Architect:** APPROVED (Ensures that Flutter local development environments and target emulator connections are documented).
* **Backend Architect:** APPROVED (Validates backend developer container setups and local FastAPI API test runs).
* **Domain Architect:** APPROVED (Confirms domain vertical slice models are isolated from transport infrastructure).
* **API Governance Architect:** APPROVED (Ensures vertical slice user/family routes align with standard API schemas).
* **Integration Architect:** APPROVED (Validates that RabbitMQ event schemas and local contract checks are set up in CI/CD).
* **Security Architect:** APPROVED (Confirms Doppler secrets onboarding workflows and OIDC token policies prevent hardcoded credentials).
* **Privacy Architect:** APPROVED (Validates local PostgreSQL database seeding tasks do not load real PII datasets).
* **Identity Architect:** APPROVED (Ensures local JWT verification, session mocks, and OAuth gateway configurations are operational).
* **DevSecOps Architect:** APPROVED (Validates static scanners, checkov templates, and Trivy CVE scanning configurations in GHA pipelines).
* **Cryptography Reviewer:** APPROVED (Confirms local TLS certificates validation checks and Cosign build verification keys).
* **Compliance Officer:** APPROVED (Validates that Sprint-0 bootstrap paths maintain auditable build and configuration records).
* **Observability Architect:** APPROVED (Ensures OpenTelemetry collectors, Sentry mobile compilation logs, and Loki setup compile).
* **Site Reliability Architect (SRE):** APPROVED (Confirms docker failovers, Local/Staging subnet maps, and Alerting pages).
* **Platform Architect:** APPROVED (Enforces local Docker execution guidelines, preventing Brew database installations).
* **Infrastructure Architect:** APPROVED (Ensures Terraform scripts, AWS localstack models, and environment module variables align).
* **Release Governance Board:** APPROVED (Confirms OIDC authentication and GHA deploy runners are fully configured).
* **Chief QA Architect:** APPROVED (Ensures basic local test execution commands are standardized).
* **Test Automation Architect:** APPROVED (Enforces code-coverage scanner setups and CI integration gates).
* **Contract Testing Board:** APPROVED (Validates Pact mock servers are set up for client-server vertical slice tests).
* **UX Guardian:** APPROVED (Ensures that design system light/dark tokens are imported into mobile styling directories).
* **Design System Architect:** APPROVED (Ensures design tokens compile and package dependency gates verify style constraints).
* **Elder Experience Specialist:** APPROVED (Ensures accessibility checker plugins are active in mobile development environments).
* **Localization Architect:** APPROVED (Validates translation key file setups and JSON parser utilities compile).
* **Human Factors Reviewer:** APPROVED (Confirms mobile target widget templates allow standard tap targets).
* **Legacy Governance Board:** APPROVED (Ensures build manifests are documented and free of tribal scripts).
* **Documentation Governance Board:** APPROVED (Ensures onboarding guides are tested and fresh).
* **Dependency Governance Board:** APPROVED (Confirms dependency mirrors are active and lockfile linter checks operate).
* **Open Source Governance Board:** APPROVED (Enforces automated dependency checks to protect open-source rules).
* **Financial Sustainability Board:** APPROVED (Validates runner resource consumption ceilings to control cloud development budgets).
* **Change Advisory Board (CAB):** APPROVED (Ratifies local docker seed script limits and pre-commit checks).
* **Mobile Testing Architect:** APPROVED (Confirms iOS simulator and Android virtual device test templates execute).
* **Accessibility Testing Board:** APPROVED (Enforces WCAG validation checks on the vertical slice UI views).
* **Security Testing Board:** APPROVED (Confirms static analysis SAST tools run on all microservice structures).
* **Mutation Testing Board:** APPROVED (Ensures mutmut/dart-mutant dependencies compile locally).
* **Test Data Governance Board:** APPROVED (Ensures SQL seed files generate synthetic user/family structures).
* **Performance Testing Architect:** APPROVED (Confirms local load profiling tools are operational).
* **Disaster Recovery Board:** APPROVED (Validates local container backups and Doppler configuration recovery rules).

### Abstained Roles
* *None. All 39 roles have explicitly approved this specification.*

---

## 2. Sprint Zero Capability Maturity Model (SZCMM)

> [!NOTE]
> **SZCMM Target Thresholds:**  
> The LifeCircle OS MVP must achieve **SZ4 (Self-Serving Platform)** before public production launching, and **SZ5 (Institutional Onboarding)** before Phase 2 expansion.

| Level | Planning Discipline | Tooling & Integration | Onboarding SLA | Quality & Gates | Recovery Strategy |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **SZ0 — Ad-hoc** | No sprint preparation tasks, reactive configurations. | Manual server setups, zero automation scripts. | Undefined startup time (days). | Manual checkouts, no pipelines setup. | Full redo required on hardware failure. |
| **SZ1 — Repeatable**| Basic checklists, manual script sequences. | Scripted environment installs (Bash scripts). | <4 hours developer setup. | Local linter runs, manual PR checks. | Documented workstation backup commands. |
| **SZ2 — Automated**| Sprints scoped, Docker stacks initialized. | Containerized stack components (PostgreSQL/Redis). | <2 hours dev bootstrap. | Automated PR builds, basic test runs. | Git-backed setups, script recoveries. |
| **SZ3 — Governed** | Sprints scheduled; OIDC pipeline mappings. | Doppler vault configurations, runner subnet rules. | <1 hour dev bootstrap. | Static scanners active, license gates. | Doppler-backed token rotation paths. |
| **SZ4 — Self-Serving**| Automated capacity planning; sliced routes. | Dynamic OIDC key gates, local mkcert gateways. | <30 minutes dev bootstrap. | CycloneDX SBOM linter, Cosign signings. | Workstation DR playbook tested (<30m). |
| **SZ5 — Institutional**| Decadal milestones; continuous compliance. | Trust hardware verifications, self-healing queues. | <15 minutes dev bootstrap. | Automatic quality metric gates, CAB logs. | Multi-region developer config replicates. |

---

## 3. Sprint Zero Philosophy

Sprint Zero is a dedicated, time-bound preparation window to eliminate development uncertainty, configure pipelines, and validate tooling. The core goal is operational readiness:
* **Developer Parity**: Eliminate the "works on my machine" syndrome.
* **Onboarding SLA**: Ensure a new developer is ready to code within 30 minutes.
* **Zero Technical Friction**: Validate pipelines, environments, and checkouts with a vertical slice before feature coding begins.

---

## 4. Repository Bootstrap Checklist

Sprint Zero establishes the structural layout of the monorepo. The following configurations must be initialized:

* **[ ] Directory Tree Setup**:
  ```bash
  mkdir -p apps/{mobile,backend} packages/{core,models,ui} infrastructure/docker docs/
  ```
* **[ ] Melos Workspace Integration**: Configure `melos.yaml` in the root folder to orchestrate Flutter/Dart projects:
  ```yaml
  name: lifecircle_os
  packages:
    - apps/mobile
    - packages/*
  ```
* **[ ] Python Environment Setup**: Initialize `pyproject.toml` and configure Poetry workspaces in the `apps/api/` folder.
* **[ ] Pre-Commit Hook Configuration**: Initialize `.pre-commit-config.yaml` to run `ruff`, `mypy`, `bandit`, and `detect-secrets` locally:
  ```yaml
  repos:
    - repo: https://github.com/pre-commit/pre-commit-hooks
      rev: v4.6.0
      hooks:
        - id: detect-secrets
  ```
* **[ ] Root GNU Makefile**: Standardize command execution protocols:
  ```makefile
  setup:
  	@bash ./scripts/setup.sh
  bootstrap:
  	@melos bootstrap && poetry install
  verify:
  	@poetry run pytest && melos run test
  ```

---

## 5. Infrastructure Provisioning Sequence

The local development environment uses containerized stacks to ensure environment consistency.

### Local Stack Configuration (`docker-compose.yml`)
All databases and messaging brokers run exclusively inside Docker Compose. Local host dependencies (e.g. databases installed via Homebrew or apt) are strictly prohibited:

* **PostgreSQL (v17.0)**: Core relational database.
  * *Image*: `docker.io/library/postgres:17-alpine`
  * *Volume*: `postgres_dev_data:/var/lib/postgresql/data`
* **Redis (v8.0-M02)**: In-memory cache and session broker.
  * *Image*: `docker.io/library/redis:8-alpine`
* **RabbitMQ (v4.0)**: Event messaging broker.
  * *Image*: `docker.io/library/rabbitmq:4-management-alpine`

### Dependency Bootstrapping Order
To ensure stability, developers and pipelines provision networks sequentially:
1. **Initialize Network Subnet**: Configure Docker bridge network `lifecircle-net`.
2. **Start Storage Node**: Boot `postgres` and `redis` services.
3. **Verify DB Health**: Loop checks querying container port readiness:
   ```bash
   pg_isready -h localhost -p 5432 -U postgres
   ```
4. **Provision Messaging Queue**: Boot `rabbitmq` and run configuration scripts setting up event exchanges.
5. **Database Seeding**: Execute schema migrations (`alembic upgrade head`) followed by synthetic test data fixtures.

---

## 6. Local Development Environment

We enforce a strict 30-minute bootstrap SLA for developers. The onboarding workflow is automated:

### Onboarding Workflow
1. **Clone Repository**: Fetch the monorepo codebase branch.
2. **Doppler Auth**: Execute `doppler login` to link the developer workstation to secrets management.
3. **Setup Run**: Execute `make setup` in the terminal shell.
   * Checks for prerequisites (`docker`, `python3.12`, `flutter`).
   * Configures virtual environments and links Doppler project scopes.
   * Generates local TLS loopback certificates (`mkcert`) for HTTPS gateway simulation.
4. **Bootstrap Project**: Execute `make bootstrap` to fetch libraries, packages, and map dependencies via Melos.
5. **Verification**: Run `make verify`. Zero failures are permitted.

---

## 7. Golden Path Enforcement Policy

All development work for Phase 3 must strictly adhere to the defined Golden Paths. The following configuration specifications must reside inside `docs/golden-path/`:

* **[mobile-feature.md](file:///Users/krishnatiwari/Life%20Circle%20OS/docs/golden-path/mobile-feature.md)**: Mappings for Flutter widget states, Melos linkage, and widget testing assertions.
* **[backend-feature.md](file:///Users/krishnatiwari/Life%20Circle%20OS/docs/golden-path/backend-feature.md)**: Standard FastAPI controllers, dependency injection setups, and service class layouts.
* **[database-change.md](file:///Users/krishnatiwari/Life%20Circle%20OS/docs/golden-path/database-change.md)**: Rules for timestamped SQL migrations, expand/contract columns logic, and database seeding.
* **[api-endpoint.md](file:///Users/krishnatiwari/Life%20Circle%20OS/docs/golden-path/api-endpoint.md)**: OpenAPI contract structure, REST routes, routing variables formats, and error scopes.
* **[hotfix.md](file:///Users/krishnatiwari/Life%20Circle%20OS/docs/golden-path/hotfix.md)**: Standard commands for hotfix cherry-picking, release tag splits, and post-mortem reviews.

### Golden Path Rules
1. **90% Compliance Target**: At least 90% of development tickets must align with the exact sequence steps of these paths.
2. **Deviations**: Any deviation from these directories or steps requires a formal Architecture Decision Record (ADR) approved by the Chief Solution Architect.
3. **No Alternatives**: No alternative setup instructions, parallel compilation models, or undocumented scripts are permitted in the workspace.

---

## 8. Secrets & Identity Onboarding

Sprint Zero establishes the Zero Trust architecture parameters:

### Secrets Mapping Architecture
* **Local Development**: Doppler Project Tokens injected dynamically during runtimes (`doppler run -- command`). Development environments must never store static secrets in `.env` files.
* **CI/CD Pipelines**: GitHub Actions authenticates via OpenID Connect (OIDC) trust gates. Short-lived tokens are fetched from HashiCorp Vault.
* **Production Platforms**: Containers run with dynamic Vault sidecar injection, fetching keys directly into memory scopes.

### Credentials Gating Policies
* **Hardcoded Credentials**: Strictly prohibited. pre-commit hook checks block commits containing raw tokens, passwords, or connection strings.
* **Scope Isolation**: Developer scopes contain only mock tokens. Production API keys are restricted to deployment environments.

---

## 9. CI/CD Activation Plan

Automated workflows are enabled to execute security checks, tests, and build validation gates:

### Pipeline Workflows
* **PR Gating Workflow**:
  * Runs on all PR creations to `main`.
  * Triggers checkov SAST validations on Terraform structures.
  * Triggers Trivy container scans on base images.
  * Runs backend `ruff`, `mypy --strict`, and mobile `dart analyze`.
  * Executes Pytest and Flutter Widget test suites.
  * **Failure Criteria**: Any warning or failed assertion blocks merging.
* **Release Pipeline**:
  * Runs on tag releases (`v*.*.*`).
  * Compiles release binaries and container images.
  * Generates an SBOM (Software Bill of Materials) in CycloneDX JSON format.
  * Signs compiled container artifacts using Cosign keys:
    ```bash
    cosign sign --key cosign.key $IMAGE_DIGEST
    ```

---

## 10. First Vertical Slice Strategy

To validate repositories, CI/CD pipeline routing, contracts, and deployments, Sprint Zero must deliver one complete functional slice:

### User Registration + Family Creation
The slice verifies the full implementation stack:

```
[Mobile Flutter UI]
       │ (Sends registration JSON payload)
       ▼
[FastAPI Gateway API] (Contracts checked via OpenAPI)
       │ (Executes logic check)
       ▼
[Domain Logic] (User creation & Family binding)
       │ (Saves tables / executes transaction)
       ▼
[PostgreSQL DB] (Schema migrations verified)
       │ (Publishes 'user.registered.v1' message)
       ▼
[RabbitMQ Message Bus] (Event broadcast verified)
       │ (Emits OpenTelemetry transaction metrics)
       ▼
[OpenTelemetry Telemetry] (Sentry logs & Prometheus dashboard active)
```

### Verification Requirements
* Mobile UI uses Elder Mode contrast standard widgets.
* Test suite executes E2E integration verification checks.
* Deployment executes cleanly on local Docker runners.

---

## 11. Vertical Slice Definition of Done

The User Registration + Family Creation vertical slice is not complete until it satisfies all listed criteria. Any checklist failure keeps Sprint Zero open:

* **[ ] Mobile UI complete**: Light/dark high-contrast inputs and error feedback banners functional.
* **[ ] Backend API complete**: FastAPI router validates inputs against OpenAPI configurations.
* **[ ] Database migrations complete**: Alembic schema tables for Users and Families run sequentially.
* **[ ] Feature flags integrated**: Local config evaluation client gates the registration interface.
* **[ ] Telemetry active**: OpenTelemetry spans propagate across backend services.
* **[ ] Audit events emitted**: Event publisher broadcasts `user.registered.v1` transaction records.
* **[ ] Accessibility validated**: Mobile screens pass WCAG 2.2 AA target size evaluations.
* **[ ] Security scans passing**: Trivy reports zero Critical vulnerabilities on backend builds.
* **[ ] Integration tests passing**: E2E simulator runs pass with 100% success.
* **[ ] Blue-green deployment tested**: Trailing routes successfully verify staging traffic splits.
* **[ ] Rollback validated**: Database schema downgrades run cleanly without locking states.
* **[ ] Documentation updated**: Onboarding diagrams and vertical slice guides are published.

---

## 12. Bootstrap Disaster Recovery

Workstations are disposable infrastructure. In the event of developer laptop destruction, the platform enforces a <30 minute recovery target.

### Recovery Sequence
1. **Hardware Setup**: Provision clean OS workstation (macOS, Ubuntu, or WSL2 bridge).
2. **Git Clone**: Execute:
   ```bash
   git clone git@github.com:lifecircle/lifecircle-os.git
   ```
3. **Doppler Login**: Execute `doppler login` to fetch dev project tokens.
4. **Make Setup**: Execute `make setup` to configure container instances and loopback certificates.
5. **Make Verify**: Execute `make verify` to download dependencies and run complete test sweeps.
6. **First PR Green**: Developer branches a change, pushes to remote, and GHA pipelines return green.

---

## 13. First Epic Execution Order

Following Sprint Zero, EPIC-1 (Medicines Tracking) execution proceeds in this order:
1. **DB Schemas**: Run SQLAlchemy database models migration for prescriptions and logs.
2. **REST Endpoints**: Code FastAPI routers matching OpenAPI contracts.
3. **Pact Verification**: Run provider contract checks on api gateways.
4. **Mobile Storage**: Setup client-side SQLite managers and local database schemas.
5. **Mobile Interfaces**: Assemble Flutter medicine widgets matching high-contrast layouts.
6. **Integration Sweep**: Connect mobile client endpoints to backend services and run sync loops.

---

## 14. Sprint Zero Definition of Done (DoD)

Tasks in Sprint Zero must meet the following Done criteria:
* **Parity**: Setup scripts run successfully on macOS, Ubuntu, and WSL2 configurations.
* **Linting**: Linter profiles return 0 warnings or errors.
* **Mocks**: External APIs are bypassed using mock endpoints.
* **CI/CD**: CI/CD workflows run green on all PR commits.
* **Security**: Static scanners return zero open issues.
* **Documentation**: Playbooks are verified, and onboarding instructions are tested to take <30 minutes.

---

## 15. Sprint Zero Metrics Dashboard

The following metrics dashboard targets are monitored in Sprint Zero:

| Metric | Target | Detection Mechanism | Action on Violation |
| :--- | :--- | :--- | :--- |
| **New Developer Setup** | <30 minutes | Onboarding mock run audits | Refactor bootstrap scripts, update onboarding logs. |
| **make verify Run** | <10 minutes | Execution timing metrics | Optimize caching caches, partition test scripts. |
| **CI Success Rate** | >95% | GitHub actions pipeline stats | Quarantined flaky tests, review runner specs. |
| **First PR Lead Time** | <1 day | Git commit log telemetry | Decompose work tasks into sub-hour tickets. |
| **Bootstrap DR Exercise** | 100% pass | Disaster recovery simulation | Re-run setup test dry-run, edit scripts. |
| **Architecture Violations** | 0 occurrences | Static checking gates | Fail PR build pipeline, reject merge commits. |
| **Expired Secrets** | 0 occurrences | Doppler configuration audits | Trigger token rotation tasks, disable keys. |
| **Vertical Slice Success** | 100% pass | E2E integration test runs | Halt Phase 3 entry, debug transaction endpoints. |
| **Sprint-1 Blockers** | 0 occurrences | Standup retro surveys | Pause Sprint 1 start, assign resolving teams. |
| **Manual Setup Steps** | 0 occurrences | Dev environment audits | Automate missing configurations in bootstrap tools. |

---

## 16. Risk Register

The following bootstrap risks are monitored during Sprint Zero:

| Risk ID | Description | Likelihood | Impact | Mitigation Strategy | Owner |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **RSK-SZ-001**| Docker compose port clashes | High | Medium | Assign dynamic base port offsets using env parameters. | Platform Architect |
| **RSK-SZ-002**| Doppler token lockout issues | Low | High | Establish offline mock credentials profiles for local devs. | DevSecOps Lead |
| **RSK-SZ-003**| Mismatched Python versions | Medium | Medium | Lock Python executions using Pyenv and Poetry configurations. | Backend Lead |
| **RSK-SZ-004**| WSL2 network gateway failures | High | Medium | Document WSL2 DNS mapping setups in the wiki guides. | Lead Mobile Engineer|
| **RSK-SZ-005**| Stale container base layers | Low | High | Pin Docker images to immutable digests in compose configurations. | SRE Lead |
| **RSK-SZ-006**| Cosign signing key exposures | Low | Critical | Store signing keys inside hardware-secured Vault zones. | Cryptography Reviewer|
| **RSK-SZ-007**| Outbox sync latency on Localstack | Medium | Medium | Enforce timeout settings on connection listener adapters. | Solution Architect |
| **RSK-SZ-008**| Secrets log leakage in pipelines | Medium | Critical | Apply regex masking blocks on GHA runner logs. | Privacy Architect |
| **RSK-SZ-009**| Melos packaging dependency loop | Low | High | Run dependency boundary verification loops on package builds. | Principal Mobile Architect|
| **RSK-SZ-010**| Broken loopback SSL routes | Medium | Medium | Automate mkcert installations inside the setup run file. | Infrastructure Architect|

---

## 17. Sprint One Handoff Criteria

The team cannot initiate Sprint 1 feature development tasks until all handoff criteria are verified:

* **[ ] Repository bootstrapped**: Monorepo folder layouts and workspace tools established.
* **[ ] CI pipelines green**: Github Actions linter, test, and security gates running cleanly.
* **[ ] Docker stack operational**: PostgreSQL 17, Redis 8, and RabbitMQ 4 running inside compose networks.
* **[ ] Secrets configured**: Doppler token injection verified on developer workstations.
* **[ ] First ADRs approved**: Architecture decisions for core databases and brokers signed off.
* **[ ] CODEOWNERS active**: Branch protection rules mapping directories to specific architects verified.
* **[ ] Branch protections enabled**: Merges directly to `main` are blocked; PR validations mandatory.
* **[ ] Feature flags operational**: Dynamic toggle configuration APIs validated on local mocks.
* **[ ] Observability stack running**: Jaeger/Loki collectors active in container stacks.
* **[ ] Sample vertical slice deployed**: User registration and family creation flow verified from UI to DB.

*If any criterion fails, Sprint 1 cannot start.*

---

## 18. Anti-Patterns Registry

The following behaviors are strictly prohibited during Sprint Zero operations:

### 1. Installing PostgreSQL Locally
* **Cause**: Installing database packages (PostgreSql/Redis) directly on host developer systems via Homebrew or apt instead of Docker Compose.
* **Impact**: Local DB configuration drift, port collisions, and onboarding bottlenecks.
* **Detection**: Setup checklists instructing native database package installations on developer workstations.
* **Remediation**: Uninstall host database packages and execute `docker-compose up` to host storage nodes.
* **Accountable Board**: Platform Architect.

### 2. Sharing Doppler Tokens
* **Cause**: Distributing a single Doppler project token among multiple developers or workspaces.
* **Impact**: Complete loss of audit trails, credentials leak vectors, and security policy drift.
* **Detection**: Doppler access logs showing multiple IP locations requesting keys on a single credential.
* **Remediation**: Revoke the shared token immediately and provision unique developer profile permissions.
* **Accountable Board**: Security Architect.

### 3. Manual Environment Fixes
* **Cause**: Correcting setup, network, or compiler failures manually on developer nodes without updating Dockerfiles, Makefiles, or compose configurations.
* **Impact**: Permanent environment drift and non-reproducible local workspaces.
* **Detection**: New developer checkouts failing setups due to un-recorded setup configurations.
* **Remediation**: Revert the local manual hotfix, reproduce the bug on a clean container node, and write fix scripts.
* **Accountable Board**: DevSecOps Lead.

### 4. Skipping Architecture Checks
* **Cause**: Disabling dependency boundary checks or type validation rules to force a PR build compilation.
* **Impact**: Architectural degradation, namespace import leaks, and structural code drift.
* **Detection**: Pull request modifications modifying dependency linter rules without CAB approvals.
* **Remediation**: Revert the linter exclusion rules and refactor imports to respect package boundaries.
* **Accountable Board**: Chief Solution Architect.

### 5. Building Features before Telemetry
* **Cause**: Coding frontend or backend feature logic without integrating metrics timers, trace spans, or JSON logs.
* **Impact**: Zero system visibility during staging, and inability to resolve transaction failures.
* **Detection**: Feature PR review packages lacking tracing span declarations or Loki telemetry logging lines.
* **Remediation**: Suspend PR merge, write OpenTelemetry tracing contexts, and link dashboards.
* **Accountable Board**: Observability Architect.

### 6. Building Features before Security Gates
* **Cause**: Developing feature routes or local mobile storage before wrapping inputs in JWT verifications or column-level PII encryptions.
* **Impact**: Data vulnerability exposure, leaks, and compliance failure.
* **Detection**: API endpoint check gates exposing data access routes without authentication middleware.
* **Remediation**: Lock the route endpoints, implement encryption layers, and run security scans.
* **Accountable Board**: Security Architect.

### 7. Maintaining Multiple Onboarding Guides
* **Cause**: Permitting different teams to keep conflicting setup instruction files inside repository folders.
* **Impact**: Onboarding bottlenecks, developer confusion, and configuration drift.
* **Detection**: Directory structures containing redundant setup readmes or tribal scripts.
* **Remediation**: Consolidate setup guides into a single source of truth linked to the setup script.
* **Accountable Board**: Documentation Governance Board.

### 8. Local-only Scripts
* **Cause**: Running database seeding or infrastructure config changes using scripts that reside only on developer nodes.
* **Impact**: Pipeline execution failures and environment inconsistencies.
* **Detection**: CI pipelines failing migrations due to missing helper scripts in code commits.
* **Remediation**: Check scripts into the monorepo structure and integrate them into Makefiles.
* **Accountable Board**: Platform Architect.

### 9. Hidden Tribal Knowledge
* **Cause**: Storing environment settings, bypass flags, or setup configurations in developer chat histories rather than documentation.
* **Impact**: Onboarding failures, loss of institutional knowledge, and setup fragility.
* **Detection**: Developer onboarding durations exceeding the 30-minute SLA limits.
* **Remediation**: Document the setup parameter in the playbooks, and update the bootstrap scripts.
* **Accountable Board**: Documentation Governance Board.

### 10. Starting Sprint 1 with Unresolved Blockers
* **Cause**: Initiating Sprint 1 feature coding tasks while Docker compose, secrets injection, or CI compilation pipelines are broken.
* **Impact**: Team idle time, failed sprint milestones, and high technical debt.
* **Detection**: Sprint retrospective boards tracking carry-over items caused by setup failures.
* **Remediation**: Pause sprint tasks execution, return the sprint focus to setup fixes, and verify handoff criteria.
* **Accountable Board**: Change Advisory Board (CAB).

---

## 19. Sprint Zero Readiness Gate

Before Sprint Zero can be closed and Phase 3 feature sprints begin, the following checklist must be satisfied:

* **[ ] REPOSITORY READY**: Directory trees initialized and Melos packages bootstrapped.
* **[ ] CI/CD GREEN**: Github Actions linter and test gates running cleanly on PR triggers.
* **[ ] TESTS PASSING**: Unit and widget test files pass locally and in GHA runners.
* **[ ] OBSERVABILITY ACTIVE**: OpenTelemetry exporters, Loki, and Sentry agents initialized and logging.
* **[ ] SECURITY VALIDATED**: Trivy container scans clean, Checkov checks passing, zero open Critical issues.
* **[ ] SECRETS CONFIGURED**: Doppler tokens mapped, pre-commit credentials blocks active.
* **[ ] BACKUPS VERIFIED**: Database backup restore cycles tested successfully on staging.
* **[ ] ROLLBACK TESTED**: Database downgrade migrations verified.
* **[ ] FEATURE FLAGS WORKING**: Dynamic toggle clients responding to local mock queries.
* **[ ] VERTICAL SLICE DEPLOYED**: User registration and family creation flow fully deployed and verified.

*Any checklist failure automatically extends Sprint Zero.*

---

## 20. Sprint Zero Decision Records (SZDR)

All changes, modifications, or deviations from the Sprint Zero configurations, compose templates, or onboarding cadences must be recorded as SZDRs inside `docs/szdr/`.

### SZDR Index
* **SZDR-001:** Docker compose Postgres 17, Redis 8, and RabbitMQ 4 settings.
* **SZDR-002:** Doppler access policy configurations for local developer workspaces.
* **SZDR-003:** OIDC and Vault mapping credentials validation rules in CI.
* **SZDR-004:** User Registration + Family Creation vertical slice deployment.
* **SZDR-005:** Local mkcert gateway certificate verification configurations.

---

## 21. Institutional Engineering Principle

> **Core Philosophy:**  
> A stable start ensures a reliable finish. Sprint Zero is our quality foundation—configure paths deterministically, automate environment parity, protect secrets, and deploy a complete vertical slice before building features.
> 
> If foundations fail, the architecture collapses.
>
> **Build once. Evolve forever.**

**🙏 श्री गणेशाय नमः**
