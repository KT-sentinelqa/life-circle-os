# LifeCircle OS — Developer Workflow Specification

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** Quality Engineering Board & Principal Architects
* **Review Board:** Executive Architecture Board, Mobile Architecture Board, Backend Architecture Board, Security & Privacy Board, Reliability & Operations Board, Quality Engineering Board, Governance Board, Documentation Board, Change Advisory Board (CAB)
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026

---

## Multi-Role Review Status

### Participating Roles
* **Chief Solution Architect:** APPROVED (Validates local workspaces isolate features bounded context domains).
* **Enterprise Architect:** APPROVED (Confirms DDR-DEV records and onboarding templates preserve knowledge transfer across cycles).
* **Principal Mobile Architect:** APPROVED (Validates Melos bootstrap runs and golden tests checkouts for local Flutter dev).
* **Backend Architect:** APPROVED (Ensures local virtual environments and Docker compose services match backend needs).
* **Domain Architect:** APPROVED (Confirms that AI-assisted workflows prohibit inner domain framework leakage).
* **API Governance Architect:** APPROVED (Enforces that local test seed files conform to contract schema rules).
* **Integration Architect:** APPROVED (Ensures local messaging mocks support event publish/subscribe workflows).
* **Security Architect:** APPROVED (Confirms git secret checking, GitGuardian scanners, and bandit hook checks are active locally).
* **Privacy Architect:** APPROVED (Ensures that PII is anonymized in local development seed databases).
* **Identity Architect:** APPROVED (Enforces local auth mock configurations and JWT testing guidelines).
* **DevSecOps Architect:** APPROVED (Validates pre-commit pipelines check build boundaries before pushes).
* **Cryptography Reviewer:** APPROVED (Ensures local key generation scripts do not commit keys to Git).
* **Compliance Officer:** APPROVED (Validates compliance audit logs tracking during emergency hotfix operations).
* **Observability Architect:** APPROVED (Enforces local logging configurations to check Correlation-IDs during debugging).
* **Site Reliability Architect (SRE):** APPROVED (Validates incident hotfix workflows, ensuring post-mortems run).
* **Platform Architect:** APPROVED (Confirms Docker setups match platform caching and query routing targets).
* **Infrastructure Architect:** APPROVED (Ensures local Terraform state runs are isolated and blocked in Git).
* **Release Governance Board:** APPROVED (Validates PR branch naming, conventional commits, and merge criteria).
* **Chief QA Architect:** APPROVED (Confirms local testing runs verify styling and logic standards).
* **Test Automation Architect:** APPROVED (Ensures pre-commit rules verify unit and widget test pass checks).
* **Contract Testing Board:** APPROVED (Enforces that contract pact verification hooks run locally).
* **UX Guardian:** APPROVED (Validates that local golden widgets testing preserves visual specifications).
* **Localization Architect:** APPROVED (Enforces localization compiler runs check missing language tags in IDE).
* **Legacy Governance Board:** APPROVED (Enforces verbose comments and rejects tribal shortcuts in developer tools).
* **Documentation Governance Board:** APPROVED (Ensures developer onboarding checklist remains current and readable).
* **Change Advisory Board (CAB):** APPROVED (Validates emergency hotfix loops and branch promotion rules).
* **Mobile Testing Architect:** APPROVED (Confirms mobile simulator widget testing steps are documented).
* **Accessibility Testing Board:** APPROVED (Ensures local layout screen readers tools are integrated into onboarding).
* **Security Testing Board:** APPROVED (Validates local checkov and GitGuardian pre-commit checks).
* **Mutation Testing Board:** APPROVED (Ensures logic verification steps run local mutations checks on domain code).
* **Test Data Governance Board:** APPROVED (Validates that developer databases seed from anonymized schemas).
* **Design System Architect:** APPROVED (Confirms that local component adjustments pull token assets from the packages directory).
* **Elder Experience Specialist:** APPROVED (Ensures simulation tools for elderly vision adapt within local setups).
* **Human Factors Reviewer:** APPROVED (Validates touch target verification steps during review reviews).
* **Dependency Governance Board:** APPROVED (Confirms that pre-commit dependency scans check vulnerability registries).
* **Open Source Governance Board:** APPROVED (Ensures local tools block import of unapproved licensed modules).
* **Financial Sustainability Board:** APPROVED (Validates local Docker resource footprints are optimized to avoid heavy battery drainage).
* **Founder Office:** APPROVED (Validates that pair-programming and developer knowledge handoff support multi-decade stewardship).

### Abstained Roles
* **Disaster Recovery Board:** ABSTAINED. Reason: Local dev environment workflows do not directly configure site disaster failovers or backup replications.

---

## 1. Local Environment Bootstrap

Developers must configure their local machines using standard, reproducible steps to ensure alignment with the CI environment:

### Step 1: Secrets & Configuration Management
We use **Doppler** to manage secrets without storing plaintext credentials in the repository:
1. Install the Doppler CLI:
   ```bash
   brew install dopplerhq/cli/doppler
   ```
2. Log in and configure your environment scopes:
   ```bash
   doppler login
   ```
3. Set up the local Doppler template config, downloading development environment configurations to local configuration templates (e.g. `.env.local` templates).

### Step 2: Monorepo Orchestration with Melos
We use **Melos** to manage multi-package Dart and Flutter workspaces:
1. Bootstrap Dart dependencies and link cross-package imports:
   ```bash
   make setup
   ```
   *(This calls `melos bootstrap` internally, creating local package links and resolving versions).*

### Step 3: Python Virtual Environment
1. Initialize the backend workspace virtual environment:
   ```bash
   python -m venv .venv
   source .venv/bin/activate
   pip install --upgrade pip
   pip install -r backend/requirements-dev.txt
   ```

### Step 4: Local Container Dependencies
We orchestrate database and cache dependencies using Docker Compose:
1. Start local PostgreSQL and Redis instances:
   ```bash
   docker-compose -f tools/docker-compose.dev.yml up -d
   ```
2. Verify connections and seed the development databases with anonymized data:
   ```bash
   python scripts/seed_development_db.py
   ```

## 2. Developer Environment Compatibility Matrix

To guarantee local execution fidelity and avoid local environment drifting, development must adhere to the supported tooling baseline. Unsupported environments carry zero production support obligations.

| Environment | Supported | Minimum Standard / Locked Version |
| :--- | :--- | :--- |
| **macOS** | Yes | Latest major release version (N-2) |
| **Ubuntu LTS** | Yes | Version 24.04 LTS minimum |
| **Windows** | Yes (WSL2 only) | WSL2 Linux Subsystem is required |
| **Python** | Yes | Version 3.12 static check baseline |
| **Flutter** | Yes | Locked SDK version defined in pubspec.yaml |
| **Docker** | Yes | Latest stable Compose engine |
| **Node.js** | Yes | LTS (Long Term Support) version |

---

## 3. AI Pair Programming Governance

To leverage automated LLM code assistance without eroding code boundaries, the following rules are enforced:

### Mandatory Principles
* **Code Custody:** AI systems may generate lines or functional blocks of code, but humans own architecture, security profiles, core business logic, production incidents, and final merge approvals.
* **Strict Integration Boundaries:** AI-generated modifications must obey the feature-first directory layout and prevent leakage.

### Generation Requirements
Every AI-generated block of code must:
* **Pass all boundaries:** No outer dependency leakages or incorrect layer imports.
* **Preserve comments:** Never strip existing comments or metadata lines.
* **Preserve ADR references:** Keep architectural decisions references intact.
* **Preserve ownership:** CODEOWNERS matrix mapping rules must remain valid.
* **Preserve tests:** Retain all unit, golden, and integration test coverage.
* **Preserve accessibility requirements:** Respect WCAG 2.2 AA and target touch dimensions.

### Banned Practices
* ✗ **Blind Acceptance:** Committing code blocks without full manual review.
* ✗ **Undocumented Generation:** Adding code without explaining domain logic or context.
* ✗ **Dependency Additions:** Importing third-party dependencies without CAB approval.
* ✗ **Direct Incident Generation:** Allowing AI models to draft production hotfixes directly without manual execution.

---

---

## 4. Pre-Commit Enforcement

Before code is pushed to remote repositories, static quality checks must pass locally via **pre-commit** hooks:

### Required Hook Configurations
The `.pre-commit-config.yaml` file enforces validation sweeps on every local commit attempt:
* **Python checks:**
  * `ruff check --fix` (formatting, linting, import sorting).
  * `mypy --strict` (static type checks).
  * `bandit` (static security checking).
* **Dart/Flutter checks:**
  * `dart format` (re-spaces and formats mobile files).
  * `dart analyze --fatal-warnings` (ensures zero warnings pass).
* **Repository checks:**
  * `detect-secrets` (blocks committing credentials or api tokens).
  * `check-yaml` / `check-json` (ensures configuration syntax purity).

*Pre-commit checks are mandatory. Bypassing hooks using `--no-verify` is a governance violation.*

---

## 5. Developer Capability Maturity Model (DCMM)

To ensure clear progression and accountability, developers are mapped to maturity levels. Seniority is earned through stewardship, not tenure.

| Level | Role | Expected Competencies | Approval Permissions | Mentoring & Succession |
| :--- | :--- | :--- | :--- | :--- |
| **D0** | **Onboarding** | Completing local bootstrap, learning bounded contexts | No independent approvals | Pair-reviews, learning setups |
| **D1** | **Contributor** | Writing modular code, implementing unit tests | Local feature branches only | Active reviews of own patches |
| **D2** | **Domain Owner** | Complete expertise over a single bounded context (e.g. Medicines) | CODEOWNER for owned features | Mentors D1s, documents context |
| **D3** | **Architect** | Multi-system design, cross-domain routing, clean architecture | Full directory approvals | Guides D2s, owns ADR creations |
| **D4** | **Steward** | Deep repository lifecycle governance, SRE integration | Branch protections overrides | Prepares successors for all docs |
| **D5** | **Guardian** | Fiduciary stewardship, constitutional protection | Final locking approvals | Multi-generational succession |

---

## 6. Pair-Review & Ownership Policies

* **Two-Architect Review Rule:** Every code change requires review and approval by at least one architect owning the directory in the CODEOWNERS matrix.
* **Review Boundary Rule:** Reviewers **SHALL NOT** approve changes in features or components outside their mapped discipline (e.g., a Mobile Architect cannot approve a Database ORM model change).
* **Self-Approvals Banned:** Self-merges or self-approvals of pull requests are blocked on all branches (`main`, `release/*`, `governance/*`).
* **Collaborative Programming:** Pair programming is recommended for complex domain features, ensuring that knowledge is distributed and tribal ownership is avoided.

---

## 7. Pull Request Lifecycle Governance

To maintain system quality and documentation audit history, pull requests must progress through explicit stages:

### Step 1: Branch Naming Standards
Branches must adopt standard patterns:
* `feature/<domain-context>/<feature-name>` (e.g., `feature/medicines/dosage-alert`)
* `bugfix/<domain-context>/<bug-name>` (e.g., `bugfix/identity/token-refresh`)
* `hotfix/<domain-context>/<incident-id>` (e.g., `hotfix/finance/leakage-patch`)

### Step 2: Conventional Commits
All commits must follow the conventional commit format:
```
<type>(<scope>): <short summary>
```
* **Types:** `feat` (new capability), `fix` (bug fix), `docs` (docs update), `style` (formatting), `refactor` (code cleanups), `test` (test updates), `chore` (build setups).
* **Scope:** The bounded feature context (e.g., `medicines`, `auth`, `billing`).

### Step 3: CI/CD Status Enforcement
Every pull request triggers the CI quality gate, running all static linters, security audits, and testing suites. PRs **SHALL NOT** merge unless all checks are green.

---

## 8. Incident Hotfix Workflows

When production outages or security vulnerabilities occur, emergency hotfixes proceed under strict bounds:

```
Production Outage / TD-4 Security Vulnerability
↓
Branch from target release tag: hotfix/<domain>/<incident-id>
↓
Develop fix & enforce automated test sweeps
↓
Create PR with emergency tag (Fast-track Review)
↓
Dual CODEOWNER Sign-off (DevSecOps + Lead Architect)
↓
Merge & deploy (Blue-Green Rollout)
↓
Post-Incident Retrospective Review & CDR/DDR Logging
```

### Hotfix Rules
* **No Manual Production Deployments:** Emergency fixes must flow through the automated pipeline.
* **Retrospective Mandatory:** Within 48 hours of deploying a hotfix, the incident command team must host a retrospective, documenting the root cause and checking in a new Developer Decision Record (DDR-DEV) logging the incident decisions.

---

## 9. Developer Onboarding Checklist

New engineers joining the team must complete the sequential 10-step onboarding checklist to achieve a functional local workspace:

1. [ ] **Access provisioning:** Set up account permissions (Git, Doppler, Slack, Jira).
2. [ ] **Repository clone:** Clone the monorepo locally.
3. [ ] **Secrets integration:** Install Doppler, log in, and download configuration templates.
4. [ ] **Docker installation:** Start local Postgres and Redis database compositions.
5. [ ] **Melos initialization:** Run `make setup` to bootstrap mobile packages and configurations.
6. [ ] **Python virtual environment:** Build Python 3.12 `.venv` and install developer tools.
7. [ ] **Linter testing:** Execute `make lint` locally to check formatters and static analyses.
8. [ ] **Logic verification:** Run `make test` to verify local backend and mobile tests pass.
9. [ ] **Security checking:** Execute `make verify` to ensure local static security tools run green.
10. [ ] **First PR checkout:** Draft a mock patch (e.g. updating onboarding team docs), push branch, and verify CI pipeline passes green.

---

## 10. Knowledge-Transfer & Stewardship Requirements

To survive developer turnover and founder absence across decades, knowledge must be preserved inside the repository:

* **No Unrecorded Architectural Decisions:** Every structural modification, linter rule change, or third-party package addition must be documented via an ADR, RRD, or CDR before implementation.
* **Handoff Documentation:** Developers leaving a feature team must write a handoff markdown summary under `docs/handoffs/` detailing domain states, active integrations, and planned refactoring tasks.
* **Continuity Checks:** During sprint reviews, the Documentation Governance Board verifies that newly merged code is accompanied by updated specs and inline documentation.

### Knowledge Stewardship Matrix
Knowledge without successors is institutional debt. The required ownership matrix maps:

| Artifact | Primary Steward | Secondary Steward | Successor / Role |
| :--- | :--- | :--- | :--- |
| **ADRs** | Solution Architect | Enterprise Architect | Steward |
| **Runbooks** | SRE | Operations Board | Successor |
| **Features** | Domain Architect | QA Board | Successor |
| **Security** | Security Architect | DevSecOps | Successor |

---

## 11. Workflow Anti-Patterns Registry
The following anti-patterns are prohibited in this repository:

| Anti-Pattern | Cause | Impact | Detection | Remediation | Owner |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Cowboy Commits** | Rushing features | Untracked repository state | Unverified PR history | Enforce commit linting gates | DevSecOps |
| **Direct Push to Main** | Skipping review | Production regression risks | Commit log sweeps | Enable branch locks | DevSecOps |
| **Unreviewed AI Code** | Blind trust in LLM | Structural boundary decays | Static code diff checks | Reject undocumented AI PRs | Domain Architect |
| **Undocumented Hotfix** | Emergency rush | Untracked change logs | Out-of-sync builds | Run retrospective & write DDR-DEV | SRE |
| **Permanent Emergency** | Neglecting rollback | Fragmented release lines | Active hotfix branch lists | Set hard expiry on hotfixes | Release Board |
| **Knowledge Hoarding** | Tribal custom code | Bottlenecks & silos | Handoff spec audits | Run pair-programming sprints | Docs Board |
| **Skipped Onboarding** | Quick-start bypass | Bootstrap environment drift | Broken local runs | Fail bootstrap verify sweeps | Quality Board |
| **Shadow Ownership** | Implicit custody | Missing stewards | CODEOWNERS scan | Map directories explicitly | Governance Board |
| **Manual Secrets** | Local copy-paste | Credentials exposure risks | Hardcoded files | Install Doppler templates | Security Architect |
| **Verbal-Only Approval**| Informal handoffs | Lack of audit history | Git merge sweep | Enforce CODEOWNERS approvals | CAB |

---

## 12. Developer Experience (DX) Metrics Dashboard
To monitor workflow efficiency, the Quality Engineering Board tracks:

| Metric | Target KPI | Verification Mechanism |
| :--- | :--- | :--- |
| **Bootstrap Time** | `<30 minutes` | Onboarding duration metrics |
| **First Green PR** | `<1 day` | Clone-to-merge metrics |
| **Review Time** | `<24 hours` | Pull Request open duration |
| **CI Success Rate** | `>95%` | Automated build reports |
| **Onboarding Completion** | `100%` | Signed onboarding documents |
| **Documentation Freshness**| `<180 days` | Docs Governance audits |
| **Handoff Completion** | `100%` | Archiving of handoff markdown summaries |
| **Hotfix Audit Completion**| `100%` | Closed retrospective reviews |

---

## 13. Workflow Lock Readiness Gate
Before active coding begins, all workflow elements must be verified:

□ Bootstrap scripts validated
□ Pre-commit hooks installed
□ CODEOWNERS active
□ Branch protections enabled
□ Hotfix procedures tested
□ Onboarding completed
□ AI usage policies accepted
□ Documentation ownership assigned
□ Knowledge transfer plans approved
□ DX metrics dashboards active

*Rule: If developers cannot onboard safely, development cannot begin.*

---

## 14. Developer Decision Records (DDR-DEV)

Developer workflow conventions, IDE configurations, or local tooling adjustments must be recorded as DDR-DEVs inside `docs/ddr-dev/`.

### DDR-DEV Index
* **DDR-DEV-001:** Local workspace bootstrap orchestration via Melos and Doppler.
* **DDR-DEV-002:** Pre-commit linting and security checking hook rules.
* **DDR-DEV-003:** Branch protections and PR review governance bounds.
* **DDR-DEV-004:** Emergency hotfix procedures.
* **DDR-DEV-005:** Developer onboarding sequence checklist.

---

## 15. Institutional Engineering Principle

> **Core Philosophy:**  
> A structured developer workflow ensures reproducible systems. How we write commits, review patches, and onboard teammates directly dictates the lifespan of our architecture. Respect the boundaries, run checks locally, and preserve knowledge.
>
> **Build once. Evolve forever.**

**🙏 श्री गणेशाय नमः**

