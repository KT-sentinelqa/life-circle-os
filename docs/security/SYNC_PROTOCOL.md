# Sync Protocol

**Status:** Proposed (SEC-006)

This document maps the exact message flow between the Outbox Engine and the LifeCircle backend. It ensures replay protection, strict ordering, and deterministic recovery.

## 1. The Sync Envelope
Every sync batch transmitted across the wire MUST be wrapped in a `SyncEnvelope`. 

**Structure:**
```json
{
  "envelopeId": "uuid-v4",
  "batchId": "batch-seq-551",
  "deviceId": "device-123",
  "familyId": "family-456",
  "sessionId": "session-789",
  "keyId": "kek-abc",
  "trustEvidenceId": "attest-xyz",
  "sequenceNumber": 551,
  "schemaVersion": "1.0",
  "encryptedPayload": "<base64-ciphertext>",
  "signature": "<base64-ed25519-signature>"
}
```

## 2. Replay Protection Rules
To defend against manipulation and replay across untrusted networks:
1. **Nonce & Timestamps:** Managed by the underlying Transport `RequestContext`.
2. **Duplicate Envelopes:** The backend MUST reject any `envelopeId` it has already processed.
3. **Monotonic Sequences:** The backend tracks the `sequenceNumber` for each device. If a device submits a sequence number `N`, it will strictly reject `N-1`. Missing sequences (`N+2`) force a client resync state to resolve missing data.

## 3. Communication Flow (Push-Pull)
1. **Push (Outbox Drain):**
   - Client bundles $N$ outbox items into a `SyncBatch`.
   - Client encrypts, wraps, and signs the `SyncEnvelope`.
   - Backend receives, authenticates, unwraps, and processes mutations against the DB.
   - Backend responds with a `SyncDecision` (Acknowledge, Reject, Conflict).
2. **Pull (State Catch-up):**
   - Client requests state updates greater than its `lastPullCursor`.
   - Backend returns `SyncEnvelope`s of other devices' mutations.
   - Client decrypts and applies to the local DB.
