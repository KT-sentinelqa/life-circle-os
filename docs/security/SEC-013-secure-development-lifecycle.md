# SEC-013: Secure Development Lifecycle (SDLC)

LifeCircle OS embeds security directly into the Agile workflow, preventing security from becoming an afterthought.

## 1. Planning Phase (Phase 4.1A)
* **Threat Modeling**: Every new Epic requires an update to `SEC-003-threat-model.md`.
* **Privacy Impact Assessment**: Evaluating if the feature collects new PII.

## 2. Design Phase (Phase 4.1C)
* **Security Architecture Review**: Ensure DDD boundaries and encryption models adhere to MASVS-STORAGE and MASVS-CRYPTO.

## 3. Implementation Phase (Phase 4.2)
* **SAST**: Static Application Security Testing runs on every Pull Request.
* **Secrets Scanning**: Pre-commit hooks prevent hardcoded API keys.

## 4. Testing Phase (Phase 4.2B)
* **MASVS Verification**: Automated regression checks against the mobile baseline.

## 5. Release Phase (Phase 4.3)
* **CISO Sign-Off**: The final gate mandated by `SEC-011`.
