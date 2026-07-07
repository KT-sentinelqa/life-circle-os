# SEC-018: Key Lifecycle & Rotation Policy

## 1. Objective
To govern the generation, storage, invalidation, and rotation of the device-backed cryptographic keys used to encrypt the local Isar database.

## 2. Key Generation & Storage
Keys must be generated using AES-256-GCM and stored exclusively within hardware-backed keystores (Android Keystore System / iOS Secure Enclave). 

## 3. Trigger Events for Key Rotation
The application must rotate the local encryption key if:
1. The user explicitly requests it via the Security Settings.
2. The user revokes biometric/device passcode authentication.
3. The app is restored to a new physical device via OS-level backup (where the Secure Enclave keys do not transfer).

## 4. Key Rotation Procedure
1. Generate `New_Key`.
2. Open Isar with `Old_Key`.
3. Export all data to an encrypted memory buffer using `New_Key`.
4. Delete old Isar file.
5. Write new Isar file to disk.
6. Destroy `Old_Key` from the Keystore.
