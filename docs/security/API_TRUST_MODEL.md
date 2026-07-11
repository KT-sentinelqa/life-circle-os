# API Trust Model

**Status:** Proposed (SEC-004D)

This document formalizes the Secure Transport and API Trust boundaries for LifeCircle OS. It defines the networking equivalents of the Authorization Model.

## 1. Transport Rules (TLS Policy)
- **Primary:** TLS 1.3 MUST be the preferred negotiation protocol.
- **Fallback:** TLS 1.2 is allowed strictly as a controlled fallback.
- **Insecure:** Downgrade attacks, SSLv3, TLS 1.0, and TLS 1.1 are strictly forbidden.
- **Cleartext:** HTTP (cleartext) traffic is forbidden at the OS level (iOS App Transport Security, Android Network Security Config).
- **TrustManagers:** Custom "Accept All" TrustManagers are strictly forbidden in production.

## 2. Identity Pinning (SPKI)
Do not pin certificates. Certificates expire frequently. We MUST pin the Subject Public Key Info (SPKI).
- **Primary Pin:** Active production root or intermediate CA public key.
- **Backup Pin:** Offline backup CA public key to guarantee zero-downtime rotations.
- **Scope:** Pinning is applied *only* to first-party LifeCircle endpoints. Third-party SDKs must not be pinned.
- **Emergency Plan:** In case of catastrophic key compromise, an emergency app update with new pins is required.

## 3. The API Envelope (`RequestContext`)
Every outbound request MUST carry a canonical context containing:
- `deviceId`: Registered device identifier
- `sessionId`: Ephemeral session ID
- `requestId`: UUIDv4 unique to the request
- `nonce`: Random one-time use string
- `timestamp`: ISO-8601 UTC timestamp
- `trustLevel`: `deviceTrustLevel` string
- `keyId`: The active Attestation Key ID
- `apiVersion`: Active API schema version

## 4. Request Signing
To achieve end-to-end cryptographic trust regardless of TLS termination, every sensitive request payload MUST be signed.
1. Compute Canonical JSON of the request payload.
2. Sign the canonical payload using the Attestation/Identity Ed25519 Private Key.
3. Attach `X-Signature`, `X-Key-Id`, `X-Timestamp`, and `X-Nonce` to the HTTP headers.
4. Server validates the signature against the registered `KeyId` prior to routing.

## 5. Replay Rules
The server MUST strictly reject:
- Any `nonce` that has been seen before.
- Any `timestamp` older than 5 minutes.
- Any duplicate `requestId`.
- Any assertion (signature) attached to an expired `timestamp`.

## 6. Network Observability (`AuditNetworkEvent`)
Every request emits a local telemetry event:
- `endpoint`: Path of the request
- `latencyMs`: Round-trip time
- `tlsVersion`: Negotiated protocol
- `trustLevel`: Trust state at request time
- `pinValidation`: Success/Failure of SPKI pin
- `requestId`: Correlator
- `retryCount`: Number of attempts

## 7. Retry & Error Taxonomy
- **Retryable:** 429 Rate Limit (with Exponential Backoff), 503 Service Unavailable, Network Timeouts.
- **Non-Retryable:** 401 Unauthorized, 403 Forbidden (Attestation Failed), 400 Bad Request, SPKI Pinning Failures.
