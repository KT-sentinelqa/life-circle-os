# Key Rotation & Migration Scenarios

**Status:** Proposed (SEC-004B)
**Version:** 1.0

This document defines the strict, deterministic response plans for cryptographic lifecycle events within LifeCircle OS. It ensures data remains accessible through authorized migrations while guaranteeing cryptographic destruction during high-risk events.

## Scenario 1: App Upgrade (Schema/Crypto Version Bump)
- **Trigger:** A new version of the app mandates AES-GCM tags or AAD changes, or rotates the default Key Version.
- **Response:** The `KeyManagementService` detects `currentVersion > keyVersion`. It generates a new DEK for the target data. As the user loads offline records, the `CryptoProvider` decrypts with the `v1` KEK, re-wraps with the `v2` KEK, and asynchronously writes the updated JSON back to SQLite.
- **Outcome:** Gradual, lazy migration of ciphertext to the new standard without blocking the UI.

## Scenario 2: Device Migration (Backup Restore)
- **Trigger:** User restores an iCloud or Google Drive backup to a new physical device.
- **Response:** The local SQLite database is restored, but the hardware-backed Root Platform Key (RPK) remains on the old device. The app boots, detects `RPK == null`, and sets `DeviceTrustLevel.unknown`.
- **Outcome:** The user is forced to re-authenticate via the backend. A new RPK is generated. The backend provisions the Domain KEKs downwards, encrypted for the new RPK. Local-only drafts from the old device are mathematically lost (working as intended).

## Scenario 3: Compromised Key
- **Trigger:** The Backend flags a specific Domain Key as compromised, or the `RiskEngine` detects memory tampering (`DeviceRiskLevel.critical`).
- **Response:** `destroyKeys()` is invoked immediately on the specific Domain KEK. All local DEKs for that domain become unreadable.
- **Outcome:** The local offline cache for that domain is purged. The app must fetch clean data from the server and provision a fresh KEK.

## Scenario 4: Biometric Reset
- **Trigger:** The user adds a new fingerprint or resets FaceID in the OS settings.
- **Response:** The OS invalidates the Secure Enclave / Keystore keys that were bound to the old biometric state.
- **Outcome:** `hasValidKeyPair()` returns false. The `DeviceTrustResult` drops. The app forces re-authentication to provision a new RPK. Data is inaccessible until re-auth.

## Scenario 5: Family Ownership Transfer
- **Trigger:** The Primary Caregiver transfers ownership of the Family Domain to another user.
- **Response:** The backend rotates the Family Domain KEK. The local client receives the signal, deprecates the old KEK (retains it for reading legacy offline records), and wraps all new records with the new KEK.
- **Outcome:** The previous owner can no longer receive or decrypt new sync payloads for the Family.

## Scenario 6: Emergency Recovery
- **Trigger:** A user loses their device and cannot authenticate using their primary MFA. They use a Break-Glass Recovery code.
- **Response:** The backend accepts the recovery code and issues a secure payload containing the Domain KEKs to the new device.
- **Outcome:** The new device generates an RPK, wraps the received KEKs, and seamlessly syncs the encrypted data downwards.
