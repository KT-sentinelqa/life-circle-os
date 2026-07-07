# ADR-025: Identity Model

## Context
Before devices can synchronize, we must define the boundaries of identity. Who belongs to a family? How are users distinguished from devices?

## Decision
We adopt a **Hierarchical Identity Model**:
1. `Family` (Tenant)
2. `User` (Human Member)
3. `Device` (Physical Endpoint)

### Principles
* A `User` belongs to exactly one primary `Family`.
* A `User` can own multiple `Device`s (e.g., iPhone + iPad).
* Permissions (e.g., "Can view financial tasks") are attached to the `User`, not the `Device`.
* The cloud routes sync events based on the `Family` ID, but filters payloads based on the `User`'s roles to enforce Contextual Privacy.

## Consequences
* Simplifies RBAC (Role-Based Access Control) on the backend.
* Requires a strict invitation/onboarding flow to associate a new User with an existing Family.
