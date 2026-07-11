# ADR-035: Device Trust and PKI

**Date:** 2026-07-10  
**Status:** Accepted  

## Context
A username and password (or even a Passkey) proves *who* is acting, but in a Zero Trust environment, we must also prove *what* device is acting. To satisfy SEC-023 (Payload Signatures in SyncEvents), every device must have a verifiable cryptographic identity.

## Decision
1. **Device Keypair Generation:** Upon first successful login (or registration), the LifeCircle app will generate a 256-bit ECDSA (prime256v1) keypair inside the device's secure enclave (iOS Secure Enclave / Android StrongBox).
2. **Key Extraction:** The private key must be marked as non-extractable. It cannot leave the secure hardware.
3. **Public Key Registration:** The public key is sent to the LifeCircle Cloud during the authentication handshake and bound to the user's account as a "Trusted Device."
4. **Payload Signing:** All `SyncEvent` payloads placed in the Outbox will be signed by this private key before uploading (already scaffolded in `SyncService`).
5. **Key Invalidation:** A user can revoke a device from the Family settings screen. This deletes the public key from the cloud, rendering any future sync events from that device invalid.

## Consequences
* **Positive:** Stolen session tokens cannot be used on an attacker's device to forge sync events, because the attacker does not possess the hardware-bound private key.
* **Negative:** Device loss means the keys are permanently lost, requiring re-authentication and re-registration on a new device.
* **Architecture Impact:** We will abstract `DeviceCryptoService` in Flutter to handle platform-specific secure enclave operations.
