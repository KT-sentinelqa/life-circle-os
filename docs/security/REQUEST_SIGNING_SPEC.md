# Request Signing Specification

**Status:** Proposed (SEC-004D)

This document defines the strict canonicalization and signing rules for all authenticated API requests within LifeCircle OS. It exists to guarantee deterministic signature generation and verification between the mobile clients and the backend.

## 1. Cryptographic Primitive
- **Algorithm:** Ed25519 (Edwards-curve Digital Signature Algorithm).
- **Hash:** SHA-512 (used natively within Ed25519).
- **Encoding:** All signatures MUST be Base64 encoded in HTTP transit.

## 2. Canonical JSON Normalization
To prevent signatures from invalidating due to whitespace or key-ordering differences across parsers, all JSON payloads MUST be normalized before signing.

1. **Minification:** Strip all non-significant whitespace (spaces, tabs, newlines) outside of string values.
2. **Key Ordering:** Lexicographically sort all object keys (recursively).
3. **UTF-8 Normalization:** Strings MUST be normalized to UTF-8 without byte-order marks (BOM).
4. **Escaping:** Forward slashes (`/`) MUST NOT be escaped (e.g. `https://` remains `https://`, not `https:\/\/`).

## 3. The Canonical Request String
The signature is NOT just applied to the body. To prevent header tampering and replay attacks, we sign the entire "Canonical Request String".

**Construction Rule:**
```text
<HTTP Method>\n
<Canonical URI>\n
<Sorted Query String>\n
<X-Key-Id>\n
<X-Nonce>\n
<X-Timestamp>\n
<X-Request-Id>\n
<Canonical JSON Body>
```

**Example Canonical String:**
```text
POST
/api/v1/family/sync
familyId=123&version=2
key-id-12345
nonce-abcdef
2026-07-11T12:00:00Z
req-uuid-9876
{"data":"value"}
```

## 4. Signing & Verification Rules
1. The client constructs the Canonical Request String.
2. The client invokes `SigningService.sign(CanonicalRequestBytes)` (which routes down to `PlatformCryptoProvider` -> Secure Enclave).
3. The resulting signature is Base64 encoded.
4. The client attaches the headers:
   - `X-Signature: <base64>`
   - `X-Key-Id: <id>`
   - `X-Nonce: <nonce>`
   - `X-Timestamp: <timestamp>`
   - `X-Request-Id: <uuid>`

### Backend Verification
1. The backend exacts the HTTP request.
2. The backend reconstructs the Canonical Request String using the exact same rules.
3. The backend fetches the public key associated with `X-Key-Id`.
4. The backend verifies the signature. If invalid, reject with `401 Unauthorized`.
5. The backend checks if the `X-Nonce` or `X-Request-Id` has been replayed.
6. The backend verifies that `X-Timestamp` is within the allowed 5-minute drift window.
