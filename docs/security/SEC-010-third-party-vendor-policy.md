# SEC-010: Third-Party Vendor Policy

## 1. Zero-Trust Dependencies
Every external Flutter package (`pubspec.yaml`) or native dependency represents a supply chain risk.

## 2. Banned SDK Categories
The following are strictly prohibited from the LifeCircle OS codebase:
- Third-party ad networks.
- Behavioral analytics platforms that sell data.
- SDKs requiring invasive permissions (e.g., precise location, microphone) without a direct product mandate.

## 3. Required Audits
Before adding a dependency, an engineer must verify:
- The package is actively maintained.
- The publisher is trusted.
- The package does not perform undocumented network requests.

## 4. SBOM Generation
A Software Bill of Materials (SBOM) must be generated during the CI/CD pipeline. Known CVEs in dependencies will block the release branch.
