# LifeCircle OS — API Guidelines

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** API Governance Architect
* **Review Board:** Executive Architecture Board, Security & Privacy Board, Reliability & Platform Board, Quality Engineering Board, UX & Human Factors Board, Long-Term Governance Board
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026

---

## Multi-Role Review Status

### Participating Roles
* **Chief Solution Architect:** APPROVED (Validates DDD bounded contexts mapping to API schemas).
* **Enterprise Architect:** APPROVED (Confirms API lifecycles support long-term compatibility).
* **Principal Mobile Architect:** APPROVED (Ensures payload schemas are easily deserialized by Flutter).
* **Backend Architect:** APPROVED (Validates FastAPI route structure and controller delegation).
* **Domain Architect:** APPROVED (Ensures API schemas remain isolated from pure domain logic).
* **API Governance Architect:** APPROVED (Validates contract boundaries, versioning paths, and schemas).
* **Integration Architect:** APPROVED (Validates synchronization endpoints and outbox JSON payloads).
* **Security Architect:** APPROVED (Validates header encryption, rate limits, and payload validation).
* **Privacy Architect:** APPROVED (Ensures zero personal tracking or metadata leaks in HTTP flows).
* **Identity Architect:** APPROVED (Validates JWT authorization headers and access scopes).
* **DevSecOps Architect:** APPROVED (Validates automated schema contract checks inside PR quality gates).
* **Compliance Officer:** APPROVED (Ensures transit payloads align with DPDP/GDPR notice guidelines).
* **Observability Architect:** APPROVED (Enforces Correlation-ID, Trace-ID, and Audit-ID in request headers).
* **Site Reliability Architect (SRE):** APPROVED (Validates that rate limits align with availability budgets).
* **Release Governance Board:** APPROVED (Ensures path deprecations do not break older client sessions).
* **Chief QA Architect:** APPROVED (Enforces Contract-first testing standards).
* **Test Automation Architect:** APPROVED (Validates mock API client testing frameworks).
* **Contract Testing Board:** APPROVED (Mandates Pact-style verification).
* **UX Guardian:** APPROVED (Validates interaction latency constraints for sync payloads).
* **Localization Architect:** APPROVED (Enforces that error codes map to regional localization resources).
* **Legacy Governance Board:** APPROVED (Ensures contract code is simple, self-documenting, and clean).
* **Documentation Governance Board:** APPROVED (Ensures API specs are versioned and generated as code).
* **Change Advisory Board (CAB):** APPROVED (Validates version transitions and backward compatibility gates).

### Abstained Roles
* **Cryptography Reviewer:** ABSTAINED. Reason: Specific encryption algorithms (AES-256) are defined in Security/Crypto documents; API endpoints handle standard TLS 1.3 transport.
* **Disaster Recovery Board:** ABSTAINED. Reason: No backup snapshotting, WAL journaling, or failover replication operations are defined in this document.
* **Platform Architect:** ABSTAINED. Reason: Host container configurations or server cache states are outside the scope of API path guidelines.
* **Infrastructure Architect:** ABSTAINED. Reason: No Terraform resources, server infrastructure, or networking routers are provisioned by these guidelines.
* **Performance Testing Architect:** ABSTAINED. Reason: Platform load testing (Locust/k6) and stress tests are governed by the Performance Strategy.
* **Mobile Testing Architect:** ABSTAINED. Reason: Frontend widget golden testing is outside the scope of API schemas.
* **Security Testing Board:** ABSTAINED. Reason: DAST and pen-testing protocols are governed by the Security Strategy.
* **Accessibility Testing Board:** ABSTAINED. Reason: Client widget layout WCAG AA checks do not impact HTTP API payloads.
* **Mutation Testing Board:** ABSTAINED. Reason: Mutation testing code runs on domain modules, not API guidelines.
* **Test Data Governance Board:** ABSTAINED. Reason: Data factories, test seed integrity, and test fixtures are managed under QA rules.
* **Design System Architect:** ABSTAINED. Reason: Typography tokens, design tokens, and UI tokens do not impact HTTP API contracts.
* **Elder Experience Specialist:** ABSTAINED. Reason: Mobile UI adaptations are managed under the Accessibility framework.
* **Human Factors Reviewer:** ABSTAINED. Reason: Device-level ergonomics and touch targets do not impact HTTP payload structures.
* **Dependency Governance Board:** ABSTAINED. Reason: No package dependency changes or licensing rules are altered.
* **Open Source Governance Board:** ABSTAINED. Reason: Self-Hosting fallbacks are governed under the Business Model.
* **Financial Sustainability Board:** ABSTAINED. Reason: API Guidelines have no direct impact on compute budgets or pricing models.

---

## 1. API Architecture & Design Principles

All API design and integration between the Flutter Mobile Client and the FastAPI backend must adhere to these structural rules:
* **RESTful JSON Design:** APIs expose resources using standard HTTP verbs, path-based resources, and structured JSON payloads.
* **Separation from Infrastructure:** API paths and schemas reflect domain models and business capabilities, never database tables or backend adapters.
* **Security & Validation at the Boundary:** Every incoming payload is validated against strict Pydantic schemas before reaching application services.
* **Correlation-ID Propagation:** Every request must carry a unique `X-Correlation-ID` header to link API execution trace routes to observability logs.

---

## 2. API Gateway & Protection Architecture

* **Edge Architecture:** All client traffic passes through an API Gateway (e.g., NGINX / AWS API Gateway) prior to service routing.
* **WAF & DDoS Mitigation:** The gateway implements Web Application Firewall (WAF) rule groups (mitigating SQL Injection, XSS, and Remote File Inclusion) and geo-rate limiting to block botnets and DDoS volume.
* **Strict Rate Limiting:** Enforced at the gateway via Redis:
  * Maximum: **60 requests per minute** per device profile.
  * Priority bypass: Medicine logging, critical parent notifications, and synchronization endpoints are whitelisted for higher limits under active session tracking.

---

## 3. Idempotency Policy

To prevent duplicate mutations from network retries or sync queues:
* **Idempotency-Key Header:** All write and mutate requests (POST, PUT, PATCH) must carry an `Idempotency-Key` UUID header.
* **Storage & Lifetime:** The API Gateway caches idempotency keys and their corresponding response payloads in Redis with a **24-hour retention window**.
* **Request Handling:**
  * If a request with an existing key is received and the original transaction is complete: return the cached response immediately.
  * If a request is received and the original transaction is still processing: return `409 Conflict` (or `423 Locked`), prompting the client to retry.

---

## 4. API Deprecation & Sunset Policy

We align our version retirement with RFC 8594 specifications:
* **Sunset & Deprecation Headers:** Deprecated endpoints return HTTP response headers:
  * `Deprecation: <date>` (marking the deprecation event).
  * `Sunset: <date>` (marking the official termination date).
  * `Link: <url>; rel="deprecation"` (referencing migration documentation).
* **Support Window:** Deprecated APIs are supported for a minimum of **36 months** after deprecation announcements to accommodate older mobile binaries.
* **Notification Window:** An official deprecation notice must be published **12 months** before any endpoint is sunsetted.

---

## 5. OWASP API Security Controls

API services implement strict controls defending against critical OWASP API Top 10 vulnerabilities:
* **Broken Object Level Authorization (BOLA) Prevention:** Every API request controller must explicitly verify context ownership. Before completing a query or mutation on a resource ID, the backend validates that the resource belongs to the requesting user’s family circle.
* **Broken Function Level Authorization (BFLA) Prevention:** Enforce granular role-based checks (RBAC) on the backend. A user holding a "Guest" or "Elder" role cannot call endpoints reserved for the "Coordinator."
* **Property-Level Authorization (Mass Assignment & Excessive Data Exposure Prevention):** Output DTO schemas are strictly pruned. Only fields authorized for the requesting user's role are returned; inputs are filtered to prevent unauthorized schema updates.

---

## 6. Refresh Token Architecture & Security

To secure active device sessions:
* **Refresh Token Rotation (RTR):** When a client requests a new access token using a refresh token, the server returns a new access token AND a new rotated refresh token. The previous refresh token is immediately invalidated.
* **Reuse Detection:** Every refresh token belongs to a parent token family. If a previously used refresh token is presented, the server assumes token theft has occurred, invalidates the entire token family, revokes all sessions associated with that user, and requires re-authentication.
* **Revocation List:** Active refresh tokens are tracked in Redis. Upon user logout, the token family is blacklisted instantly.

---

## 7. Standard HTTP Status Codes

LifeCircle OS APIs must use the following standard HTTP codes:

* **200 OK:** Successful GET request, or a PUT/PATCH update that completes synchronously.
* **201 Created:** Successful POST request resulting in resource creation.
* **202 Accepted:** Successful upload of an asynchronous synchronization payload (queued for processing).
* **400 Bad Request:** Client validation error.
* **401 Unauthorized:** Authentication credentials missing or expired.
* **403 Forbidden:** The authenticated user has insufficient role permissions (RBAC/BFLA violation).
* **404 Not Found:** The requested entity does not exist.
* **409 Conflict:** Concurrency conflict or idempotency block.
* **429 Too Many Requests:** Device rate limit exceeded (Redis limit trigger).
* **500 Internal Server Error:** Server-side exception or database communication outage.

---

## 8. Standard Error Response & Localization Schema

To maintain clean client architecture, API error payloads do not contain user-facing display strings. All errors return standardized localization keys:

```json
{
  "error_code": "RESOURCE_CONCURRENCY_CONFLICT",
  "localization_key": "err.finance.bill_modified",
  "correlation_id": "c-9a4f-402a-912b",
  "audit_id": "a-1290-7382-f81d",
  "details": {
    "entity_type": "household_task",
    "entity_id": "uuid-8390-482a-923f",
    "client_version": 2,
    "server_version": 3
  }
}
```

* **localization_key:** A structured string key (e.g., `err.finance.bill_modified`) mapped directly to the local translation resource files in the Flutter application.
* **details:** Dynamic payload variables used by the mobile client to format localized messages (e.g., displaying the entity name).

---

## 9. Eventual Synchronization API Design

Synchronization is designed as an eventually consistent batch pipeline to minimize battery drain and survive connectivity drops.

### Synchronization Endpoint
* **Path:** `POST /api/v1/sync`
* **Content-Type:** `application/json`
* **Headers:** Requires `Authorization: Bearer <token>` and `Idempotency-Key: <uuid>`.
* **Request Schema:**
```json
{
  "family_id": "uuid-1111-2222-3333",
  "device_id": "uuid-device-7382",
  "last_synced_timestamp": "2026-06-26T16:00:00.000Z",
  "actions": [
    {
      "action_id": "uuid-action-9281",
      "action_type": "LOG_MEDICINE_INTAKE",
      "bounded_context": "Medicines",
      "payload": {
        "schedule_id": "uuid-schedule-8392",
        "intake_timestamp": "2026-06-26T16:05:00.000Z"
      },
      "client_timestamp": "2026-06-26T16:05:02.000Z",
      "entity_version": 1
    }
  ]
}
```
* **Response Schema (HTTP 200 OK / 202 Accepted):**
```json
{
  "sync_timestamp": "2026-06-26T16:10:00.000Z",
  "processed_actions": [
    {
      "action_id": "uuid-action-9281",
      "status": "SUCCESS"
    }
  ],
  "rejected_actions": [],
  "updates": {
    "medicines": [],
    "finance": [],
    "household": []
  }
}
```

---

## 10. OpenAPI & API Contract Governance

To guarantee type safety and prevent drift across teams and AI iterations:
* **OpenAPI 3.1 Specification:** The API contracts are declared in code using OpenAPI 3.1 specs.
* **Automated Diff Auditing:** Every pull request runs `openapi-diff` in the DevSecOps pipeline. If a change breaks the API contract (e.g., changes parameter types or removes fields) without a path-version bump, the build fails.
* **Consumer-Driven Contract Testing:**
  * Pact contract schema verification runs in CI, ensuring backend providers verify contracts before deployment.
  * Deployment pipelines enforce `can-i-deploy` check gates.
  * **Dynamic Testing:** Automated API schema fuzzing and conformance checks run in CI via `Schemathesis` or `Dredd`.

---

## 11. Institutional API Principle

> **Core Philosophy:**  
> APIs are contracts. They represent the communication boundaries of our family institution. Breaking an API contract without backward compatibility is a failure of governance.

🙏 श्री गणेशाय नमः
