# LifeCircle OS — Infrastructure Architecture Specification

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** Infrastructure Architect
* **Review Board:** Executive Architecture Board, Security & Privacy Board, Reliability & Platform Board, Quality Engineering Board, UX & Human Factors Board, Long-Term Governance Board
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026

---

## Multi-Role Review Status

### Participating Roles
* **Chief Solution Architect:** APPROVED (Validates logical partitions support bounded-context schema separation).
* **Enterprise Architect:** APPROVED (Ensures infrastructural standardization aligns with long-term cost and cloud-portability targets).
* **Principal Mobile Architect:** APPROVED (Confirms that network endpoints and certificates configuration supports client trust boundaries).
* **Backend Architect:** APPROVED (Confirms that container computing allocations and database sizing meets backend SLAs).
* **Domain Architect:** APPROVED (Ensures the infrastructure blueprint holds zero business logic or domain-level definitions).
* **API Governance Architect:** APPROVED (Validates that Edge Load Balancer, routing VPCs, and public subnets align with versioning API rules).
* **Integration Architect:** APPROVED (Validates that RabbitMQ clustered nodes are configured with appropriate networking routes and auto-recovery).
* **Security Architect:** APPROVED (Enforces checkov/tfsec scanning, IAM role assumption, VPC isolation, and break-glass procedures).
* **Privacy Architect:** APPROVED (Ensures environment databases are logically and physically isolated to block PII leaks).
* **Identity Architect:** APPROVED (Validates IAM configurations, short-lived tokens, role assumption constraints, and MFA enforcements).
* **DevSecOps Architect:** APPROVED (Confirms that Terraform linting, SAST scanning, and OPA policies block pipelines upon failure).
* **Cryptography Reviewer:** APPROVED (Confirms that KMS encryption-at-rest keys, TLS 1.3 cert configurations, and DNS certificate rotation checks are correct).
* **Compliance Officer:** APPROVED (Validates that infrastructure deployments and break-glass sessions generate immutable audit logs).
* **Observability Architect:** APPROVED (Confirms export configurations for connection pools and VMs to OpenTelemetry).
* **Site Reliability Architect (SRE):** APPROVED (Validates infrastructure SLOs, provisioning times, and auto-rollback thresholds).
* **Disaster Recovery Board:** APPROVED (Confirms database replicas failover and cross-region WAL backup configurations meet RTO/RPO targets).
* **Platform Architect:** APPROVED (Validates Docker container compute footprints and pgBouncer container topologies).
* **Infrastructure Architect:** APPROVED (Validates declarative IaC module layouts, remote state locking, and agnostic philosophy).
* **Release Governance Board:** APPROVED (Enforces GitOps progressive promotion gates for environment state changes).
* **Chief QA Architect:** APPROVED (Ensures testing databases are isolated in dedicated subnets and seed files are loaded automatically).
* **Test Automation Architect:** APPROVED (Confirms QA subnet parameters are correct for isolated automated verification runs).
* **Performance Testing Architect:** APPROVED (Enforces VM sizing, load testing capacity allocations, and database cluster size configurations).
* **Security Testing Board:** APPROVED (Validates networking security group vulnerability checks).
* **Mutation Testing Board:** APPROVED (Ensures mutation testing frameworks check pipeline rollback paths).
* **Contract Testing Board:** APPROVED (Confirms contract validation dataset networks are completely isolated).
* **Test Data Governance Board:** APPROVED (Confirms seed dataset storage is isolated from live database instances).
* **UX Guardian:** APPROVED WITH CONDITIONS (Ensures network infrastructure performance avoids visual delays for clients).
* **Design System Architect:** APPROVED WITH CONDITIONS (Confirms that assets distribution CDN layout is isolated from API traffic routing).
* **Elder Experience Specialist:** APPROVED WITH CONDITIONS (Ensures DNS and certificate operations preserve elder-mode voice channels integrity).
* **Localization Architect:** APPROVED (Validates regional edge caching setups).
* **Human Factors Reviewer:** APPROVED (Ensures low round-trip network times at load balancers).
* **Legacy Governance Board:** APPROVED (Enforces declarative, clean Terraform structure, banning raw scripts).
* **Documentation Governance Board:** APPROVED (Ensures infrastructure playbooks are version-controlled in Git).
* **Dependency Governance Board:** APPROVED (Validates dependency verification for external Terraform modules).
* **Open Source Governance Board:** APPROVED (Confirms OpenTofu and open-source infrastructure tools compliance).
* **Financial Sustainability Board:** APPROVED (Enforces strict tagging standards, budget alerts, and monthly reviews).
* **Change Advisory Board (CAB):** APPROVED (Validates break-glass permissions and IDR requirements).

### Abstained Roles
* **Mobile Testing Architect:** ABSTAINED. Reason: Mobile widget test configurations run locally or on client test runners, not cloud VM providers.
* **Accessibility Testing Board:** ABSTAINED. Reason: Accessibility reader checks are client-side only.

---

## 1. Infrastructure Philosophy

To establish a multi-decade operational model that prioritizes predictability, repeatability, and security:
* **Cloud Provider Agnostic:** Avoid provider lock-in by using standardized virtual machines, basic networking blocks, and standardized database configurations. Decouple configurations so that deployments can move from AWS to GCP or on-premise without rewriting the application layers.
* **Immutable Infrastructure:** Once provisioned, infrastructure components are never modified in place. Operational configurations are declared in code, and changes require tearing down old structures and launching new, versioned ones.
* **IaC First:** All resources must be declared in Infrastructure as Code. Manual setup ("ClickOps") is strictly prohibited.
* **No Snowflake Servers:** All servers run standardized, identical base images. Individual customizations are prohibited.
* **No Shared Environments:** Dev, QA, Staging, and Production operate in completely isolated virtual private networks (VPCs) with zero shared resources.
* **No Manual Recovery Procedures:** All recovery steps, database failovers, and environment re-provisioning must be executed via automated code paths.

---

## 2. Infrastructure Ownership & RACI

### Infrastructure Ownership Matrix
To prevent ambiguous responsibility boundaries, the ownership of infrastructure elements is defined as follows:

| Infrastructure Domain | Owner Role |
| :--- | :--- |
| **Networking & VPC** | Infrastructure Architect |
| **DNS Routing** | Platform Architect |
| **Certificates (TLS)** | Security Architect |
| **Terraform Modules** | DevSecOps Architect |
| **State Management** | Platform Architect |
| **IAM & Role Policies** | Identity Architect |
| **Monitoring & Metrics** | Observability Architect |
| **Disaster Recovery** | Disaster Recovery Board |
| **Cost Controls** | Financial Sustainability Board |
| **Production Promotion** | Change Advisory Board (CAB) |

### Infrastructure RACI Matrix
To establish definitive operational accountability, the RACI (Responsible, Accountable, Consulted, Informed) rules are defined as follows:

| Activity | Responsible (R) | Accountable (A) | Consulted (C) | Informed (I) |
| :--- | :--- | :--- | :--- | :--- |
| **Terraform Modules** | DevSecOps Architect | Platform Architect | Security Architect | Change Advisory Board (CAB) |
| **IAM Policies** | Identity Architect | Security Architect | Compliance Officer | Site Reliability Architect (SRE) |
| **Network Design** | Infrastructure Architect | Enterprise Architect | Security Architect | Change Advisory Board (CAB) |
| **DR Environments** | Disaster Recovery Board | Site Reliability Architect (SRE) | Platform Architect | Founder/CEO |
| **Cost Reviews** | Financial Sustainability Board | Enterprise Architect | Platform Architect | Change Advisory Board (CAB) |

---

## 3. Terraform/OpenTofu Governance

* **Remote State:** Terraform state files must be stored in a secure cloud bucket (e.g., S3/GCS) rather than local systems.
* **State Locking:** Mandatory state locking (e.g., via DynamoDB or GCS native lock) prevents concurrent executions and state corruption.
* **Version Pinning:** Docker image tags, Terraform provider versions, and tool versions must be pinned to exact SHA256 digests or versions.
* **Module Versioning:** Custom terraform modules are maintained in separate version-controlled repositories and referenced via semantic version tags (`?ref=v1.2.0`).
* **Environment Isolation:** Separate state configurations exist for each environment (`local`, `dev`, `qa`, `staging`, `production`), stored in isolated storage locations.
* **Policy-as-Code:** Pipeline runs must execute automated compliance checks before applying changes.

### State Management & Recovery Matrix
To ensure the durability of our infrastructure source of truth:

| Item | Requirement |
| :--- | :--- |
| **State Backend** | Managed Remote Storage (S3 with KMS or GCP Storage Bucket) |
| **Encryption** | AES-256 (KMS Customer Managed Key) |
| **Versioning** | Mandatory (Object versioning enabled) |
| **State Locking** | Mandatory (DynamoDB or native object locking) |
| **Backup Frequency** | Daily replication to isolated recovery bucket |
| **Restore Verification** | Quarterly recovery drill validations |
| **Manual Editing** | Prohibited (Command-line updates locked) |

* **State Modification Operations:** Executing `terraform state rm`, `terraform import`, or `terraform state mv` is strictly restricted and requires:
  * Change Advisory Board (CAB) approval.
  * Platform Architect sign-off.
  * Complete, non-repudiable audit logging of execution.

---

## 4. Infrastructure Module Standards

All infrastructure templates are modularized under the following directory layout:
```
infra/
├── modules/
│   ├── networking/      # VPC, subnets, NAT, IGW
│   ├── database/        # PostgreSQL RDS, pgBouncer
│   ├── observability/   # OpenTelemetry collectors, Prometheus config
│   ├── security/        # IAM roles, KMS keys, WAF rules
│   ├── compute/         # ECS Fargate / Cloud Run configurations
│   └── messaging/       # RabbitMQ cluster configurations
│
└── environments/
    ├── dev/             # Environment configuration (Dev)
    ├── qa/              # Environment configuration (QA)
    ├── staging/         # Environment configuration (Staging)
    └── production/      # Environment configuration (Production)
```

* **Module Duplication Policy:** Cross-environment code copy-pasting is strictly prohibited. Shared modules are utilized.
* **No Inline IAM Policies:** Permissions are declared as independent, auditable resources linked to specific service accounts.
* **No Hardcoded Secrets:** Variables must only declare references to KMS key configurations or secrets providers (Doppler/Vault) resolved at runtime.

---

## 5. VPC Network Architecture & Trust Boundaries

Network design implements strict zero-trust boundaries:
* **Public Subnets:** Contain the Edge Load Balancer, API Gateway, and Web Application Firewall (WAF). Public subnets are the only modules exposed directly to the public internet.
* **Private Subnets:** Hold FastAPI containers, Redis cache clusters, and RabbitMQ message brokers. These subnets have no direct route to the internet; outbound traffic flows exclusively through NAT Gateways.
* **Isolated Database Subnets:** PostgreSQL RDS clusters reside inside dedicated private database subnets with routing limited to pgBouncer proxies.
* **Bastionless Operations:** Bastion hosts are prohibited. Operational access to private database logs or cluster metrics must go through authenticated private API services.
* **Service-to-Service Authentication:** Services communicate using TLS and request-level authentication. Network layout alone does not establish trust.

### Network Trust Boundaries & Zones
The VPC implements strict zone isolation following this network path:

```
Internet
   ↓
WAF (Web Application Firewall validation)
   ↓
API Gateway (Ingress proxy)
   ↓
Public Subnets (Load Balancers only)
   ↓
Private Application Subnets (FastAPI containers, Redis, RabbitMQ)
   ↓
Private Data Subnets (PostgreSQL instances)
```

* **Security Rules:**
  * No database instances may reside in public networks.
  * No direct application-to-database internet exposure (routing must go through pgBouncer proxies inside private subnets).
  * No east-west trust by default (services in the same subnet must authorize request tokens).
  * Service identities are mandatory.
  * Mutual TLS (mTLS) authentication is preferred for all private container-to-container calls.

---

## 6. IAM Governance & Least Privilege

* **Least Privilege:** Users and service containers are assigned only the permissions required to execute their specific roles.
* **Short-Lived Credentials:** Access to cloud resources utilizes temporary tokens. Permanent keys or long-lived API tokens are prohibited.
* **No Long-Lived Access Keys:** Static access keys are blocked. Service roles are assumed via IAM roles.
* **Role Assumption:** Containers and developers assume specific roles with session-level durations.
* **Break Glass Procedures:** Activating break-glass admin roles requires two-person approval from the Change Advisory Board (CAB), generating full audit logs, and automatically revokes after 60 minutes.
* **Quarterly Reviews:** Enforces quarterly review audits to prune inactive roles and credentials.

---

## 7. Infrastructure Security Controls

* **Policy as Code:** OPA (Open Policy Agent) or Sentinel compliance checks run automatically during PR validation.
* **Terraform Scanning:** Pre-apply pipeline validation checks run Checkov and tfsec scans, failing the build if networking gaps (e.g. open port 22) or unencrypted disks are detected.
* **SBOM Validation:** Compares software bill of materials hashes before provisioning external resources.
* **Image Signing:** Verifies signatures of base container images prior to launching VMs.
* **Secrets Detection:** Checks IaC directories for exposed keys before commits are pushed.

---

## 8. Cost Governance & Resource Sizing

* **Tagging Standards:** Every resource must carry mandatory tags: `Environment`, `Owner`, `Project`, and `CostCenter`.
* **Cost Allocation:** Automatic tools group resource costs based on tags.
* **Budget Alerts:** Multi-tier alert thresholds trigger when monthly spending reaches 80% and 90% of budgets.
* **Idle Resource Detection:** Periodic scans detect and prune idle NAT gateways or unused volumes.
* **Reserved Capacity:** Production databases utilize reserved capacity agreements (e.g., AWS Aurora Reserved Instances) to reduce operational compute costs.

---

## 9. Multi-Region Future Readiness

* **Phase 1 (Active):** Single primary region. Managed database services (RDS Multi-AZ). Active-Passive Disaster Recovery: Database backups and WAL logs are continuously mirrored to a secondary region.
* **Phase 3 Vision:** Multi-region active-active database clusters. Global DNS routing (latency-based routing). Cross-region storage replication. Automatic regional failovers.
* **Evolution Compatibility:** V1 networking design and Terraform module boundaries are structured to ensure multi-region additions in later phases do not require a rewrite of the core module files.

---

## 10. Infrastructure Decision Records (IDRs)

Infrastructure changes require documented **IDRs** inside the repository (`docs/idr/`). All IDR rollouts must be validated by the CAB.
* **IDR-001:** Cloud Provider Selection (Standardized on cloud-agnostic OCI containers).
* **IDR-002:** Docker First (Compose for Dev/QA; managed runtimes for Staging/Prod).
* **IDR-003:** No Kubernetes in Phase 1 (To limit early operational overhead).
* **IDR-004:** Terraform Standardization (Declarative IaC with remote state locking).
* **IDR-005:** Managed Database Policy (PostgreSQL RDS with Multi-AZ replication).
* **IDR-006:** Single Region Initial Deployment (Active-passive DR with cross-region WAL logs mirroring).

---

## 11. Infrastructure SLO Matrix

The SRE team tracks and enforces the following infrastructure SLOs:

| SLA Metric | Target SLO | Definition |
| :--- | :--- | :--- |
| **Terraform Apply Success** | >99% | Percentage of automated Terraform runs that apply without syntax or state errors |
| **Environment Provision Time**| < 20 minutes | Time required to provision a complete isolated environment from Git commit |
| **Certificate Rotation Success**| 100% | Success rate of automated TLS/SSL certificate renewals before expiration |
| **DNS Propagation Monitoring**| < 10 minutes | Maximum time for a DNS routing change to propagate globally |
| **DR Environment Boot Time** | < 30 minutes | Time required to stand up a standby replica environment during regional failover |
| **Infrastructure Rollback** | < 15 minutes | Time to revert infrastructure state back to previous Git tag configuration |

---

## 12. Infrastructure Drift Detection Policy

* **Core Rule:** Infrastructure Drift is treated as a critical production defect.
* **Drift Control Framework:**
  
  | Capability | Rule |
  | :--- | :--- |
  | **Drift Detection Frequency** | Daily automated execution |
  | **Terraform Plan Verification** | Weekly pipeline reconciliation |
  | **Emergency Drift Alerts** | Immediate PagerDuty/Sentry notifications |
  | **Manual Changes** | Forbidden (automatically overwritten) |
  | **Auto-Remediation** | Preferred (Terraform apply auto-reconciliation) |
  | **CAB Review** | Mandatory for all drifts exceeding 24 hours |

* **Operational Constraints:**
  * No manual cloud console modifications.
  * No direct API modifications of resources.
  * No emergency hotfix resources.
  * The Terraform/OpenTofu state configuration is the sole source of truth.

---

## 13. Infrastructure Lifecycle Policy

To manage resource expiration and ensure system cleanups:
* **Core Doctrine:** Mutable data, immutable infrastructure.

| Resource Type | Lifecycle Strategy | Description |
| :--- | :--- | :--- |
| **Compute** | Replace | Provision new VMs for every release, tearing down old instances |
| **Containers** | Replace | Blue-green container replacement per GitOps tag |
| **Databases** | Migrate | Database instances persist; schemas migrate via Alembic Expand-Contract |
| **Certificates**| Rotate | Automated renewal and DNS rotation |
| **Secrets** | Rotate | Automated 90-day Doppler/Vault key rotation |
| **State Files** | Preserve | Permanent retention of Terraform state histories |
| **Logs** | Retain | Aggregated structured logs retained in compliance archives |
| **Backups** | Archive | Geo-replicated WAL and database snapshots |

---

## 14. Approved Technology Baseline

All infrastructure resources must be provisioned and managed using the following approved software stack:

* **Infrastructure as Code (IaC):**
  * Terraform (Active V1)
  * OpenTofu (Validated for future compatibility)
* **Policy-as-Code Engine:**
  * Open Policy Agent (OPA)
  * Sentinel
* **Security & Quality Scanning:**
  * Checkov (Static analysis)
  * tfsec / Trivy (Vulnerability checking)
  * TFLint (Linter validation)
  * GitGuardian (Secrets validation)
* **Container Runtimes:**
  * Docker (Local development)
  * OCI-compliant container images (Staging & Production)
* **Compute Platforms:**
  * AWS ECS Fargate or GCP Cloud Run
* *Unapproved tools are blocked at the CI/CD pipeline gate and require a formal Infrastructure Decision Record (IDR) and CAB approval.*

---

## 15. Institutional Principle

> **Core Philosophy:**  
> Infrastructure is code. Treat cloud resource configuration with the same rigor, version control, security reviews, and testing gates as application software.

**Build once. Evolve forever.**

🙏 श्री गणेशाय नमः
