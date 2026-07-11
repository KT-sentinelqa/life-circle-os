# SEC-002: Authorization Foundation

**Status:** Completed
**Scope:** Policy Engine, Context, and Decisions
**Date:** 2026-07-11

## Overview
This milestone establishes the foundational authorization architecture for LifeCircle OS. We explicitly rejected enterprise RBAC in favor of a canonical Family-Centric authorization model, evaluated by a centralized `PolicyEngine`.

## Architecture Delivered

### 1. `AuthorizationContext`
Authorization decisions no longer rely on disparate arguments or raw strings. Every decision evaluates a cohesive `AuthorizationContext` encompassing Identity, Device Trust, Timestamp, and Emergency State.

### 2. `AuthorizationDecision`
Authorization no longer returns bare `true`/`false` booleans. The engine returns rich semantic decisions (e.g., `allowWithAudit`, `denyBreakGlassRequired`, `denyDeviceUntrusted`). This strictly centralizes future auditing and UX mapping.

### 3. `PolicyEngine`
A pure, deterministic dart class implementing the Permission Matrix specified in `AUTHORIZATION_MODEL.md`. It strictly contains zero Riverpod or UI logic, making it universally testable.

### 4. `AuthorizationService`
The orchestrator mapping Riverpod application state to the `PolicyEngine`. It intercepts the request, constructs the `AuthorizationContext`, and executes the policy evaluation.

## TDD Policy Adherence
As instructed, policies were defined as TDD tests within `test/unit/authorization/policy_engine_test.dart` prior to implementing the matching engine logic.

**See `reports/sec-002-policy-coverage.md` for the full capability coverage.**

## Governance Actions
- Added `B-05` to tracking (Backend Contract missing).
- Verified `UnsupportedError` properly replaces `UnimplementedError` across all legacy mock-auth bounds.
