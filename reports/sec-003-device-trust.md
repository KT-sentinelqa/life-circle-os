# SEC-003: Device Trust Foundation

**Status:** Completed
**Scope:** Device Trust Subsystem and Risk Engine
**Date:** 2026-07-11

## Architecture Overview
Based on ARB feedback, the Device Trust functionality was explicitly elevated into its own bounded context (`lib/src/features/device_trust/`) rather than residing as a subset of authentication.

The architecture follows the sequence:
`Identity -> Session -> Device Registration -> Device Trust -> Authorization -> Synchronization`

## Delivered Components

### 1. `DeviceTrust` Domain
- `DeviceTrustLevel`: A granular enum (`Verified`, `Trusted`, `Limited`, `Restricted`, `Blocked`, `Unknown`) replacing the binary boolean.
- `BiometricState`, `DeviceRiskLevel`, `AppAttestationState`.
- `DeviceTrustResult`: The composite object returned to downstream consumers carrying the exact confidence score and boolean requirements (e.g. `requiresReAuthentication`).

### 2. `RiskEngine` (Application Layer)
- Evaluates raw `DeviceSignals` against the canonical threat model.
- Automatically handles threat mitigation:
  - Drops score to 0 (`Blocked`) for rooted/jailbroken devices.
  - Returns `Restricted` for attached debuggers.
  - Automatically degrades trust for stale sessions or failed attestations.

### 3. `AuthorizationContext` Integration
- The `PolicyEngine` now natively consumes the `DeviceTrustResult`.
- If the device is `Blocked`, the action is unconditionally denied.
- If the device is `Restricted`, the action is only permitted if `isEmergencyActive` is true (Break-Glass scenario).

### 4. Infrastructure Interfaces
- Formalized `BiometricService`, `AppAttestationService`, and `KeystoreService` to enforce clean architectural boundaries when we introduce native Swift/Kotlin bridging later in the phase.

## Verification
- Wrote `test/unit/device_trust/risk_engine_test.dart` confirming the deterministic threat mitigation rules.
- Threat Model documented at `reports/device-trust-threat-model.md`.
