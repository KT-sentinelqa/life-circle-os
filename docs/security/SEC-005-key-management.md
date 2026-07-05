# SEC-005: Key Management Architecture

## 1. Encryption at Rest
LifeCircle OS utilizes the Isar Database for offline-first storage. The Isar database is encrypted using a 256-bit AES-GCM key.

## 2. Key Generation & Storage
The database encryption key is securely generated on the device during initial setup. It is **never** stored in plaintext.
* **Android**: The key is stored in the Android Keystore system.
* **iOS**: The key is stored in the iOS Secure Enclave.

## 3. Cloud Synchronization Keys
If a family opts-in to cloud synchronization, end-to-end encryption (E2EE) is strongly preferred. Payload data must be encrypted locally before transit, meaning the cloud backend only stores ciphertext.

## 4. Biometric Gating
Access to the Master Encryption Key (and thereby the application's sensitive data) requires unlocking via device biometrics (FaceID / TouchID) or device PIN when the application resumes from a cold start or long background state.

## 5. Key Rotation & Revocation
If a device is compromised, the user must be able to revoke the device's authorization from a secondary trusted device, rendering any locally cached cloud tokens invalid.
