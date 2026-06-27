# LifeCircle OS — Operations Runbook

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** Site Reliability Architect (SRE)
* **Review Board:** Executive Architecture Board, Security & Privacy Board, Reliability & Platform Board, Quality Engineering Board, UX & Human Factors Board, Long-Term Governance Board
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026

---

## Multi-Role Review Status

### Participating Roles
* **Chief Solution Architect:** APPROVED (Confirms operational command model isolates software layers from incident decision overhead).
* **Enterprise Architect:** APPROVED (Ensures the operations model enforces progressive automation paths minimizing manual interventions).
* **Principal Mobile Architect:** APPROVED (Validates client-side deployment and rollback playbooks, ensuring crash logs flow cleanly during outages).
* **Backend Architect:** APPROVED (Confirms that database failure, redis failure, and API latency runbooks are technically correct).
* **Domain Architect:** APPROVED (Ensures operations runbooks target infrastructure recovery without altering core business rules).
* **API Governance Architect:** APPROVED (Validates that API gateway and traffic switch runbooks do not violate path routing specifications).
* **Integration Architect:** APPROVED (Confirms RabbitMQ broker recovery and event queue backlog runbooks).
* **Security Architect:** APPROVED (Enforces secrets rotation, break-glass security logs, and incident security procedures).
* **Privacy Architect:** APPROVED (Ensures postmortem logs and incident records are sanitized of PII and protected data).
* **Identity Architect:** APPROVED (Validates IAM break-glass emergency procedures, two-person reviews, and role access rotation checks).
* **DevSecOps Architect:** APPROVED (Confirms automated deployment rollback triggers and CI quality checks align with operational SLOs).
* **Cryptography Reviewer:** APPROVED (Validates automated certificate rotation processes and key recovery options).
* **Compliance Officer:** APPROVED (Enforces audit logging rules and regulatory notice compliance during data breaches).
* **Observability Architect:** APPROVED (Confirms Prometheus metrics, log alerts, and Jaeger trace setups support incident detection within <2 minutes).
* **Site Reliability Architect (SRE):** APPROVED (Validates incident command mappings, severity matrix targets, and maximum consecutive on-call shifts).
* **Disaster Recovery Board:** APPROVED (Confirms that DR failover recovery playbooks align with the 1-hour RTO and 15-minute RPO targets).
* **Platform Architect:** APPROVED (Validates container sizing modifications, pgBouncer pool tuning, and host CPU saturation targets).
* **Infrastructure Architect:** APPROVED (Ensures Terraform IaC re-provisioning steps and NAT/VPC configurations are documented in outage runbooks).
* **Release Governance Board:** APPROVED (Enforces GitOps promotion checks and rollback release rules).
* **Chief QA Architect:** APPROVED (Validates automated deployment verification and verification testing scripts).
* **Test Automation Architect:** APPROVED (Confirms QA staging environments can run integration tests immediately after environment rollbacks).
* **Performance Testing Architect:** APPROVED (Validates load testing steps for checking system recovery capacity).
* **Security Testing Board:** APPROVED (Enforces automated penetration and vulnerability scan runs during major incident resolution).
* **Mutation Testing Board:** APPROVED (Ensures pipeline checks verify automated rollback health triggers).
* **Contract Testing Board:** APPROVED (Confirms contract checks block faulty rollback environments).
* **Test Data Governance Board:** APPROVED (Ensures non-production seed datasets remain intact during environment rebuilds).
* **UX Guardian:** APPROVED WITH CONDITIONS (Ensures incident communications templates represent clear status notices for users).
* **Design System Architect:** APPROVED (Confirms status page layouts match visual assets baseline guidelines).
* **Elder Experience Specialist:** APPROVED WITH CONDITIONS (Enforces emergency voice guidance scripts availability during outages).
* **Localization Architect:** APPROVED (Validates multi-lingual outage announcements templates).
* **Human Factors Reviewer:** APPROVED (Ensures on-call tooling interfaces reduce cognitive load during high-stress P0 incidents).
* **Legacy Governance Board:** APPROVED (Confirms runbooks contain clear, unambiguous instructions, free of magic).
* **Documentation Governance Board:** APPROVED (Ensures all operations playbooks and postmortems are versioned in Git).
* **Dependency Governance Board:** APPROVED (Ensures third-party operations alert dependencies are maintained).
* **Open Source Governance Board:** APPROVED (Confirms operations monitor tools compliance).
* **Financial Sustainability Board:** APPROVED (Validates cost reviewed budgets constraints during scale events).
* **Change Advisory Board (CAB):** APPROVED (Validates RDR governance and break-glass procedures approval rules).

### Abstained Roles
* **Mobile Testing Architect:** ABSTAINED. Reason: On-call rotations and server-side runbooks do not coordinate client widget testing pipelines.
* **Accessibility Testing Board:** ABSTAINED. Reason: Accessibility WCAG 2.2 AA testing checks are run during PR pipelines, not operations command loops.

---

## 1. Operations Philosophy

To build a multi-generational, trusted, and durable family institution, operational actions at LifeCircle OS comply with the following core principles:
* **Operations Over Heroics:** Incident resolution must rely on structured, documented playbooks and automated alert escalations rather than individual heroics or tribal memory.
* **Runbooks Over Tribal Knowledge:** No operational process may depend on a specific engineer being awake, available, or remembering undocumented procedures.
* **Automation Over Repetition:** Repetitive manual operations (toil) must be systematically converted into code validations or scheduled jobs to minimize human configuration errors.
* **Blameless Learning Over Blame:** Incidents are treated as opportunities to understand system vulnerabilities. Postmortems analyze systemic failures and process gaps, avoiding individual finger-pointing.
* **Recovery Over Perfection:** The immediate goal of incident triage is to restore services safely to users, decoupling mitigation from long-term root-cause architecture changes.

---

## 2. Incident Severity Matrix

Operational alerts automatically evaluate metrics against the following severity levels to trigger response paths:

| Severity | Description | Max Acknowledge (MTTA) | Max Resolve (MTTR) Target | Automated Escalation Path |
| :--- | :--- | :--- | :--- | :--- |
| **P0** | **Total Platform Outage:** Core APIs completely unresponsive, PostgreSQL cluster corrupt, or key credentials compromised. | < 5 minutes | < 30 minutes | Pages SRE Primary, SRE Secondary, and Incident Commander simultaneously. Auto-updates public status page. |
| **P1** | **Critical Functionality Impaired:** Medicine sync failing, financial payment ledger blocked, or local database migrations failing. | < 10 minutes | < 1 hour | Pages SRE Primary. Escalates to Secondary and Tech Lead if unacknowledged in 10 minutes. |
| **P2** | **Major Degradation:** P99 API latency exceeds 1000ms, push notification queues backing up, or minor telemetry packet drops. | < 30 minutes | < 4 hours | Generates high-priority ticketing notifications in communication channels; alerts SRE Primary. |
| **P3** | **Minor Operational Issue:** Administrator dashboard latency, seed data generation error, or documentation typos. | < 4 hours | < 24 hours | Standard issue registry queue creation. |

---

## 3. Incident Command Structure

During any P0 or P1 incident, the organization immediately implements the Incident Command system. Authority is delegated to active command roles to eliminate coordination overhead and decision paralysis:
* **Incident Commander (IC):** Holds single-point decision authority for the duration of the incident. Owns the response strategy, delegates diagnostics, coordinates stakeholders, and signs off on mitigation.
* **Technical Lead (TL):** Owns operational troubleshooting, diagnostic queries, logs analysis, and applying mitigation scripts. Coordinates directly with system developers.
* **Communications Lead (CL):** Manages internal updates for stakeholder teams and posts announcements to public family dashboards and status pages.
* **Scribe:** Formulates the chronological timeline of events, commands executed, diagnostic outputs, and team agreements inside the dedicated incident room.
* **Executive Liaison:** Manages information flow for senior leadership, keeping the Incident Commander free from executive distraction.

### Incident Communications Matrix
To reduce operational noise and establish clear alignment during major incidents:

| Audience | Owner | Frequency |
| :--- | :--- | :--- |
| **Engineering** | Incident Commander | Every 15 minutes or upon significant status transition |
| **Executives** | Executive Liaison | Every 30 minutes |
| **Customers** | Communications Lead | As required (via public status pages/dashboards) |
| **CAB** | Scribe | Post-incident (within 24 hours of resolution) |
| **Founder Office**| Executive Liaison | P0/P1 only (immediate notification + active updates) |

---

## 4. Standard Runbooks Manual

### Runbook Validation Policy
* **Core Rule:** Untested runbooks = invalid runbooks.
* **Validation Standards:** Every runbook must define and track the following parameters:
  
  | Attribute | Requirement |
  | :--- | :--- |
  | **Last Tested** | Mandatory (specific date of the last active simulation) |
  | **Next Review** | ≤ 180 days |
  | **Automation Coverage** | Declared percentage |
  | **Owner** | Named SRE role |
  | **Backup Owner** | Named backup role |
  | **Estimated Recovery Time** | Defined (minutes/hours) |

---

### 4.1 Database Failure Recovery
* **Attributes:** Last Tested: June 25, 2026 | Next Review: December 22, 2026 | Automation Coverage: 75% | Owner: Database Architect | Backup Owner: SRE Team | Estimated Recovery Time: 15 minutes
* **Symptoms:** Connection timeouts, pgBouncer returning 503 Service Unavailable, PostgreSQL primary node read-only state.
* **Diagnostics:**
  * Execute `pg_isready -h db_primary_host` to check connection socket states.
  * Query connection pool status inside pgBouncer: `SHOW POOLS;`.
* **Recovery Steps:**
  1. If the primary node is unresponsive for >30 seconds, verify database auto-failover status.
  2. If auto-failover is inactive, execute manual promotion on the secondary streaming replica: `SELECT pg_promote();`.
  3. Modify the private DNS endpoint records to route traffic to the newly promoted primary database node.
  4. Provision a new secondary replica instance via Terraform configurations.

### 4.2 API Latency Spike
* **Attributes:** Last Tested: June 20, 2026 | Next Review: December 17, 2026 | Automation Coverage: 50% | Owner: SRE Team | Backup Owner: Platform Architect | Estimated Recovery Time: 10 minutes
* **Symptoms:** P95 API gateway latencies exceed 300ms, client calls return HTTP 504 timeouts.
* **Diagnostics:**
  * Review container CPU/Memory saturation charts in Grafana dashboards.
  * Audit Jaeger trace records for slow SQL query execution traces using correlation IDs.
* **Recovery Steps:**
  1. Verify pgBouncer pool saturation; increase maximum database client connections if pool exhaustion is confirmed.
  2. Review WAF rate-limiting filters to determine if traffic is driven by a malicious request spike.
  3. Increase container node scaling thresholds on managed runtimes (ECS Fargate/Cloud Run).
  4. If the latency spike maps directly to a recent version release, execute an automated blue-green traffic switch back to the standby Blue environment.

### 4.3 Certificate Expiry
* **Attributes:** Last Tested: June 15, 2026 | Next Review: December 12, 2026 | Automation Coverage: 100% | Owner: Security Architect | Backup Owner: Cryptography Reviewer | Estimated Recovery Time: 5 minutes
* **Symptoms:** SSL/TLS handshake failures, mobile application secure socket calls failing with untrusted certification errors.
* **Diagnostics:**
  * Execute `curl -vI https://api.lifecircle.in` to check certificate chain expiration details.
* **Recovery Steps:**
  1. Execute manual ACME renewal command script: `certbot renew --force-renewal`.
  2. If DNS challenge validation fails, verify Let's Encrypt validation routing parameters.
  3. Push renewed certificate bundles to CDN/Load Balancer.
  4. Confirm TLS chain validity using SSL labs external validation checkers.

### 4.4 Secrets Rotation
* **Attributes:** Last Tested: June 10, 2026 | Next Review: December 07, 2026 | Automation Coverage: 80% | Owner: Security Architect | Backup Owner: Platform Architect | Estimated Recovery Time: 15 minutes
* **Symptoms:** Application container logs return authorization credentials errors, KMS access audits reject requests.
* **Diagnostics:**
  * Review key access logs in KMS auditing panels.
* **Recovery Steps:**
  1. Update target credentials/key records inside Doppler/Vault namespaces.
  2. Run a rolling update deployment on container clusters to inject the updated environment configurations.
  3. Verify database logs to confirm new container tasks authenticate successfully.
  4. Revoke access permissions for the deprecated secret version in Doppler/Vault.

### 4.5 Deployment Rollback
* **Attributes:** Last Tested: June 24, 2026 | Next Review: December 21, 2026 | Automation Coverage: 90% | Owner: SRE Team | Backup Owner: Release Governance Board | Estimated Recovery Time: 5 minutes
* **Symptoms:** High HTTP 5xx error spikes, application crash loops detected post-deployment.
* **Diagnostics:**
  * Review Sentry dashboards for recent exception traces.
* **Recovery Steps:**
  1. Direct the API Gateway/Load Balancer routing configuration to redirect 100% of public traffic back to the standby Blue environment.
  2. Terminate the active container instances in the Green environment.
  3. Run deployment health probes against Blue to confirm latency targets (<300ms) are satisfied.
  4. Revert the target repository Git deployment version tag.

### 4.6 Queue Backlog
* **Attributes:** Last Tested: June 12, 2026 | Next Review: December 09, 2026 | Automation Coverage: 60% | Owner: Integration Architect | Backup Owner: SRE Team | Estimated Recovery Time: 20 minutes
* **Symptoms:** Medicine log synchronization delays exceed 5 seconds, RabbitMQ dashboards indicate high unacknowledged message queues.
* **Diagnostics:**
  * Review RabbitMQ connection statistics and channel consumer counts.
* **Recovery Steps:**
  1. Scale worker container instances horizontally to increase event consumption throughput.
  2. Isolate poison-pill messages (causing exceptions) and route them to the Dead Letter Queue (DLQ).
  3. Tune RabbitMQ consumer prefetch thresholds to optimize network packet deliveries.

### 4.7 Redis Failure
* **Attributes:** Last Tested: June 18, 2026 | Next Review: December 15, 2026 | Automation Coverage: 70% | Owner: Platform Architect | Backup Owner: SRE Team | Estimated Recovery Time: 10 minutes
* **Symptoms:** Client session lookup validations failing, token ratelimiters returning HTTP 500 errors.
* **Diagnostics:**
  * Execute `redis-cli ping` to confirm instance responsiveness.
* **Recovery Steps:**
  1. If primary Redis node is unresponsive, trigger failover promotion of the secondary replica.
  2. If the entire Redis cluster state is corrupt, flush cached cache keys and restart.
  3. Enable temporary pass-through on session validations, routing authorization directly to PostgreSQL until Redis is healthy.

### 4.8 Notification Failure
* **Attributes:** Last Tested: June 08, 2026 | Next Review: December 05, 2026 | Automation Coverage: 40% | Owner: Integration Architect | Backup Owner: Security Architect | Estimated Recovery Time: 25 minutes
* **Symptoms:** FCM/APNs push notification integrations fail, family emergency alerts are delayed.
* **Diagnostics:**
  * Check FCM/APNs logs for HTTP 4xx/5xx integration response codes.
* **Recovery Steps:**
  1. Identify if the alert failure is caused by third-party provider outage.
  2. Switch active routing configurations to the secondary SMS/Push provider gateway.
  3. Place unsuccessful notification requests back into the database outbox table for automated retry.

### 4.9 Disk Exhaustion
* **Attributes:** Last Tested: June 05, 2026 | Next Review: December 02, 2026 | Automation Coverage: 30% | Owner: SRE Team | Backup Owner: Platform Architect | Estimated Recovery Time: 30 minutes
* **Symptoms:** PostgreSQL transactions fail to commit, container tasks abort during write operations.
* **Diagnostics:**
  * Run `df -h` to verify storage allocation status.
* **Recovery Steps:**
  1. Clear docker cache files: `docker system prune -a --volumes`.
  2. Archive legacy audit partitions of `audit.audit_logs` older than 12 months to cold storage.
  3. Expand database disk capacity volume allocations inside Terraform templates.

### 4.10 Cloud Region Outage
* **Attributes:** Last Tested: June 01, 2026 | Next Review: November 28, 2026 | Automation Coverage: 50% | Owner: DR Board | Backup Owner: SRE Team | Estimated Recovery Time: 30 minutes
* **Symptoms:** Platform completely unreachable, cloud provider dashboard indicates major regional service disruption.
* **Diagnostics:**
  * Review official cloud status dashboards.
* **Recovery Steps:**
  1. Declare a P0 Disaster Recovery event.
  2. Deploy the complete infrastructure configuration to the secondary recovery region using Terraform templates.
  3. Restore database schemas using Point-in-Time Recovery (PITR) logs up to the last 15-minute RPO mark.
  4. Modify global DNS records to route traffic to the secondary cloud region.

---

## 5. Blameless Postmortem Governance

To continuously improve platform reliability and avoid systemic failures:
* **Blameless Culture:** Postmortem reviews focus strictly on identifying system vulnerabilities, monitoring gaps, and process issues, not blaming individuals.
* **Action Items Requirements:** Postmortems must generate concrete, actionable work tickets. Every ticket requires:
  * A designated owner.
  * A clear completion deadline.
  * SRE validation checks to confirm resolution.
* **Timeline Gates:** Postmortems must be completed, reviewed, and archived in the Git repository within **5 business days** of the incident.

### Learning Repository Governance
* **Incident History Archive:** Every incident record and blameless postmortem must be structured and archived in Git under:
  `docs/incident-history/YYYY/INC-[ID].md` (e.g. `docs/incident-history/2026/INC-001.md`).
* **Mandatory Postmortem Trigger Matrix:**
  
  | Incident Severity | Postmortem Requirement |
  | :--- | :--- |
  | **P0 / P1 Incidents** | Mandatory blameless postmortem execution and archive |
  | **P2 Incidents** | Optional but highly recommended |
  | **P3 Incidents** | Team discretion |

---

## 6. Operational Automation Policy

To minimize manual operations ("toil"), LifeCircle OS classifies processes by automation requirements:

| Operational Activity | Automation Level | Execution Standard |
| :--- | :--- | :--- |
| **Certificate Rotation** | Fully Automated | Automated ACME renewal scripts |
| **Backups & Snapshots** | Fully Automated | Continuous WAL archiving + daily restore verify checks |
| **Health Checks** | Fully Automated | Automated platform probes executing every 10 seconds |
| **Rollbacks** | Semi-Automated | Triggered via single CLI control after threshold alarm |
| **Incident Creation** | Automated | Automatically registers tickets from monitoring thresholds |
| **Postmortem Templates** | Automated | Automatically pre-populated incident metrics templates |
| **DR Drills** | Scheduled | Scheduled quarterly recovery sandbox provisioning |

### Toil Budget Governance
* **Toil Limits:**
  * Maximum Human Toil: **50%** of SRE engineering capacity.
  * Target Human Toil: **< 30%** of SRE engineering capacity.
  * Strategic Goal: **< 20%** of SRE engineering capacity.
* **Toil Mitigation Rule:**
  * If an operation repeats **3 times** -> document it.
  * If an operation repeats **5 times** -> automate it.
  * If an operation repeats **10 times** -> eliminate manual execution paths completely.

---

## 7. On-Call Governance & Burnout Controls

* **Rotation Structure:** The on-call rotation maintains three tiers: Primary SRE, Secondary SRE, and Escalation Developer.
* **Escalation Policy:** If the Primary SRE fails to acknowledge an alert within 10 minutes, the pager notifies the Secondary SRE, and subsequently the Incident Commander.
* **Shift Constraints:** Engineers cannot serve on-call for more than **7 consecutive days**.
* **Burnout Controls:** A minimum of 14 days off-call is mandatory between rotations. If an on-call engineer spends >4 hours actively triaging P0/P1 events during a shift, they are immediately replaced by the backup responder.
* **Runbook Verification:** Runbook steps must be reviewed and tested for correctness every **180 days** to prevent stale instructions.

---

## 8. Operations RACI Matrix

To ensure clear operational accountability:

| Operational Activity | Responsible (R) | Accountable (A) | Consulted (C) | Informed (I) |
| :--- | :--- | :--- | :--- | :--- |
| **Incident Response** | SRE Team | Incident Commander | Observability Architect | Founder/CEO |
| **Deployments** | Platform Architect | Release Governance Board | Security Architect | Change Advisory Board (CAB) |
| **Rollbacks** | SRE Team | Site Reliability Architect (SRE) | Platform Architect | Change Advisory Board (CAB) |
| **DR Activation** | Disaster Recovery Board | Site Reliability Architect (SRE) | Platform Architect | Founder/CEO |
| **Certificate Rotation**| Security Architect | Security Architect | Cryptography Reviewer | Platform Architect |
| **Security Incidents** | Security Architect | Security Architect | Compliance Officer | Change Advisory Board (CAB) |
| **Database Migrations**| Database Architect | Database Architect | Platform Architect | Change Advisory Board (CAB) |
| **Cost Reviews** | Financial Sustainability Board | Enterprise Architect | Platform Architect | Change Advisory Board (CAB) |
| **Feature Flag Activation**| Release Governance Board | Product Owner | Change Advisory Board (CAB) | SRE Team |

---

## 9. Operational SLO Matrix

Operational metrics are monitored and enforced by the SRE team:

| SLA Metric | Target SLO | Definition |
| :--- | :--- | :--- |
| **Max Time to Acknowledge (MTTA)** | < 10 minutes | Time from alert creation to SRE acknowledgement |
| **Max Time to Resolve (MTTR)** | < 60 minutes | Time from alert creation to service restoration |
| **Runbook Freshness** | < 180 days | Verification window for reviewing runbook steps |
| **Postmortem Completion** | < 5 business days | Time to archive postmortem in Git repositories |
| **DR Drill Success** | 100% | Successful restoration to sandbox during quarterly drills |
| **Certificate Rotation Success** | 100% | Percentage of certificate renewals executed automatically |
| **Backup Verification** | Daily | Automated recovery check validations of snapshots |

---

## 10. Runbook Decision Records (RDRs)

Operational changes require documented **RDRs** inside the repository (`docs/rdr/`). All RDRs must be validated by the CAB.
* **RDR-001:** Incident Management Model (Standardized on Incident Command roles).
* **RDR-002:** Blameless Postmortems (Mandatory blameless audit template).
* **RDR-003:** Automation First Policy (Toil reduction limits and automation targets).
* **RDR-004:** On-Call Governance (Escalation routing rules and burnout controls).
* **RDR-005:** DR Activation Procedures (RTO/RPO target mapping to replication checks).

---

## 11. Operations Readiness Checklist

Before any code deployment or feature release is promoted to the production environment, the following operational requirements must be fully satisfied:

| Requirement | Required Status | Verification Owner |
| :--- | :--- | :--- |
| **Runbooks Tested** | Required (100% verified in staging) | Chief QA Architect |
| **On-call Rotation Active** | Required (rotations configured & active) | SRE Team |
| **Escalation Policies Verified** | Required (alert paths validated) | Site Reliability Architect (SRE) |
| **DR Drill Executed** | Required (quarterly drill verification passed) | Disaster Recovery Board |
| **Backup Restores Verified** | Required (daily checksum restore check complete) | Database Architect |
| **Certificate Rotation Tested** | Required (automatic ACME validation passed) | Security Architect |
| **Incident Templates Created** | Required (alert templates configured in dashboard) | Observability Architect |
| **Feature Flags Operational** | Required (flags integrated and verify flags ready) | Release Governance Board |

* **Operational Doctrine:** If operations cannot support it, engineering cannot ship it.

---

## 12. Institutional Principle

> **Core Philosophy:**  
> The original creators are gone, and future engineers must still operate LifeCircle OS safely in 2050. Maintain clear playbooks, run blameless postmortems, and automate relentlessly.

**Build once. Evolve forever.**

🙏 श्री गणेशाय नमः
