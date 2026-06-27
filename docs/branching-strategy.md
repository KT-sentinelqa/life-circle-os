# LifeCircle OS — Branching Strategy Specification

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
* **Chief Solution Architect:** APPROVED (Confirms branching strategy maintains context isolations and stable trunk integration).
* **Enterprise Architect:** APPROVED (Ensures release cadences and cherry-pick rules sustain long-term compatibility).
* **Principal Mobile Architect:** APPROVED (Validates Flutter client release tagging, hotfix branching, and App Store submit flows).
* **Backend Architect:** APPROVED (Validates backend service staging branches, versioning rules, and database migrations alignment).
* **Domain Architect:** APPROVED (Enforces that domain code remains untethered to custom deployment feature branches).
* **API Governance Architect:** APPROVED (Ensures semantic versioning rules reflect public package interface breaks).
* **Integration Architect:** APPROVED (Validates that backport patches do not disrupt shared Kafka/RabbitMQ schema formats).
* **Security Architect:** APPROVED (Confirms secure hotfix review protocols and branch permission restrictions).
* **Privacy Architect:** APPROVED (Ensures compliance tagging sweeps verify database schema rollbacks do not leak PII).
* **Identity Architect:** APPROVED (Ensures IAM permissions are aligned with protected branches ownership constraints).
* **DevSecOps Architect:** APPROVED (Validates merge queue checks, pull request automation scripts, and build boundaries in CI).
* **Cryptography Reviewer:** APPROVED (Confirms cryptographic module updates follow strict release train code review gates).
* **Compliance Officer:** APPROVED (Validates release auditing and SemVer transition trails for compliance audits).
* **Observability Architect:** APPROVED (Enforces that version markers and release tags are injected into telemetry headers).
* **Site Reliability Architect (SRE):** APPROVED (Validates emergency hotfixes fast-tracks and post-incident retro gates).
* **Platform Architect:** APPROVED (Validates that staging containers and environment caches map to release branches).
* **Infrastructure Architect:** APPROVED (Enforces that Terraform infra updates are version-aligned with application releases).
* **Release Governance Board:** APPROVED (Confirms protected branch structures, merge queues, and cherry-pick overrides rules).
* **Chief QA Architect:** APPROVED (Enforces regression verification checks on release branch candidates).
* **Test Automation Architect:** APPROVED (Validates that integration tests suites execute on merge queue pipelines).
* **Contract Testing Board:** APPROVED (Ensures contract verification suites pass before release train pushes).
* **UX Guardian:** APPROVED (Validates golden UI tests runs on release branches to block layout regressions).
* **Localization Architect:** APPROVED (Enforces localized dictionary checks before release branch locking).
* **Legacy Governance Board:** APPROVED (Rejects complex or non-standard branch conventions, enforcing simplicity).
* **Documentation Governance Board:** APPROVED (Ensures BDR logs remain synced with repository branching modifications).
* **Change Advisory Board (CAB):** APPROVED (Validates release train promotions, merge gates, and emergency overrides).
* **Mobile Testing Architect:** APPROVED (Confirms simulator and visual regressions test runs on release candidates).
* **Accessibility Testing Board:** APPROVED (Enforces accessibility check passes on release branches).
* **Security Testing Board:** APPROVED (Confirms DAST and container scanning gates execute on release candidates).
* **Mutation Testing Board:** APPROVED (Ensures mutation sweeps protect domain layers on merge queues).
* **Test Data Governance Board:** APPROVED (Validates that staging test data sets remain anonymized and sanitized).
* **Design System Architect:** APPROVED (Confirms design tokens releases are versioned via SemVer rules).
* **Elder Experience Specialist:** APPROVED (Ensures accessibility features are verified on release branches).
* **Human Factors Reviewer:** APPROVED (Validates touch ergonomics checks on mobile release packages).
* **Dependency Governance Board:** APPROVED (Enforces that dependency upgrades align with release cadence versions).
* **Open Source Governance Board:** APPROVED (Ensures licensed packages compliance check before main branch merges).
* **Financial Sustainability Board:** APPROVED (Validates that merge queue builds are resource-optimized to reduce run costs).
* **Founder Office:** APPROVED (Validates that branching strategy, versioning, and release cadences align with multi-decade platform durability).

### Abstained Roles
* **Disaster Recovery Board:** ABSTAINED. Reason: Branching workflows govern source code integration, not database site failovers or cloud backup restores.

---

## 1. Branching Doctrine

LifeCircle OS enforces **Trunk-Based Development** to avoid long-lived code drift, merge conflicts, and integration delays:

* **Single Source of Truth:** The `main` branch represents the stable trunk. All new development proceeds in short-lived feature or bugfix branches created from `main`.
* **Short Lifespan:** Feature branches **SHALL NOT** exist for more than 5 working days. If a feature requires more time, it must be decomposed into smaller, mergeable sub-tasks or integrated via runtime feature flags.
* **Direct Commits Banned:** No developer may commit code directly to `main`, `release/*`, or `governance/*`. All integration must flow through pull requests.

### Feature Flag Governance Integration
Trunk-based development works best when incomplete work is hidden behind feature flags rather than long-lived branches.

#### Feature Flag Rules
* **Short-Lived Feature Branches:** Long-lived feature branches are strictly prohibited. Feature flags are preferred over isolation branches.
* **Stewardship:** Every feature flag must have a designated owner role and a defined sunset date.
* **Sunsetting:** Flags older than 180 days become governance defects and automatically block release pipelines. Removal tasks are mandatory for all feature integrations.

#### Feature Flag Metadata Registry
All feature flags must define the following metadata parameters:
```yaml
flag_name: <unique_flag_identifier>
owner: <ARB_owner_role>
created_at: <YYYY-MM-DD>
expires_at: <YYYY-MM-DD>
rollback_plan: <automated_rollback_procedure>
pdr_reference: <PDR-XXX_decision_reference>
```

---

## 2. Branch Capability Maturity Model (BCMM)

Branching maturity is measured by release confidence, not by branch count. The repository evolution maps to the following maturity levels:

| Level | Maturity State | Prerequisites | Required Tooling | Approval Authority | Audit Requirements | Successor / Role |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **B0** | Ad-hoc | None | Basic Git commands | Developer self-merges | None | Contributor |
| **B1** | Controlled Branching | Enforced naming standards | CLI Linters, branch naming hooks | Domain Architect | Pull request template checks | Domain Owner |
| **B2** | Protected Main | Strict branch protections | GitHub Protected branch configurations | CODEOWNERS | Review log validations | Domain Owner |
| **B3** | Automated Releases | Continuous Integration green tests | GitHub Actions, Melos, pytest | Release Governance Board | Continuous test logs audit | Steward |
| **B4** | Policy-Driven Governance | Enforced SemVer versioning and merge queues | Merge queue engines (e.g. GitHub merge queue) | Change Advisory Board (CAB) | Quarterly merge queue audits | Steward |
| **B5** | Institutional Stewardship | Zero-trust deployments, full traceability | GitGuardian, tfsec, checkov checks | Executive Architecture Board | Annual G4 compliance reviews | Guardian |

---

## 3. Protected Branch Hierarchy

Protected branches enforce mandatory quality gates and block unreviewed adjustments.

### Release Compatibility Matrix
To govern code integration paths, the following compatibility matrix is enforced. Any path deviation triggers build failures:

| Source Branch | Target Branch | Allowed | Requirements / Gates |
| :--- | :--- | :--- | :--- |
| `feature/*` | `main` | Yes | Green CI + 2 CODEOWNER approvals |
| `hotfix/*` | `release/*` | Yes | DevSecOps Architect + SRE approval |
| `hotfix/*` | `main` | Yes | Back-merge is mandatory after release promotion |
| `release/*` | `main` | No | Protected |
| `governance/*` | `main` | Restricted | Founder Office + CAB approval |

#### Prohibited Integration Patterns
* **No release -> release merges:** Cross-release merges are strictly banned.
* **No feature -> feature merges:** Peer-level feature branch integration is prohibited.
* **No governance bypasses:** Policy documents changes must follow standard ratification reviews.
* **No manual cherry-picks without -x:** All cherry-picks must track their parent commits via `-x`.

### Branch Protections Rules
* **Mandatory Reviews:** Minimum of 1 CODEOWNER approval. Self-approvals are blocked.
* **Status Checks:** Passing CI/CD pipelines (unit/widget/integration tests, linters, security audits, dependency boundaries checks) is required.
* **No Force Pushes:** Force pushing (`git push --force`) or deleting protected branches is strictly blocked for all roles.

---

## 4. Hotfix Branching & Lifecycle

When critical production defects (TD-4) occur on locked release branches, emergency patches proceed under strict workflows:

1. **Branching Point:** Branch directly from the target production release tag:
   ```
   hotfix/<domain-context>/<incident-id>
   ```
2. **Local Fix:** Implement the minimal required changes to resolve the defect. *Bypassing styling, linting, or local unit tests is forbidden.*
3. **Emergency Pull Request:** Create a pull request targeting the active `release/*` branch.
4. **Dual Sign-Off:** Merging requires explicit approval from the DevSecOps Architect and the Backend/Mobile Architect owning the domain.
5. **Backporting:** Once merged to the release branch, the hotfix **MUST** be backported to `main` via cherry-pick or merge queue integration to prevent regression.

---

## 5. Semantic Versioning Governance

We adhere strictly to Semantic Versioning (SemVer 2.0.0) to communicate compatibility guarantees:

```
Version Format: MAJOR.MINOR.PATCH
```

* **MAJOR (X.0.0):** Incremented for backward-incompatible changes:
  * Breaking changes to public package APIs (`packages/`).
  * Non-backward-compatible database schema migrations.
  * Breaking adjustments to shared contract schemas (`packages/shared-contracts`).
* **MINOR (0.X.0):** Incremented for backward-compatible additions:
  * Adding new features, router endpoints, or UI screens.
  * Database schema expansions containing safe default drop-in columns.
  * Non-breaking utility additions to shared packages.
* **PATCH (0.0.X):** Incremented for backward-compatible bug fixes:
  * Incident hotfixes and production patches.
  * Secure coding logic adjustments.
  * Telemetry updates and minor package dependency security patches.

---

## 6. Release Train Cadence

To maintain operational stability, we operate a weekly **Release Train** cadence:

* **Weekly Cadence:** The release train leaves the trunk every Friday at 10:00 UTC.
* **Release Branch Creation:** The Release Governance Board creates a new branch `release/vX.Y.0` from `main`.
* **Stabilization Window:** The release branch enters a 24-hour stabilization phase. Only critical bug fixes (no new features) may be cherry-picked onto the release branch.
* **Regression Testing:** Automated integration and widget golden tests execute on the release branch.
* **Release Tagging:** Once validated, the branch is tagged `vX.Y.0` and deployed. Staging configurations are promoted to production.

---

## 7. Merge Queue Policies

To avoid the "broken trunk" problem where concurrent merges cause compilation errors on `main`, we enforce an automated **Merge Queue**:

### Merge Queue Governance Matrix
The merge queue protects institutional stability, not developer convenience. The queue actions are defined by the following matrix:

| Condition | Action / Enforcement Rule |
| :--- | :--- |
| **CI failure** | Evict the offending branch immediately |
| **Dependency drift** | Rebase against the updated main branch |
| **Security finding** | Block merge and notify DevSecOps |
| **Contract failure** | Reject the branch and notify API Governance |
| **Performance regression**| Escalate to Performance Testing Board |
| **Architecture violation**| Block merge and escalate to CAB review |

*Rule: SRE emergency command overrides are permitted only during verified critical outages (TD-4).*

---

## 8. Cherry-Pick & Backport Lifecycle

To maintain sync between `main` and active production release branches:

* **Target Verification:** A bug fix must be merged to `main` first before it can be backported to a `release/*` branch.
* **Cherry-Pick Flow:**
  ```bash
  git checkout release/vX.Y.Z
  git cherry-pick -x <commit-hash-from-main>
  ```
  *(The `-x` flag is mandatory to preserve reference tracking to the original trunk commit).*
* **CI Validation on Release:** The cherry-picked branch must pass the full release pipeline sweep before the release tag is updated.

---

## 9. Branch Lifecycle & Retention Policies

To prevent repository clutter, reduce search index times, and keep integration loops short:

### Branch Maximum Lifetime Limits
Feature branches must be short-lived to succeed in trunk-based workflows. The following maximum lifespans are enforced:

| Branch Type | Maximum Lifetime | Cleanup Action |
| :--- | :--- | :--- |
| `feature/*` | **3–5 days** | Automatic deletion upon successful merge |
| `bugfix/*` | **2 days** | Automatic deletion upon successful merge |
| `hotfix/*` | **24 hours** | Pruned immediately after release tag update and back-merge |
| `release/*` | **14 days** | Archived (marked read-only) post-deployment |
| `governance/*`| **Until ratified** | Cleaned up after spec ratification |

*Enforcement: Automated branch retention scripts run nightly to delete branches exceeding their maximum lifetime.*

---

## 10. Branch Anti-Patterns Registry

The following patterns represent branching strategy violations. Every anti-pattern has a designated owner responsible for monitoring and remediation:

| Anti-Pattern | Cause | Impact | Detection | Remediation | Accountable Role |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Zombie Branches** | Neglected PRs | Branch bloat, staging drift | Stale branch alerts | Prune stale branches nightly | Release Governance |
| **Permanent Release**| Bypassing main | Divergence of trunk | Branch age >14 days | Archive branch post-deployment | Release Governance |
| **Stacked Feature Chains**| Large tasks | Large code review batches | Peer commits detection | Decompose tasks into flags | Domain Architect |
| **Branch Ambiguity**| Missing owners | Missing stewardship | Mismatched CODEOWNERS | Enforce CODEOWNERS validation | Governance Board |
| **Direct Pushes** | Skipped reviews | Production regressions | Git webhook audits | Enable branch locks | DevSecOps |
| **Undocumented Cherry-Pick**| Rushed patches | Untracked commit history | Missing `-x` marker | Evict and re-run cherry-pick | DevSecOps |
| **Emergency Normalization**| Tooling gaps | Governance erosion | Fast-track frequency | Audit bypass requests monthly | CAB |
| **Long-Lived Experiments**| Prototype drift | Merge hell, stale code | Branch age >10 days | Move experiments to draft PRs | Quality Board |
| **Orphaned Hotfixes**| Forgotten back-merge| Regression in main | Release-tag diff checks | Run mandatory back-merge checks| SRE |
| **Hidden Governance**| Bypassing board | Policy changes bypass | Direct commits audit | Block force-pushes on gov | Executive ARB |

---

## 11. Branch Metrics Dashboard

The SRE team and the Release Governance Board track the following KPIs to monitor branch health:

| Metric | Target KPI | Verification Mechanism |
| :--- | :--- | :--- |
| **Average Branch Lifetime** | `<3 days` | Git commit history analytics |
| **Merge Queue Wait** | `<30 min` | Merge queue log tracking |
| **Failed Merges** | `<2%` | CI build success metrics |
| **Backport Success** | `100%` | Release-tag to main diff checks |
| **Hotfix Audit Completion**| `100%` | Retrospective checklist logs |
| **Branch Cleanup** | `100%` | Nightly branch deletion logs |
| **Release Predictability** | `>95%` | Sprint tracking analytics |
| **Flag Removal Compliance**| `100%` | Feature flag age alerts |

---

## 12. Branch Decision Records (BDR)

All changes, exceptions, or customizations to branching rules, protected branch permissions, or merge queue parameters must be recorded as BDRs inside `docs/bdr/`.

### BDR Index
* **BDR-001:** Trunk-based development and short-lived features validation.
* **BDR-002:** Protected branch matrix and approval controls.
* **BDR-003:** Semantic versioning automation rules.
* **BDR-004:** Weekly release train cadence rules.
* **BDR-005:** Merge queue serialization parameters.

---

## 13. Branching Strategy Readiness Gate (MANDATORY)

Before active application development can commence, the branching controls must be verified:

□ Protected branches configured
□ Merge queue enabled
□ SemVer automation active
□ Feature flag governance approved
□ Release cadence validated
□ Hotfix drills executed
□ Cherry-pick procedures tested
□ Branch cleanup automation enabled
□ Metrics dashboards operational
□ BDR ownership assigned

*Rule: If branching discipline cannot guarantee safe releases, development cannot scale.*

---

## 14. Institutional Engineering Principle

> **Core Philosophy:**  
> A clean branching strategy protects the stability of our delivery pipelines. The branch structures we design today define the velocity of our integrations tomorrow. Commit frequently, keep lifetimes short, protect release branches, and respect the merge queue.
>
> **Build once. Evolve forever.**

**🙏 श्री गणेशाय नमः**
