---
last_updated: "2026-07-11T23:15:00Z"
---
## P0 (Phase 2 Execution Sequence)
- [x] **0. Build Health**: Achieve 0 errors and 0 warnings. (Style lints deferred).
- [x] **SEC-000: Production Placeholder Audit**: Security inventory before surgery.
- [x] **SEC-001: Authentication**: Replace mock OTP and demo login with real backend auth.
- [x] **SEC-001.5: Auth Architecture Review**: Answer architectural stability questions before advancing.
- [x] **SEC-002: Authorization**: Remove demo bypass and gate authorization correctly.
- [x] **SEC-003A: Device Trust Domain**: Establish Risk Engine and Trust architecture.
- [ ] **SEC-003B: Platform Integration**: Implement App Attest, Play Integrity, and Secure Enclave.
- [ ] **SEC-003C: Server Verification**: Backend validation of attestation and replay protection.
- [x] **SEC-004A: Crypto Primitives**: AES-GCM, AAD, and version metadata.
- [x] **SEC-004B: Key Management**: Key generation, storage, and rotation.
- [x] **SEC-004C: Platform Integration**: Secure Enclave, Keystore, StrongBox via Pigeon.
- [x] **SEC-004D: Transport Security**: TLS 1.3, Certificate Pinning, RequestContext, Payload Signing.
- [x] **SEC-006: Session Management**: Harden session storage and refresh workflows.
- [x] **SEC-006: Secure Sync**: Replace HttpCloudSyncClient fake responses.

## Phase 3A (Core Family Domain)
- [x] **Sprint 1 - Family Identity**: FamilyAggregate, FamilyMember, Invitations.
- [x] **Sprint 2 - Household Domain**: HouseholdAggregate, Event Sourcing, Entities, ValueObjects.
- [x] **Sprint 3 - Timeline Domain**: TimelineAggregate, Event Append-Only Log.
- [x] **Sprint 4 - Shared Preferences**: Behavioral configuration and invariants.
- [x] **Architecture Audit v1.0**: Validate bounded contexts and strict architecture constraints.
- [x] **Sprint 5 - Public SDK**: Product Capability facades, DTOs, Error mapping.

## Phase 4 (Platform Readiness & Production Engineering)
- [x] **Sprint 1 - Automated Governance**: analysis_options.yaml lock-down, Architecture Compliance Tests (3 Pillars).

## Phase 3B (Core Product Domains)
- [x] **Sprint 1 - Medicines & Care**: Event Bus, MedicineAggregate, Dosage, Schedule, Timeline Integration.
- [x] **Sprint 2 - Finance**: De-monolithed Aggregates (Bills, EMI, Insurance), ReminderSubscriber, ADR-006.
- [x] **Sprint 3 - Document Management**: ReferenceRegistry, Immutable Versioning, Expiry Engine.
- [x] **Sprint 4 - Vehicles**: Subscriber Registry, Odometer constraints, Cross-Domain Document References.
- [x] **Sprint 5 - Trust & Emergency**: TrustNetworkAggregate, VerificationStatus, EmergencyProfile Constraints.
- [x] **Integration Audit v1.0**: Architecture Freeze, Event Flow Matrix, 10-Pillar Evaluation.
- [x] **Sprint 6 - Planning & Coordination**: TaskAggregate, PlanningSagaManager, Cross-Domain Orchestration.

## P1 (Observability & CI)
- [ ] **Observability**: Prometheus, Grafana, and Sentry hooks.
- [ ] **CI Pipeline**: Enforce ARB JSON Evidence on merge.

## P2 (Performance & Polish)
- [ ] **Performance Optimization**: 60/120fps UI tuning, cold start < 2s.
- [ ] **Accessibility Audit**: Validate Elder Mode contrast and TalkBack.
