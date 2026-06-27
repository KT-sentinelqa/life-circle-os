# LifeCircle OS — Deployment Architecture Specification

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** Release Governance Board & Infrastructure Architect
* **Review Board:** Executive Architecture Board, Security & Privacy Board, Reliability & Platform Board, Quality Engineering Board, UX & Human Factors Board, Long-Term Governance Board
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026

---

## Multi-Role Review Status

### Participating Roles
* **Chief Solution Architect:** APPROVED (Confirms that deployment topology respects micro-service / bounded context boundaries).
* **Enterprise Architect:** APPROVED (Ensures V1 Docker-first architecture facilitates a progressive migration path toward Kubernetes in later phases).
* **Principal Mobile Architect:** APPROVED (Validates that deployment automation builds and signs APKs/IPAs with secure keys).
* **Backend Architect:** APPROVED (Confirms that Gunicorn/FastAPI and pgBouncer container topologies align with resource limits).
* **Domain Architect:** APPROVED (Ensures deployment configurations do not impact domain models or introduce infrastructure coupling).
* **API Governance Architect:** APPROVED (Validates API Gateway routing, header verification, and rate-limiting rules).
* **Integration Architect:** APPROVED (Confirms RabbitMQ broker cluster configuration and queue replication settings).
* **Security Architect:** APPROVED (Enforces secrets scanning, SBOM checking, image signing, and WAF protection at the API Gateway).
* **Privacy Architect:** APPROVED (Ensures environment strategy prevents production data from leaking into staging/QA/dev databases).
* **Identity Architect:** APPROVED (Validates that deployment injection of Doppler/Vault does not expose key rotation credentials).
* **DevSecOps Architect:** APPROVED (Enforces SAST, SCA, image signing, and binary verification quality gates in CI/CD).
* **Cryptography Reviewer:** APPROVED (Confirms code signing keys, TLS 1.3 cert generation, and KMS integration boundaries).
* **Compliance Officer:** APPROVED (Validates that audit tables and immutable deploy logs satisfy regulatory auditing policies).
* **Observability Architect:** APPROVED (Confirms telemetry validation checks run before any traffic switches to new deployments).
* **Site Reliability Architect (SRE):** APPROVED (Validates blue-green traffic shifting rules, health checks, and rollback trigger thresholds).
* **Disaster Recovery Board:** APPROVED (Confirms continuous WAL backup jobs and restore steps match RTO/RPO targets).
* **Platform Architect:** APPROVED (Validates Docker Compose staging structures, pgBouncer resource caps, and CPU/memory allocations).
* **Infrastructure Architect:** APPROVED (Ensures declarative Terraform scripts provision AWS/GCP resources without manual configuration).
* **Release Governance Board:** APPROVED (Enforces progressive promotions, smoke tests, and manual approvals for production release).
* **Chief QA Architect:** APPROVED (Ensures that integration, contract, and smoke tests block automated pipelines upon failure).
* **Test Automation Architect:** APPROVED (Confirms automated contract and API integration test pipelines are run before staging promotion).
* **Performance Testing Architect:** APPROVED (Enforces performance gates, load-testing triggers, and response latency limits).
* **Security Testing Board:** APPROVED (Confirms dynamic security scanners (DAST) run against staging deployments).
* **Mutation Testing Board:** APPROVED (Ensures mutation testing runs in CI/CD to prevent mock verification leaks).
* **Contract Testing Board:** APPROVED (Ensures Pact validation checks block deployments if provider contracts are broken).
* **Test Data Governance Board:** APPROVED (Confirms non-production databases are seeded using synthetic/anonymized datasets).
* **UX Guardian:** APPROVED WITH CONDITIONS (Ensures that blue-green switches happen seamlessly with no connection timeouts for users).
* **Design System Architect:** APPROVED (Confirms asset optimization steps are validated prior to client release).
* **Elder Experience Specialist:** APPROVED WITH CONDITIONS (Validates that mobile client builds are generated with all required accessibility features).
* **Localization Architect:** APPROVED (Confirms regional dictionary compilation passes testing before deployment).
* **Human Factors Reviewer:** APPROVED (Ensures production deployments do not introduce screen lags or response timeouts).
* **Legacy Governance Board:** APPROVED (Ensures deployment scripts and configurations are clear, declarative, and documented).
* **Documentation Governance Board:** APPROVED (Ensures deployment and operational playbooks are version-controlled in Git).
* **Dependency Governance Board:** APPROVED (Enforces package vulnerability scans and license compliance gates).
* **Open Source Governance Board:** APPROVED (Ensures all third-party deployment dependencies are open-source compliant).
* **Financial Sustainability Board:** APPROVED (Confirms that resource sizing choices prevent cloud compute budget creep).
* **Change Advisory Board (CAB):** APPROVED (Validates rollback metrics and CAB approval overrides for deployment gates).

### Abstained Roles
* **Mobile Testing Architect:** ABSTAINED. Reason: Mobile widget test frameworks run locally in pre-commit/PR pipelines, not production servers.
* **Accessibility Testing Board:** ABSTAINED. Reason: WCAG 2.2 AA accessibility evaluations are client-side only.

---

## 1. Docker-First Container Topology

To minimize initial operational complexity while securing future execution scalability, LifeCircle OS implements a strict **Docker-First Container Topology** for its V1 deployment model.

* **Kubernetes Excluded from V1:** Raw Kubernetes configurations are strictly prohibited in the primary release phase to avoid SRE overhead.
* **Staged Evolution Path:**
  * **Phase 1 (Active):** Docker Compose (Local/Dev/QA) + Managed Container Services (Staging/Production). Managed platforms (such as AWS ECS Fargate or GCP Cloud Run) are leveraged for stateless execution nodes.
  * **Phase 2 (Intermediate):** Transition to a managed Container Orchestration Platform.
  * **Phase 3 (Long-Term):** Kubernetes migration (only when warranted by cluster scaling and governed by a formal ADR).
* **Kubernetes-Ready Design:** All configurations are defined using standard OCI-compliant container standards. Environment injection, storage volumes, and network routing are decoupled from the hosting engine, ensuring that migration to a Kubernetes cluster requires zero application code adjustments.
* **V1 Container Stack:**
  * **FastAPI Service:** Statelessly executes coordinate APIs.
  * **pgBouncer Service:** Acts as an intermediate connection pooler proxying database queries to PostgreSQL.
  * **Redis Service:** Caches sessions, API limits, and temporary states.
  * **RabbitMQ Service:** Executes asynchronous domain events and sync queues.
  * **API Gateway (NGINX / Cloud Load Balancer):** Manages HTTPS TLS termination, rate-limiting headers, and static content distribution.

### Container Base Image Policy
To minimize attack surfaces and verify code integrity:
* **Approved Base Images:**
  * Distroless container images.
  * Chainguard minimal images.
  * Alpine Linux (validated and scanned minimal images).
  * Official Long-Term Support (LTS) library images.
* **Forbidden Base Images:**
  * Images tagged with `:latest` (must pin explicit tag/digest).
  * Unknown or unverified publishers.
  * Unmaintained base images.
  * Unverified registries.
* **Mandatory Container Rules:**
  * **Image Pull Policy:** Set to `Always` to ensure base layers are actively updated.
  * **Image Digest Pinning:** Mandatory (pin specific SHA256 hashes in Dockerfiles).
  * **Cosign Verification:** Required for all parent base images and final artifacts.

---

## 2. Immutable Infrastructure Doctrine

To eliminate configuration drift, system errors, and untracked modifications:
* **Cattle, Not Pets:** Production servers and container instances are treated as transient cattle. Troubleshooting via direct modifications is strictly prohibited.
* **No SSH/Manual Production Edits:** Direct SSH access to production containers and database hosts is disabled at the firewall layer. Hot patches, manual code edits, or direct database schema adjustments are forbidden.
* **Everything from Git:** All modifications to infrastructure topology, server provisioning, database credentials, or application configurations must be versioned in Git and executed through automated pipelines.
* **Infrastructure as Code (IaC):** Cloud environments (databases, container registries, networking VPCs, firewall rules) are declared using version-controlled **Terraform** scripts. Terraform state files are locked and stored securely in cloud backends.

---

## 3. GitOps CI/CD Pipeline Lifecycle

All deployments follow a structured GitOps path, promoting changes progressively through pipeline gates. Deployments are never triggered manually or bypassed.

```
Git Commit (Feature Branch)
    ↓
PR Validation (Unit tests, Lints, Code analysis)
    ↓
Security Gates (SAST, SCA, Secrets audit)
    ↓
Artifact Build (Docker compilation & SBOM generation)
    ↓
Artifact Signing (Cosign signature validation)
    ↓
Staging Deployment (Automated rollout to mirror environment)
    ↓
Smoke & End-to-End Tests (Pact contract check, API tests)
    ↓
Manual Sign-Off (Release Board + QA Architect approval)
    ↓
Production Promotion (Blue-Green traffic shift)
```

### Environment Promotion Rules & Gates
Progressive environments follow a strict promotion flow with named approvers and mandatory checkpoints:

```
Dev (DevSecOps validation)
 ↓
QA (Test Automation Architect verification)
 ↓
Performance Verification (Performance Testing Architect check)
 ↓
Security Sign-Off (Security Architect validation)
 ↓
Accessibility Sign-Off (Accessibility Testing Board confirmation)
 ↓
CAB Approval (Change Advisory Board sign-off)
 ↓
Staging (Platform Architect verification)
 ↓
Blue-Green Validation Window (SRE audit)
 ↓
Production
```
* Every environment transition must be signed off by its named approver; deployments cannot proceed automatedly to production without explicit manual gates.

---

## 4. Supply Chain Security Controls

To protect the software supply chain from external vulnerabilities and compromises, the CI/CD pipeline enforces the following security controls:
* **SBOM Generation:** Every build compile step generates a Software Bill of Materials (SBOM) in SPDX/CycloneDX format, archived permanently in build repositories.
* **Container Image Signing:** Docker images are signed at compilation using **Cosign** (backed by KMS keys). Deployment agents verify signatures on launch, blocking unsigned container images.
* **Dependency Provenance Checks:** Verify package hashes and enforce lockfile validation for third-party libraries (Python pip, Dart pub).
* **Secrets Scanning:** GitGuardian/Trufflehog scans execute on every commit, failing builds if passwords, API keys, or certificates are detected.
* **License Validation:** Scan dependency trees to ensure all libraries match copyleft licensing rules (e.g., blocking unapproved AGPL packages).
* **Artifact Integrity Verification:** Secure hashes are calculated and verified for all deployment packages and client assets prior to deployment.

---

## 5. Blue-Green Deployment Blueprint

Zero-downtime progressive delivery is mandatory for production upgrades, ensuring seamless user transitions and instant rollback capability:
* **Twin Environment Setup:** Production deployment is divided into duplicate environments: **Blue** (active traffic) and **Green** (target release sandbox).
* **Rollout Execution Steps:**
  1. The new container version is deployed to the inactive environment (e.g., Green).
  2. Isolated automated smoke tests and health checks are run against Green's private endpoints.
  3. Upon verification, the API Gateway/Load Balancer switches traffic routing, shifting 100% of public traffic to Green.
  4. The Blue environment remains active in a standby state for a **30-minute validation window**.
  5. **Automated Rollback:** If anomaly alerts (e.g., HTTP 5xx errors, P99 latency spikes, or Sentry error exceptions) trigger, the load balancer instantly redirects all public traffic back to Blue.

### Rollback Compatibility Matrix
To preserve blue-green safety, rollbacks are handled per component according to this matrix:

| Component | Rollback Time | Strategy | Description |
| :--- | :--- | :--- | :--- |
| **API Containers** | < 5 min | Traffic Switch | Redirects load balancer traffic back to standby nodes |
| **Frontend Assets** | < 2 min | CDN Version Swap | Redirects CDN route configurations to previous stable release tag |
| **Database Schema** | Multi-release | Expand → Contract | Zero destructive migrations; rollback via forward-only schema contract modifications |
| **Feature Flags** | Instant | Toggle | Disable new features at runtime without redeploying code |
| **Secrets** | Immediate | Version Restore | Doppler/Vault rollback to previous version metadata |
| **Infrastructure** | IaC Redeploy | Terraform | Provision previous environment state configuration via Terraform apply |

---

## 6. Environment Strategy & Data Isolation

To prevent development activity from impacting production configurations or exposing customer records:

| Environment | Purpose | Database Strategy | Data Classification |
| :--- | :--- | :--- | :--- |
| **Local** | Developer workstation development | Isolated local Docker containers | Seed data / Developer generated |
| **Dev** | Feature integration and sandbox | Shared development database | Anonymized synthetic fixtures |
| **QA** | Automated QA and contract testing | Automated reset database | Automated test data (Pact) |
| **Staging** | Mirror of production configuration | Isolated Staging Database | Anonymized production-scale data |
| **Production**| Live customer traffic | Master-Replica SQL Cluster | Encrypted Live PII Data |

* **Zero Data Sharing:** Sharing databases or Redis instances across different environments is strictly prohibited.
* **Production Data Lockdown:** Under no circumstances shall live production database snapshots be restored or loaded into non-production environments. Staging and QA must use synthetic datasets and seed data.

---

## 7. Secrets Management Policy

* **No Static Credentials:** Committing `.env` configuration files, hardcoding passwords, or storing keys inside container images is strictly prohibited.
* **Runtime Injection:** All database passwords, API credentials, and cryptographic keys are managed securely in **Doppler** (or HashiCorp Vault) and injected into container runtimes as environment variables on startup.
* **Automatic Rotation:** Production database credentials and external API tokens are rotated automatically every 90 days.
* **Least Privilege Scoping:** Access permissions are scoped strictly per namespace. Staging container environments have no access to production Doppler secret scopes.

---

## 8. CI/CD Quality Gates Matrix

The automated deployment pipeline blocks executions (`DEPLOYMENT = BLOCKED`) if any of the following quality gates fail:

| Quality Gate | Scanning Tool | Target Threshold |
| :--- | :--- | :--- |
| **Unit Tests** | `pytest` / Dart test | 100% pass rate |
| **Integration Tests**| Integration suite | 100% pass rate |
| **Contract Tests** | Pact / Schemathesis | 100% compatibility |
| **SAST** | Bandit / SonarQube | Zero critical/high vulnerabilities |
| **SCA** | Safety / Trivy | Zero known CVEs in libraries |
| **Secrets Detection**| GitGuardian / Trufflehog| Zero detected credentials in commits |
| **Performance Tests**| `k6` | P95 latency <300ms |
| **Accessibility** | Axe / Flutter Accessibility| 100% WCAG 2.2 AA validation |
| **Container Scanning**| Trivy / Grype | Zero critical vulnerabilities |
| **Smoke Tests** | Custom endpoint checks | 100% pass on deployment |
| **Migration Check** | Alembic validation | Successful forward execution |

*Gate overrides are blocked unless explicitly reviewed and signed off by the Change Advisory Board (CAB).*

---

## 9. Observability Before Traffic Shifting

Before switching load balancer routing to a newly deployed environment, the target environment must pass a mandatory observability verification checklist:
* **Metrics Active:** OpenTelemetry collectors must be actively transmitting CPU, memory, and application metrics to Prometheus.
* **Log Flowing:** Structured JSON application logs must be successfully writing to the central logging database.
* **Traces Registering:** Active trace spans must be visible in Jaeger/Tempo.
* **Alerts Validated:** All production SLO alert rules must be active and registered.
* **Health Endpoints Passing:** The `/health/ready` endpoint must return `HTTP 200 OK` for all PostgreSQL, Redis, and RabbitMQ dependencies.

---

## 10. Disaster Recovery Integration

The deployment strategy coordinates directly with the Disaster Recovery (DR) requirements:
* **SLO Alignment:** Supports **RTO < 1 hour** and **RPO < 15 minutes**.
* **Replication Rules:** Automated deployments configure the database cluster to maintain streaming replicas in different geographic availability zones.
* **Continuous Backups:** WAL files are archived continuously to geo-redundant storage.
* **Rollback Recovery:** In the event of a deployment failure, the blue-green rollback is executed at the DNS/Load Balancer level in under 5 minutes.

---

## 11. Deployment Ownership Matrix

To eliminate ambiguity and define clear operational accountability, deployment domains are mapped as follows:

| Deployment Domain | Responsible Owner Role |
| :--- | :--- |
| **CI Pipelines** | DevSecOps Architect |
| **Containers** | Platform Architect |
| **Release Promotion** | Release Governance Board |
| **Rollback Procedures**| Site Reliability Architect (SRE) |
| **Secrets** | Security Architect |
| **Infrastructure** | Infrastructure Architect |
| **Database Migrations**| Database Architect |
| **CAB Approval** | Change Advisory Board (CAB) |

---

## 12. Deployment Decision Record (DDR) Policy

* Every future deployment modification or operational pipeline adjustment requires a documented **Deployment Decision Record (DDR)** inside the repository (`docs/ddr/`).
* Change Advisory Board (CAB) approval is mandatory for all DDR modifications.
* **Mandatory Initial DDR References:**
  * **DDR-001:** Docker First Strategy.
  * **DDR-002:** No Kubernetes in Phase 1.
  * **DDR-003:** Blue-Green Rollout Model.
  * **DDR-004:** Managed Services Preference.
  * **DDR-005:** GitOps Enforcement.

---

## 13. Feature Flag Governance & Progressive Delivery

* **Deployment != Release:** Deploying code to production does not automatically expose features to users. All new capabilities must be hidden behind feature flags.
* **Supported Feature Flag Categories:**
  * **Feature Flags:** Decouple code deployment from functional launch schedules.
  * **Kill Switches:** Operational flags configured to instantly disable malfunctioning integrations.
  * **Dark Launches:** Expose code silently in production using backchannel traffic queries to run validation checks before functional launch.
  * **Emergency Disabling:** Global switch controls to shut down features during major system anomalies.
  * **Regional Rollouts:** Progressive feature activation by geography.
* **Feature Flag Ownership:**
  * **Product Owner** (holds ultimate authority over feature exposure status).
  * **Change Advisory Board (CAB)** (governs operational and emergency flags).
  * **Release Governance Board** (coordinates progressive launch schedules).

---

## 14. Production Access & Emergency Controls

To prevent untracked updates and ensure complete accountability:
* **Prohibited Production Actions:**
  * Direct SSH access to running containers or databases.
  * Direct `kubectl` container orchestration access.
  * Manual database query executions or column updates.
  * Execution of unverified hotfix containers in production.
  * Direct console configuration changes in cloud provider web interfaces.
  * Sharing administrative credentials or access tokens.
* **Emergency Break-Glass Procedures:**
  * **Two-Person Approval:** Activating break-glass controls requires explicit approval from two members of the Change Advisory Board.
  * **Full Audit Logging:** All emergency terminal commands, query logs, and network operations are logged automatically to an immutable audit record database.
  * **Automatic Revocation:** Elevated access tokens expire and are automatically revoked after **60 minutes**.
  * **Mandatory Postmortem:** A comprehensive postmortem incident report must be generated within 24 hours of break-glass usage.

---

## 15. Deployment SLO Matrix

To ensure progressive delivery safety, the SRE and Platform teams monitor and enforce the following deployment Service Level Objectives (SLOs):

| SLA Metric | Target Objective | Definition |
| :--- | :--- | :--- |
| **Deployment Success Rate** | >99% | Percentage of deployments that complete successfully without triggers |
| **Rollback Completion** | < 5 minutes | Time to revert load-balancer traffic back to previous stable standby node |
| **Mean Recovery Time (MRTR)** | < 30 minutes | Time required to resolve a post-deployment system incident |
| **Failed Release Detection** | < 2 minutes | Automated anomaly detection triggers to identify faulty releases |
| **Health Verification** | < 60 seconds | Execution time of automated `/health/ready` check validations |
| **Observability Warm-up** | < 2 minutes | Time for newly routed container instances to start exporting telemetry signals |

---

## 16. Institutional Principle

> **Core Philosophy:**  
> A deployment is the physical manifestation of our architecture. How we ship code determines the stability of the platform. Treat deployment pipelines as immutable, automated, and secure paths.

**Build once. Evolve forever.**

🙏 श्री गणेशाय नमः
