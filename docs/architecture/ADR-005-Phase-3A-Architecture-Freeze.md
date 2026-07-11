# ADR-005: Phase 3A Architecture Freeze

**Status**: Accepted
**Date**: 2026-07-11
**Deciders**: Executive Architecture Board
**Applies to**: Phase 3 (Product Platform) and beyond.

## Context
During Phase 2, we established the foundational offline-first infrastructure, secure transport, and cryptographic session continuity. In Phase 3A, we instantiated the first four true business bounded contexts: **Family**, **Household**, **Timeline**, and **Preferences**. 

As we prepare to scale the platform (Medicines, Finance, Responsibilities, SDKs), we must ensure that the strict architectural discipline maintained in Phase 3A is permanently locked in. Without this freeze, future modules risk eroding the Clean Architecture boundaries and bypassing the Offline-First Outbox.

## Decision
We mandate the following strict structural constraints for all future business modules:

1. **Four Contexts Approved**: The architectures of the Family, Household, Timeline, and Preferences bounded contexts are officially accepted. They form the canonical reference architecture.
2. **Aggregates Own Invariants**: Business logic MUST reside inside immutable Aggregate classes. Repositories, Application Services, and UI Widgets MUST NOT perform invariant validation.
3. **No Silent Mutations**: Every state change MUST yield a formal Domain Event.
4. **Mandatory Outbox Pipeline**: The UI MUST NOT call the Cloud API directly. Mutations MUST flow from Application Service -> Outbox Repository -> Sync Coordinator.
5. **No Domain Networking**: The Domain Layer MUST NOT import HTTP, Dio, or UI dependencies.
6. **No Direct Aggregate Communication**: Bounded contexts MUST NOT reference each other's database rows directly. They must communicate exclusively via Domain Events or Application Service abstraction layers (e.g., the `ActivityRecordingService`).

## Consequences

**Positive:**
- New engineers can follow a mathematically provable blueprint to build new features (e.g. `FinanceAggregate`).
- Offline-first capabilities are guaranteed by design.
- The platform is immediately ready for an Event-Driven backend microservice architecture.

**Negative:**
- Increased boilerplate for simple CRUD features (requiring explicit Events, Aggregates, and Outbox orchestration).
- Slower initial UI development velocity due to required application service routing.

*This ADR formally locks the Phase 3A Architecture. Exceptions require board ratification.*
