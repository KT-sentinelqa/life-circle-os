# ADR-007: Event-Driven Architecture Freeze

**Status**: Approved
**Date**: 2026-07-11
**Context**: Phase 3B Integration Audit

## Context
Over the course of Phase 3B, we added 5 new bounded contexts (Medicines, Finance, Documents, Vehicles, Trust). We successfully prevented domain-coupling by implementing the `DomainEventBus`, `SubscriberRegistry`, and `ReferenceRegistry`. 
We now have empirical proof that new bounded contexts can be added to the platform without requiring any modifications to existing contexts. The architecture is mathematically stable.

## Decision
We formally freeze the Event-Driven Architecture (EDA) primitives as the undisputed platform standards for all future development in LifeCircle OS.

1. **The Event Bus Mandate**: No Bounded Context is permitted to directly call the Application Service or Repository of another Bounded Context. All side-effects MUST be triggered asynchronously via the `DomainEventBus`.
2. **The Registry Mandate**: No Bounded Context is permitted to embed cross-domain validation logic. All validations MUST route through the `ReferenceRegistry` (e.g., `isValidMember()`, `isValidDocument()`).
3. **The Subscriber Isolation Mandate**: All Background Subscribers MUST be registered centrally via the `EventSubscriberRegistry`. Subscribers MUST be idempotent. A crash in a Subscriber MUST NEVER bubble up to rollback the Aggregate transaction that produced the event.
4. **The Outbox Mandate**: Bounded Contexts are strictly prohibited from implementing their own cloud synchronization logic or `package:http` network calls. All external synchronization MUST occur via the `OutboxSubscriber`.

## Consequences
- **Positive**: LifeCircle OS can scale to 50+ bounded contexts without the codebase collapsing into spaghetti code. The architecture enforces zero-blast-radius execution.
- **Negative**: Engineers must accept the cognitive overhead of eventual consistency. Synchronous cross-domain validation is impossible outside of the `ReferenceRegistry`.

## Compliance
Any Pull Request that introduces a direct cross-domain import (e.g., `import 'package:lifecircle/vehicles/...'` inside the `finance` module) MUST be rejected by the Architecture Review Board.
