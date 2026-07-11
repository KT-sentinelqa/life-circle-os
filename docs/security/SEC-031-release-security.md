# SEC-031: Release Security

**Status:** Enforced | **Phase:** 7

## Policy Rules

### 1. Mandatory Security Gates
Before any code can be merged into `main` or a `release/` branch, the CI pipeline MUST pass the following automated security scans:
- **Secrets Scanning:** (e.g., TruffleHog, Gitleaks) to prevent accidental commit of API keys, certificates, or passwords.
- **Dependency Scanning:** (e.g., Dependabot, Snyk) to identify known CVEs in third-party packages (Dart/Flutter pub packages, iOS CocoaPods, Android Gradle dependencies).
- **Static Application Security Testing (SAST):** Code analysis to detect insecure coding patterns.

### 2. Software Bill of Materials (SBOM)
Every Release Candidate must generate an SBOM during the CI build process. This provides an auditable inventory of all libraries and transitive dependencies included in the binary.

### 3. Build Provenance
Builds distributed to internal/external testers must be compiled exclusively by the CI/CD server. Developer laptops are strictly prohibited from uploading binaries directly to TestFlight or Firebase. This ensures the binary exactly matches the audited source code.

### 4. Code Signing Protection
Code signing certificates and provisioning profiles must be encrypted at rest and managed securely (e.g., Fastlane Match using a private, encrypted repository). The decryption passphrase must be stored securely in the CI provider's secrets vault.
