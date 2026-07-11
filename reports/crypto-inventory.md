# Cryptography Inventory

**Status:** Proposed
**Version:** 1.0

This inventory tracks all cryptographic keys utilized across the LifeCircle OS platform, their storage boundaries, and operational lifecycles.

| Key Identifier | Owner | Algorithm | Storage Location | Rotation Interval | Destruction Policy | Backup Policy | Recovery Strategy |
|---|---|---|---|---|---|---|---|
| **Platform Master Key** | Device Trust Service | AES-256-GCM / Hardware Backed | Android Keystore / iOS Secure Enclave | Never (Bound to device) | Destroyed on app uninstall, logout, or wipe | Strictly non-exportable | Irrecoverable. Re-provision new device. |
| **Sync Signature Key** | Sync Service | Ed25519 (or P-256) Asymmetric | Hardware Keystore (Non-exportable) | 30 Days or Risk Level High | Remote Wipe / Logout | None | Server rotates expected public key on re-auth. |
| **Medical Domain Key** | Medicine Access Service | AES-256-GCM | Flutter Secure Storage (Encrypted by Master) | 365 Days | Logout / Master Key deletion | None | Sync downwards from server DEKs. |
| **Financial Domain Key** | Finance Service | AES-256-GCM | Flutter Secure Storage (Encrypted by Master) | 365 Days | Logout / Master Key deletion | None | Sync downwards from server DEKs. |
| **JWT Session Token** | Auth Service | EdDSA (Server-side signed) | Flutter Secure Storage | 1 Hour (Refresh Token 7 Days) | Replaced on refresh | None | Re-authenticate. |
| **Offline Attestation Key** | Device Trust Service | Platform Specific (e.g. EC P-256) | Secure Enclave | App Update/Install | App Uninstall | None | Regenerated via Play Integrity / App Attest. |

---

### Inventory Notes
- **Zero Exportability:** No asymmetric private key (Master Key, Sync Signer, Attestation) is ever permitted to leave the hardware enclave. They cannot be backed up to iCloud/Google Drive.
- **Key Hierarchy Compliance:** Domain keys are strictly symmetric and rely entirely on the Platform Master Key for their at-rest security.
- **Biometric Dependency:** Accessing the Medical or Financial Domain Keys will require `DeviceTrustResult.biometricState == verified` at runtime to unlock the Keystore boundary.
