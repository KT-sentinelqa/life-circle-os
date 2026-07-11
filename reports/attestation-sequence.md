# Attestation Lifecycle Sequences

**Status:** Proposed (SEC-004C.3)

This document formalizes the operational sequences required to maintain device trust across the application lifecycle.

## 1. Registration
1. Client requests a cryptographic nonce from the backend.
2. Backend generates a 32-byte secure nonce, caches it with a 5-minute TTL bound to the `userId` or `deviceId`.
3. Client generates a new EC P-256 Attestation Key via `PlatformCryptoProvider`.
4. Client passes the Key ID and Server Nonce to the OS Native API (App Attest / Play Integrity).
5. OS returns the Base64 Attestation Object.
6. Client transmits the Attestation Object to the Backend.
7. Backend validates the object and persists the extracted Public Key against the Device Record.

## 2. Challenge & Assertion
1. Client prepares a sensitive API payload (e.g., rotating a Domain KEK).
2. Client hashes the payload.
3. Client signs the hash using the Attestation Key (`signPayload`).
4. Backend receives the request, looks up the registered Public Key, and verifies the signature. If it fails, the request is dropped with `401 Unauthorized`.

## 3. Rotation
Attestation keys are long-lived and bound to the hardware enclave. However, the backend may force a rotation if:
- The device OS upgrades across major versions.
- The `RiskEngine` dictates it.
**Sequence:** The backend issues a `RotateAttestationKey` challenge. The client securely deletes the old key via `PlatformCryptoProvider.destroyKey`, generates a new one, and repeats the Registration flow.

## 4. Revocation & Compromised Device Handling
If the Backend fraud detection system or Apple/Google signals indicate the device is compromised:
1. Backend marks the registered Device Public Key as `Revoked`.
2. All Assertions using that key immediately fail.
3. The Client `RiskEngine` receives the revocation signal on the next sync and transitions `DeviceTrustResult.riskScore` to `Critical`.
4. The Client automatically invokes `destroyKey` on all Domain KEKs, locking local data.

## 5. Replay Detection
1. Server caches the `signature` or a counter attached to the Assertion.
2. Apple App Attest provides a hardware-backed counter that strictly increments. If the counter provided in an Assertion is less than or equal to the server's known counter, the request is rejected as a replay.

## 6. Device Replacement
1. User logs into a new device.
2. The new device has no hardware keys. It requests a Registration Nonce.
3. The Backend detects a new device registration. It invalidates the old device's Attestation Key.
4. The user must use a Break-Glass Recovery or authenticate via MFA to provision the Domain KEKs to the new device.
