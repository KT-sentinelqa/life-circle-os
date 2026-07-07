# SEC-019: Local Disaster Recovery Playbook

## 1. Objective
To define recovery strategies for extreme edge cases where the local-first architecture is compromised (e.g., corrupted Isar database, failed migrations, lost/stolen device).

## 2. Corrupted Isar / Failed Migration
* If `Isar.open()` throws a corruption or migration error, the app must **never crash loop**.
* The app must intercept the error, rename the corrupted file to `default.isar.corrupted.[timestamp]`, and initialize a fresh database.
* The user is immediately presented with the "Recovery Dashboard" to sync down the latest state from the cloud (Phase 4.4 feature).

## 3. Stolen Device Scenario
* Because the Isar database is encrypted by the Secure Enclave, data at rest is protected.
* If a device is reported stolen via another family member's app, the cloud immediately revokes the stolen device's sync token.
* A "Remote Wipe" payload is queued. The next time the stolen device connects to the internet, it destroys the local Isar database before attempting any other operation.
