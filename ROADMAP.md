# LifeCircle OS Engineering Roadmap

- Status: Proposed — Founder-initiated; requires board ratification before enforcement
- Owner: Founder Office and Executive Architecture Board
- Review Board: All applicable permanent review boards
- Last Review Date: 2026-07-11
- Next Review Date: Before Phase 3 commencement

## Purpose

This is the engineering roadmap, not a feature roadmap. Every review starts by identifying the current phase and judges work against that phase's exit criteria. A phase is complete only when the criteria have retained, machine-readable evidence; intent and checklists are insufficient.

## Phase 2: Enterprise Foundation Hardening (✅ COMPLETED)
- **SEC-001**: Biometric & Policy Authentication
- **SEC-002**: Context-Aware Authorization
- **SEC-003**: Device Trust Domain
- **SEC-004**: Cryptography & Transport
- **SEC-005**: Cryptographically Bound Sessions
- **SEC-006**: Offline-First Idempotent Sync

## Phase 3: Product Platform (⏳ NEXT)
*Feature development strictly resting on the locked v0.2.0-enterprise-foundation.*

| Sub-Phase | Domain focus |
|---|---|
| **Phase 3A** | Core Family Domain (Profiles, RBAC, delegates) |
| **Phase 3B** | Household Domain (Locations, Assets, Inventories) |
| **Phase 3C** | Finance Domain (Accounts, Subscriptions, Obligations) |
| **Phase 3D** | Health Domain (Medicine Schedules, Vitals, Histories) |
| **Phase 3E** | Communication (Secure Family Messaging) |
| **Phase 3F** | AI Intelligence (LLM Task Parsing, Automations) |
| **Phase 3G** | Notifications (Push, Alerts, Summaries) |
| **Phase 3H** | Analytics (Observability, Telemetry, Usage Reports) |

## Phase Progression Rules

1. A board review cites this roadmap's current phase and the affected future phase before issuing a decision.
2. A deferred item must have an owner and a required-before phase.
3. Phase promotion requires the applicable boards to approve retained evidence and the Release Certification Board to certify the promotion.
4. New capability work may not be used to hide unresolved foundation work.
5. Milestone metrics are minimum release gates, not targets to be waived for schedule pressure.

## Review Automation

Board reports must conform to `reports/review-report.schema.json`. CI consumes the commit-bound decision, conditions, findings, and evidence references. The human report explains the decision; the JSON report governs automated gating.

## Instruction-File Policy

`AGENTS.md` files contain concise, actionable instructions for the directory they govern: commands, coding constraints, test expectations, and review requirements. Long-lived rationale, policies, board charters, and roadmaps live in the canonical governance and documentation files rather than being duplicated across agent instruction files.
