# SEC-022: Cloud Security Baseline

## 1. Objective
To establish the non-negotiable security requirements for the Phase 4.4 Cloud Runtime (FastAPI/PostgreSQL), aligning with OWASP ASVS and MASVS principles.

## 2. Infrastructure Constraints
* **TLS Everywhere**: No unencrypted traffic is allowed, even internally within the VPC between microservices or databases.
* **No Public Databases**: PostgreSQL and Redis must reside in private subnets, accessible only by the FastAPI application tier.
* **Zero Trust**: The backend must treat every incoming payload as hostile, validating schema structure, UUID formats, and constraints before processing.

## 3. Data at Rest
* Database volumes must be encrypted using provider-managed keys (e.g., AWS KMS, GCP KMS).
* Highly sensitive fields (if any exist) must be encrypted at the application layer before insertion into PostgreSQL.
