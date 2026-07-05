# SEC-012: Audit Logging Policy

## 1. Objective
To establish absolute non-repudiation and traceability for critical family events (e.g., administering medicine, transferring financial ownership, altering elder-care consent). 

## 2. The Cryptographic Ledger
Critical state transitions within the Responsibility Engine must not just overwrite the `status` field. They must append a record to a local, immutable `AuditLog` table.

## 3. Log Schema Requirements
Every audit log entry must contain:
* `eventId`: UUID
* `actorId`: The UUID of the user performing the action.
* `action`: e.g., `MARKED_COMPLETE`, `ESCALATION_TRIGGERED`.
* `targetId`: The UUID of the `FamilyResponsibility`.
* `timestamp`: High-precision local device time.
* `signature`: A hash of the payload signed by the device's private key (KeyStore/Secure Enclave).

## 4. Tamper Resistance
Because LifeCircle OS data is stored locally via Isar, a sophisticated attacker (or rogue family member with physical device access) could theoretically modify the SQLite/Isar binary. The `signature` field ensures that if a record is altered directly in the filesystem, the application will detect the corruption upon load and flag the integrity breach.

## 5. Sync Priority
Audit logs are classified as **Sensitive** data. They are synchronized to the cloud (if opted-in) with AES-256-GCM encryption and cannot be permanently deleted by a standard user action for a period of 90 days.
