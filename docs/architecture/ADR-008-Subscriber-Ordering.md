# ADR-008: Subscriber Execution Ordering

**Status**: Approved
**Date**: 2026-07-12
**Context**: Phase 4 Sprint 3 Observability Review

## Context
During the Phase 4 Sprint 3 review, the following observation was made:

> *"Document whether subscriber execution order is guaranteed or simply the current implementation. If order becomes part of the architecture, make it an explicit contract."*

The current `EventSubscriberRegistry` registers the `ObservabilitySubscriber` first so that metrics are captured before any functional subscriber runs. This is currently an implementation convention, not an explicit architectural contract.

## Decision
We formally declare subscriber execution ordering to be an **explicit architectural contract** governed by the following rules:

### Mandatory Ordering Tiers

| Tier | Role | Subscribers | Rationale |
| :--- | :--- | :--- | :--- |
| **Tier 0** | Platform Observation | `ObservabilitySubscriber` | Metrics must be captured before any business logic runs. |
| **Tier 1** | Durability | `OutboxSubscriber` | Offline persistence must be guaranteed before UI/timeline side effects. |
| **Tier 2** | User-Visible Side Effects | `TimelineSubscriber`, `ReminderSubscriber` | UI updates and notifications execute after persistence is confirmed. |
| **Tier 3** | Domain Sagas | `PlanningSagaManager`, future Sagas | Cross-domain orchestration runs last to prevent saga-triggered events from interfering with Tier 1 guarantees. |

### Rules
1. The `EventSubscriberRegistry.registerAll()` method MUST accept and enforce tier ordering.
2. Any new subscriber introduction MUST declare its tier in a PR description.
3. Changing tier ordering requires Architecture Review Board approval and an ADR amendment.
4. Tiers are advisory for Dart's single-threaded stream model — subscribers within the same tier are effectively concurrent. Tier ordering is enforced through registration sequence.

## Consequences
- **Positive**: Subscriber ordering is now a documented, enforceable contract. Adding new subscribers requires an explicit tier declaration.
- **Negative**: The tier model adds a small amount of ceremony when onboarding new subscribers.

## Compliance
The `architecture_test.dart` suite should be extended in a future sprint to verify that `ObservabilitySubscriber` is always registered before any `TimelineSubscriber` or `ReminderSubscriber` instances.
