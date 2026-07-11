# Privacy Policy

**Effective Date:** (Pending Launch)
**Jurisdiction:** GDPR / DPDP (India) Aligned

*Notice: This is an engineering-driven template. It must be reviewed by legal counsel prior to public distribution.*

## 1. Zero Trust & PII Scrubbing
LifeCircle OS operates on a "Zero Trust" architecture. Your device generates a cryptographic keypair (SEC-023). We do not collect, store, or process Personally Identifiable Information (PII) beyond what is strictly necessary for the technical operation of the sync engine.
- Telemetry data is scrubbed of all free-text fields before transmission (SEC-028).
- Push notifications do not contain sensitive payload data; they act only as wake-up signals for your device to sync securely (SEC-027).

## 2. Data We Collect
- **Cryptographic Identifiers:** Household UUIDs and Device Public Keys used for routing sync events.
- **Encrypted Sync Events:** We store encrypted BLOBs temporarily in an "Outbox" queue to facilitate syncing between offline devices. We cannot decrypt these payloads.
- **Operational Telemetry:** We collect performance metrics (e.g., app crash logs, cold start times) to ensure the 99.9% SLA (SRE-005).

## 3. Data We Do NOT Collect
- Medical records, prescriptions, or adherence logs.
- The names of family members, children, or emergency contacts.
- Text entered into the "Responsibility" or "Task" fields.

## 4. Your Rights
You possess the right to Absolute Erasure. By invoking the "Wipe Local Data & Logout" function (ADR-034), your local Isar database is destroyed, and your cryptographic session is permanently revoked on our servers.
