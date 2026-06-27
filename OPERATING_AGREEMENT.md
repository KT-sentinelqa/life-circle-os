# LifeCircle OS — Architecture & Review Operating Agreement (FINAL)

This document defines how implementation and governance will work throughout the LifeCircle OS project.

---

## Golden Rule
The Implementation Engineer SHALL NOT:
- Skip a requested document.
- Compress multiple phases into one.
- Generate code before documentation approval.
- Introduce architectural assumptions.
- Change naming conventions without ADR approval.
- Add dependencies without governance approval.
- Ignore performance, accessibility, observability, or security implications.

If uncertainty exists:
**STOP.**
**Request clarification.**
**Never assume.**

---

## Roles & Architecture Review Board (ARB)

The LifeCircle OS ARB is a multi-disciplinary body composed of the following 39 mandatory roles, divided into specialty boards.

### Executive Architecture Board
1. **Chief Solution Architect:** Domain modeling, DDD context boundaries, clean architecture alignment, and overall evolution strategy.
2. **Enterprise Architect:** Long-term alignment of capabilities, system lifecycle, and cross-project modularity.
3. **Principal Mobile Architect:** Flutter architecture, Riverpod usage, mobile patterns, and dynamic UI adaptations.
4. **Backend Architect:** FastAPI structure, clean architecture boundaries, database connections, and event schemas.
5. **Domain Architect:** Enforces pure business domain integrity; protects core logic from leaking frameworks.
6. **API Governance Architect:** Contract definitions, path versioning, schema mappings, and error response structures.
7. **Integration Architect:** RabbitMQ event flow, outbox synchronization pipelines, and platform consistency.

### Security & Privacy Board
8. **Security Architect:** Access control validation, threat modeling, and OWASP compliance audits.
9. **Privacy Architect:** Data minimization, purpose limitation, user rights validation, and DPDP/GDPR alignment.
10. **Identity Architect:** Authentication schemes, multi-factor setups, device trust, and role configurations.
11. **DevSecOps Architect:** SAST, DAST, SCA pipelines, SBOM generation, secrets scanning, and artifact signing gates.
12. **Cryptography Reviewer:** Key lifecycle management, secure Keystore/Keychain integration, and backup encryption.
13. **Compliance Officer:** Alignment with DPDP fiduciaries rules, GDPR regulatory processing, and local privacy laws.

### Reliability & Platform Board
14. **Observability Architect:** OpenTelemetry collections, Prometheus metrics, Grafana dashboards, and Sentry configurations.
15. **Site Reliability Architect (SRE):** Four Golden Signals, SLO availability targets, error budgets, and system saturation alerts.
16. **Disaster Recovery Board:** Backup snapshots, WAL continuous journaling, recovery drills, and RTO/RPO target validation.
17. **Platform Architect:** Host runtime environment configurations, container isolation, and caching layers (Redis).
18. **Infrastructure Architect:** Declarative Terraform configurations and host provisioning workflows.
19. **Release Governance Board:** Automated pipeline validation, version tags, deployment triggers, and release check-offs.

### Quality Engineering Board
20. **Chief QA Architect:** Test pyramid strategy, code coverage thresholds, and pipeline test validation gates.
21. **Test Automation Architect:** Integration and widget testing automation pipelines.
22. **Performance Testing Architect:** Load, stress, spike, and capacity verification profiles.
23. **Mobile Testing Architect:** Golden visual regression checks and framerate drop tests.
24. **Security Testing Board:** Automated vulnerability scanning, secrets checking, and pen testing management.
25. **Accessibility Testing Board:** Verification of WCAG 2.2 AA checklists on mobile widgets and text scaling.
26. **Mutation Testing Board:** Injects code mutations to verify test effectiveness against critical domains.
27. **Contract Testing Board:** Pact contract check-offs and provider verification checks.
28. **Test Data Governance Board:** Factory seeding, anonymization, and test dataset integrity.

### UX & Human Factors Board
29. **UX Guardian:** Core emotional success criteria alignment, notification reduction, and cognitive load minimization.
30. **Design System Architect:** Design token definitions, premium typography, and adaptive haptics guidelines.
31. **Elder Experience Specialist:** Elder Mode layout configurations, contrast, and voice guidance checks.
32. **Localization Architect:** Regional language adaptations and localized notice models.
33. **Human Factors Reviewer:** Validation of physical usage patterns, touch sizes, and layout ergonomics.

### Long-Term Governance Board
34. **Legacy Governance Board:** Continuous code readabilty verification and removal of tribal knowledge dependency.
35. **Documentation Governance Board:** Version control of PRDs, architecture guides, and code comment standards.
36. **Dependency Governance Board:** Validation of third-party package licensing, vulnerabilities, and maintenance life.
37. **Open Source Governance Board:** Continuous readiness for self-hosting fallback configurations.
38. **Financial Sustainability Board:** Unit economics, subscription modeling, and compute budget reviews.
39. **Change Advisory Board (CAB):** Approval of all changes to core schemas, system boundaries, and technology stack.

---

## Mandatory Review Workflow

Every proposal, design, API, database schema, or implementation document must run through the following workflow:

```
Gemini (Implementation Proposal)
   ↓
Krishna (Forwarding & Initial Verification)
   ↓
39-Role ARB Review (Explicit states & justifications)
   ↓
Approved / Refinement Needed
   ↓
Gemini Refinement (if required)
   ↓
Production Rollout
```

No document is considered approved unless:
1. **Explicit Review Status:** All 39 roles must review the document.
2. **Explicit States:** Every role must explicitly state: `APPROVED`, `APPROVED WITH CONDITIONS`, `REJECTED`, or `ABSTAINED`. *No silent approvals are permitted.*
3. **Abstentions Justification:** Any role that abstains must explicitly document the reason (e.g., *"No security impact in this document"*).

---

## Review Status Template

Every review response from the ARB must use the following structured template:

```
STATUS: [APPROVED / CHANGES REQUIRED]

MULTI-ROLE REVIEW STATUS
Participating Roles:
✓ [Role Name]: APPROVED [or APPROVED WITH CONDITIONS]
...
Abstained Roles:
○ [Role Name]: ABSTAINED. Reason: [Detailed Justification]
...

RISKS: ...
MANDATORY CHANGES: ...
OPTIONAL IMPROVEMENTS: ...
FINAL VERDICT: ...
```

---

## Document Lifecycle Policy (Rule 4)

Every major design, requirements, or architecture document must contain the following lifecycle metadata block at the top:
* **Status:** Draft / Proposed / Approved / Locked / Deprecated / Archived
* **Owner:** [Role or Board Name]
* **Review Board:** [Participating Boards]
* **Last Review Date:** [Date]
* **Next Review Date:** [Date]

---

## Non-Negotiable Rules & Quality Gates

1. **No assumptions.**
2. **No skipped reviews.**
3. **No feature creep.**
4. **No undocumented changes.**
5. **No architecture modifications without ADRs.**
6. **No implementation without RFC approval.**
7. **No dependency additions without** Security, Dependency, and Open Source Board approval.
8. **No production deployments without passing every quality gate.**

### SCM-018 — Canonical Repository Policy

**Rule:**
* Every production codebase must have exactly one canonical upstream repository.
* `git init` is forbidden inside existing projects.
* New contributors must use `git clone`.
* CI pipelines must validate that origin exists.
* Root commits are permitted only during formal repository bootstrap ceremonies approved by architecture governance.

**Violation:** REJECT RELEASE

---

## Architectural Fitness Functions

**FAIL BUILD IF:**
* Circular dependencies exist.
* Coverage decreases below 90% in core domain logic.
* Duplication exceeds 1%.
* ADRs or RFCs are missing.
* Critical vulnerabilities or exposed secrets exist.
* Accessibility requirements fail WCAG 2.2 AA automated audits.
* Observability requirements are incomplete.
* Disaster recovery verification tests fail.
* Documentation is outdated.

---

## Operating Principle

* **Gemini implements.**
* **ChatGPT governs.**
* **Krishna decides.**
* **Human validation confirms.**

*The objective is not merely to ship software. The objective is to build a family institution that can evolve for decades without requiring a fundamental rewrite.*

**Build once. Evolve forever.**

🙏 श्री गणेशाय नमः
