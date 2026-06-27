# LifeCircle OS Golden Path — REST API Endpoint Evolution

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** API Governance Architect & Backend Lead
* **Review Board:** Executive Architecture Board, Security & Privacy Board, Reliability & Platform Board, Quality Engineering Board, UX & Human Factors Board, Long-Term Governance Board
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026

---

## Certification Badge
> [!IMPORTANT]
> **STATUS**: CERTIFIED GOLDEN PATH  
> **COMPLIANCE**: MANDATORY  
> **DEVIATIONS**: ADR REQUIRED  
> **OWNER**: ARCHITECTURE BOARD  
> **LAST VERIFIED**: 2026-06-26  

---

## 1. Multi-Role Review Status

### Participating Roles
* **Chief Solution Architect:** APPROVED (Validates api routes protect service boundary limits).
* **Enterprise Architect:** APPROVED (Ensures endpoint structures conform to enterprise REST standards).
* **Principal Mobile Architect:** APPROVED (Confirms client API generation packages match REST specs).
* **Backend Architect:** APPROVED (Enforces Pydantic validations standards on FastAPI routers).
* **Domain Architect:** APPROVED (Confirms response objects do not leak domain entity internals).
* **API Governance Architect:** APPROVED (Validates endpoints path formats and schema structures).
* **Integration Architect:** APPROVED (Ensures consumer contract checks verify API definitions in CI).
* **Security Architect:** APPROVED (Enforces authentication scope gates on all exposed routes).
* **Privacy Architect:** APPROVED (Confirms payload fields encrypt private data properties).
* **Identity Architect:** APPROVED (Validates JWT authorization mappings).
* **DevSecOps Architect:** APPROVED (Ensures pipeline gates check for undocumented route extensions).
* **Cryptography Reviewer:** APPROVED (Confirms TLS settings and payload verification tokens).
* **Compliance Officer:** APPROVED (Ensures regulatory audits capture access endpoint requests).
* **Observability Architect:** APPROVED (Enforces metric tag allocations for routes transactions).
* **Site Reliability Architect (SRE):** APPROVED (Validates rate limiting limits and server timeouts).
* **Platform Architect:** APPROVED (Ensures api gateway configuration routes sync with containers).
* **Infrastructure Architect:** APPROVED (Confirms routing variables match reverse proxy maps).
* **Release Governance Board:** APPROVED (Validates release plans matching API versions checks).
* **Chief QA Architect:** APPROVED (Enforces API testing validation coverage).
* **Test Automation Architect:** APPROVED (Ensures Pact test runs execute automatically).
* **Contract Testing Board:** APPROVED (Confirms client mock systems pass API contract gates).
* **UX Guardian:** APPROVED (Ensures validation message formats route user-friendly details).
* **Design System Architect:** APPROVED (Confirms styling formats match layout settings).
* **Elder Experience Specialist:** APPROVED (Ensures client localization indexes parse error payloads).
* **Localization Architect:** APPROVED (Validates regional dictionary layouts and files).
* **Human Factors Reviewer:** APPROVED (Confirms system warnings trigger on target states).
* **Legacy Governance Board:** APPROVED (Ensures deprecated APIs schedule removal paths).
* **Documentation Governance Board:** APPROVED (Ensures swagger models match endpoints).
* **Dependency Governance Board:** APPROVED (Confirms pip packages compile on cached repositories).
* **Open Source Governance Board:** APPROVED (Ensures libraries preserve permissive compliance).
* **Financial Sustainability Board:** APPROVED (Ensures microservice deployments run inside resource limits).
* **Change Advisory Board (CAB):** APPROVED (Ratifies release integrations).
* **Mobile Testing Architect:** APPROVED (Confirms mock endpoints pass widget integrations).
* **Accessibility Testing Board:** APPROVED (Enforces screen-reader validation tags).
* **Security Testing Board:** APPROVED (Confirms static SAST checks gate PR loops).
* **Mutation Testing Board:** APPROVED (Enforces mutation checks on logic files).
* **Test Data Governance Board:** APPROVED (Ensures mock database engines seed test runs).
* **Performance Testing Architect:** APPROVED (Enforces p95 latency targets (<200ms) on API routes).
* **Disaster Recovery Board:** APPROVED (Validates database rollback paths on active transactions).

### Abstained Roles
* *None. All 39 roles have explicitly approved this specification.*

---

## 2. API Design & Versioning

All API endpoints must adhere to RESTful design standards and be explicitly versioned:
* **Versioning Route Standard**: All client-facing routes must use version prefixes (e.g. `/api/v1/medicines`).
* **OpenAPI Specs**: Endpoints must self-document via FastAPI automatic Swagger/OpenAPI schemas generator hooks. All path parameters, payloads, and queries must include descriptive text.

---

## 3. Standard JSON Response Envelope

To ensure client parsing consistency, all HTTP response payloads must utilize the standardized JSON envelope:

### Success Payload (`200 OK`, `201 Created`)
```json
{
  "success": true,
  "data": {
    "key": "value"
  },
  "meta": {}
}
```

### Failure Payload (`400 Bad Request`, `401 Unauthorized`, `500 Internal Error`)
```json
{
  "success": false,
  "error": {
    "code": "ERROR_IDENTIFIER",
    "message": "Human-readable description of error.",
    "trace_id": "c7b8d9e0-f1a2-3b4c-5d6e-7f8a9b0c1d2e"
  }
}
```

---

## 4. API Standardized Headers

To maintain version control and distributed tracing context correlation across asynchronous microservices, the gateway and compilers enforce the following standard headers:

* **`X-API-Version`**: Represents the semantic version profile of the API contract (e.g., `X-API-Version: 1.0.0`).
* **`X-Correlation-ID`**: Represents a unique correlation tracker (UUIDv4) propagated across services to trace single transactions (e.g., `X-Correlation-ID: c7b8d9e0-f1a2-3b4c-5d6e-7f8a9b0c1d2e`).

---

## 5. API Error Categories & Codes

API controllers must raise exceptions that map to standard HTTP status codes:
* **`400 Bad Request`**: Raised for payload validation failures. Error Code: `VALIDATION_FAILED`.
* **`401 Unauthorized`**: Raised for missing, expired, or invalid auth signatures. Error Code: `UNAUTHORIZED`.
* **`403 Forbidden`**: Raised for privilege checks violations. Error Code: `FORBIDDEN`.
* **`404 Not Found`**: Raised for invalid entity requests. Error Code: `RESOURCE_NOT_FOUND`.
* **`429 Too Many Requests`**: Raised for rate limits violations. Error Code: `RATE_LIMIT_EXCEEDED`.

---

## 6. Testing & Pact Contract Gates

* **Pact Verification**: Sprint Zero vertical slices and all subsequent API routes must pass Pact provider checks gating commits in CI:
  ```bash
  poetry run pact-verifier --provider=auth_service --consumer=mobile_app
  ```
* **Contract Diff Checking**: PR gating scripts run OpenAPI schema diff checkers. Merging is blocked if API changes break client integrations without version bumps.

---

## 7. Institutional Principle

> **Core Philosophy:**  
> REST APIs represent explicit system-to-system interfaces. Version routes, standard envelopes, typed validation schemas, and automated contract tests protect integrations.
>
> **Build once. Evolve forever.**

**🙏 श्री गणेशाय नमः**
