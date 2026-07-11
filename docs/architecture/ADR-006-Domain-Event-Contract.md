# ADR-006: Domain Event Contract

**Status**: Accepted
**Date**: 2026-07-11
**Deciders**: Executive Architecture Board
**Applies to**: All future bounded contexts.

## Context
With the introduction of the `InMemoryDomainEventBus`, our platform has fully transitioned from synchronous database orchestration to an asynchronous, Event-Driven Architecture (EDA). 

Multiple subscribers (Timeline, Outbox, Notifications, AI) now rely on these events. Without a strict contract, malformed events or crashing subscribers could destroy aggregate consistency or corrupt the offline sync queue.

## Decision
We mandate the following strict rules for all Domain Events and Subscribers:

1. **Absolute Immutability**: Domain Events must be immutable once instantiated.
2. **Metadata Requirements**: Every event MUST contain:
   - `eventId` (UUID for idempotency tracking)
   - `aggregateId` (The exact identity of the mutating entity)
   - `timestamp` (UTC occurrence time)
3. **No Direct References**: Events MUST serialize payload data directly. They MUST NOT contain references to Live Aggregate objects.
4. **Subscriber Idempotency**: Subscribers MUST be idempotent. Because mobile sync queues may retry deliveries, a subscriber receiving `BillPaid` twice must not double-process the timeline.
5. **Zero Blast Radius**: A subscriber throwing an exception MUST NOT crash the publishing thread. The originating aggregate's state mutation must survive even if a subscriber fails.
6. **Backward Compatibility**: Once an event structure is published and synced, fields cannot be deleted or renamed, only added (as optional).

## Consequences
**Positive**:
- Subscribers (like AI and Notifications) can be added or removed without touching core business logic.
- The Timeline and Sync queues are guaranteed mathematically pure ledgers.

**Negative**:
- Strict immutability and payload serialization add boilerplate to every new Event class.
