# LifeCircle OS Engineering Governance

- Status: Proposed — Founder-initiated; immutable only after explicit board ratification
- Owner: Founder Office and Change Advisory Board
- Review Board: 39-Role Architecture Review Board
- Last Review Date: 2026-07-11
- Next Review Date: Prior to ratification

## 1. Authority and Scope

This document defines the repository-level engineering constitution for
LifeCircle OS. On ratification, it is a locked policy: amendments require a
written proposal, impact analysis, applicable board decisions, Founder
approval, and a recorded decision in Git.

It governs every production code, infrastructure, contract, schema, test,
configuration, and documentation change. It does not replace the existing
Operating Agreement or Governance Model; those documents remain the detailed
operating framework. Where policies conflict, the constitutional hierarchy in
`docs/governance-model.md` applies.

LifeCircle remains global-first, enterprise-first, offline-first,
privacy-first, security-first, and committed to Apple-quality experience and
long-term maintainability. A delivery deadline does not override these
principles.

## 2. Engineering Principles

1. Evidence over intent. Documentation states a decision; tests, contracts,
   deployments, and running controls prove it.
2. Privacy and security are design constraints, never post-release work.
3. The local user experience remains useful without network connectivity.
4. Domain ownership is explicit. No component silently owns another domain's
   data or invariants.
5. Interfaces evolve compatibly and are versioned where externally consumed.
6. Every change is observable, reversible where feasible, and attributable.
7. Quality gates are mandatory. A passing manual demo does not override a
   failing build, analysis, test, security, accessibility, or contract gate.
8. Mocks and placeholders may support tests or demos only. They are not
   production controls and must be visibly isolated from production paths.

## 3. Permanent Review Boards

Every proposed change receives an impact classification. Only boards relevant
to the change are required, but each required board is a merge gate. A board
must issue exactly one decision: **APPROVED**, **APPROVED WITH CONDITIONS**, or
**REJECTED**. Conditions must be closed and evidenced before merge. Silence is
not approval.

| Board | Responsibility | Required when | Merge authority |
|---|---|---|---|
| Executive Architecture Board | System architecture, DDD, bounded contexts, ADRs, long-term evolution | Architectural boundaries, domain model, APIs, events, storage, dependencies, or ADRs change | Yes |
| Platform Evolution Board | Prevent architectural drift, duplicate capability, premature service splitting, uncontrolled dependency growth, and unplanned platform refactors | Platform-wide refactors, module/service split or consolidation, cross-cutting capability, major dependency, or evolution roadmap changes | Yes |
| Security Review Board | Authentication, cryptography, privacy, identity, compliance, data protection | Identity, PII, secrets, permissions, encryption, telemetry, or external trust boundary changes | Yes |
| Mobile Architecture Board | Flutter, Riverpod, device integration, offline-first, mobile UX | Mobile application, local persistence, background execution, or client sync changes | Yes |
| Backend Platform Board | APIs, messaging, databases, data ownership, backend scale | API, schema, event, queue, database, or backend service changes | Yes |
| DevOps & SRE Board | CI/CD, observability, deployment, resilience, infrastructure | Workflows, release process, IaC, runtime configuration, monitoring, or operational runbooks change | Yes |
| Performance Board | Latency, memory, battery, throughput, capacity | Hot paths, storage, sync, rendering, queries, queues, or capacity-affecting changes | Yes |
| Accessibility & UX Board | Accessibility, interaction quality, design consistency, localization | User-facing behavior, visual design, content, navigation, localization, or notifications change | Yes |
| Product Review Board | User problem, product vision, workflow simplicity, cognitive load, and product value | New or materially changed user-facing capability, workflow, or product policy | Yes |
| Data Governance Board | Ownership, retention, deletion, export, consent, residency, transfers, auditability, and PII inventory | Data model, PII, consent, retention, analytics, regional processing, import/export, or data-sharing changes | Yes |
| Release Certification Board | Release-level security, privacy, performance, resilience, rollback, compliance, SLO, monitoring, and cost certification | Beta, release candidate, production release, or hotfix promotion | Yes |
| QA Governance Board | Test strategy, test data, contract verification, release gates, quality metrics | Any production behavior, test tooling, release gate, or quality threshold changes | Yes |

The named boards are functional gates within the existing 39-role governance
model. The current Governance Model owns detailed roles, escalation paths, and
successor rules; this document defines the repository merge policy.

## 4. Milestone-Aware Review

Every review begins by stating the current milestone, the milestone's explicit
exit criteria, and the earliest later milestone affected by the change. A
reviewer must classify findings as:

- **Blocks current milestone**
- **Required before a named future milestone**
- **Architecture debt with a documented remediation date**
- **Unverified; evidence required**

Deferred global capabilities are not automatically current defects. They are
acceptable only when the current design has documented ownership and a credible
evolution path. An unimplemented security, identity, privacy, sync, or data
integrity control is never treated as complete merely because it is planned.

| Milestone | Primary outcome | Minimum gate focus |
|---|---|---|
| Sprint 1 — Foundation | Buildable, analyzable, testable baseline | Clean builds, deterministic configuration, module boundaries |
| Sprint 2 — Core Platform | Durable platform primitives | Local storage, contracts, observability seams, ADRs |
| Sprint 3 — Identity | Real identity and authorization | Authentication, device trust, key lifecycle, privacy review |
| Sprint 4 — Sync | Authenticated multi-device state movement | Outbox/inbox, idempotency, conflict policy, contract tests |
| Sprint 5 — Offline | Reliable offline behavior | Local source of truth, recovery, background behavior, battery budgets |
| Sprint 6 — Beta | Controlled user validation | Release gates, telemetry, accessibility, support, incident readiness |
| Sprint 7 — Production | Public global operation | Security, resilience, scalability, privacy operations, production certification |

## 5. ADR and Decision Policy

No significant implementation begins without an approved ADR or an explicit
recorded determination that an existing ADR governs it. An ADR is mandatory for
authentication, authorization, cryptography, local database, encryption,
synchronization, event contracts, API versioning, notifications, country or
locale detection, localization, privacy, retention, data ownership, new
dependencies, infrastructure topology, and material performance budgets.

ADRs must identify context, decision, alternatives, consequences, ownership,
compatibility and migration plan, security/privacy impact, operational impact,
test strategy, and review decisions. Implementations must link to the ADR they
realize. A mismatch between an ADR and code is a blocking defect.

## 6. Merge Policy

A change may merge only when all of the following are true:

1. Requirement, acceptance criteria, current milestone, and change impact are
   recorded.
2. Required ADRs and API/event/schema contracts are approved and linked.
3. Every applicable board has issued an approval decision; all conditions are
   closed with evidence.
4. Required automated checks pass on the proposed commit. No failures may be
   hidden with permissive commands such as `|| true`.
5. Unit, integration, contract, security, performance, accessibility, and
   localization testing are executed in proportion to the change and their
   results are retained.
6. The change has a rollback or migration plan appropriate to its blast radius.
7. Documentation, runbooks, dashboards, alerts, and support material are
   updated where behavior or operation changes.
8. Founder approval is recorded for decisions designated by the Operating
   Agreement, constitutional changes, and material product-risk acceptance.

Emergency mitigation may bypass normal sequencing only under the incident
process. The bypass must be documented, time-limited, reviewed by the relevant
boards, and followed by a corrective ADR or post-incident action.

## 7. Definition of Done

Work is not done when it compiles on one machine or looks correct in a demo.
For the applicable milestone, it is done only when the implementation,
contracts, automated evidence, board decisions, release readiness, and
documentation satisfy the merge policy.

At minimum, production changes require zero compile errors, zero analyzer
errors or warnings under the repository policy, passing required tests, no
known critical/high security finding without formally accepted remediation, no
unreviewed secrets, and no unowned technical debt introduced by the change.

## 8. Standards and Non-Negotiable Controls

- **Security:** least privilege; no secrets in source or mobile binaries;
  authenticated and authorized service boundaries; managed key lifecycle;
  encryption in transit and at rest where classified data requires it.
- **Testing:** layered unit, integration, contract, end-to-end, regression, and
  failure-path coverage; deterministic test data; failing tests block merge.
- **Performance:** defined and measured budgets for startup, interaction,
  network, database, battery, memory, and throughput on affected paths.
- **Accessibility and UX:** WCAG 2.2 AA target, semantic validation, dynamic
  type, keyboard and screen-reader support as applicable, calm error states,
  and user-recoverable flows.
- **Globalization:** no hard-coded user-facing copy in production UI; locale,
  timezone, date, number, address, and right-to-left behavior are designed and
  tested for supported markets.
- **Observability:** structured, privacy-safe logs; metrics, traces, dashboards,
  and actionable alerts for production-critical operations.
- **Technical debt:** entered with owner, rationale, impact, remediation
  milestone, and board acceptance. Unowned debt blocks merge.
- **Incident management:** service changes include applicable alerting,
  rollback, runbook, ownership, and post-incident obligations.

## 9. Compliance and Enforcement

CI/CD must enforce this policy mechanically wherever feasible: required checks,
dependency and secret scanning, contract verification, quality thresholds,
policy validation, and release attestations. Manual approval cannot waive a
failed mandatory technical control without an explicit, time-bound Founder and
CAB risk acceptance recorded in Git.

## 10. Machine-Readable Review Evidence

Every board review produces both a human-readable report and a JSON report
that conforms to `reports/review-report.schema.json`. CI evaluates the JSON
report, not prose, to determine whether the gate may pass. Reports must record
the commit SHA, milestone, requested/applicable boards, decision, conditions,
findings, evidence references, and required-before milestone for deferred work.

The standard report names are:

- `reports/architecture-review.json`
- `reports/platform-evolution-review.json`
- `reports/implementation-review.json`
- `reports/security-review.json`
- `reports/performance-review.json`
- `reports/product-review.json`
- `reports/data-governance-review.json`
- `reports/release-certification.json`

Report templates and CI-consumption rules are defined in `reports/README.md`.
An absent, invalid, stale, or non-approved report fails its required gate.

This policy takes effect after ratification. Until then, it is the required
proposal for governance-layer review before significant new feature work.
