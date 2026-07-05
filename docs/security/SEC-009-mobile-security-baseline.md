# SEC-009: Mobile Security Baseline (OWASP MASVS-L2)

LifeCircle OS enforces the **OWASP MASVS-L2** standard due to its handling of sensitive health and financial coordination data.

## Mandatory Controls

### Storage (MASVS-STORAGE)
- Data classified as Confidential or higher must use Isar's encryption, backed by device KeyStore/Secure Enclave.

### Cryptography (MASVS-CRYPTO)
- AES-256-GCM is the standard symmetric cipher.
- Deprecated cryptographic primitives (e.g., MD5, SHA1) are strictly prohibited.

### Network Communication (MASVS-NETWORK)
- All traffic must use TLS 1.3.
- Certificate Pinning must be implemented for all LifeCircle OS API endpoints.

### Platform Interaction (MASVS-PLATFORM)
- Background screenshots must be masked to hide sensitive data (e.g., financial cards) in the app switcher.
- Deep links must rigorously validate payloads.

### Resilience (MASVS-RESILIENCE)
- Implement basic Root/Jailbreak detection.
- Emulators and debuggers must be blocked in production release builds.
