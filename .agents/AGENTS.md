# LifeCircle OS Project Rules

Always adhere strictly to the rules defined in the Operating Agreement.

## Golden Rule
The Implementation Engineer SHALL NOT:
- Skip a requested document.
- Compress multiple phases into one.
- Generate code before documentation approval.
- Introduce architectural assumptions.
- Change naming conventions without ADR approval.
- Add dependencies without governance approval.
- Ignore performance, accessibility, observability, or security implications.

If uncertainty exists:
**STOP.**
**Request clarification.**
**Never assume.**

## Mandatory Operating Protocol

1. **Role of Gemini:** Gemini is the Implementation Engineer. We must NEVER invent architecture independently, change approved standards, introduce dependencies without approval, or expand scope without RFC approval.
2. **Review Board Workflow:** All designs, architectures, documents, APIs, schemas, and implementations MUST be presented to Krishna to be reviewed by the 39-Role Architecture Review Board (ARB).
3. **No Silent Approvals:** No role's approval may be assumed. Every role must explicitly state APPROVED, APPROVED WITH CONDITIONS, REJECTED, or ABSTAINED.
4. **Document Lifecycle Metadata:** All major documents must include:
   - Status: Draft | Proposed | Approved | Locked | Deprecated | Archived
   - Owner: [Owner]
   - Review Board: [Board]
   - Last Review Date: [Date]
   - Next Review Date: [Date]
5. **No Assumptions:** Do not make assumptions, skip reviews, allow feature creep, make undocumented changes, or add dependencies without proper review.
6. **Architectural Fitness Functions & Quality Gates:** All code must pass strict quality gates, and builds must fail if coverage decreases, duplication exceeds 1%, circular dependencies exist, ADRs/RFCs are missing, or documentation is outdated.

Refer to the [OPERATING_AGREEMENT.md](file:///Users/krishnatiwari/Life%20Circle%20OS/OPERATING_AGREEMENT.md) for full details.

## Strict Execution Verification (New Rules)

### Rule 1 — No Completion Claims Without Evidence
No agent may use words like DONE, COMPLETE, FIXED, MIGRATED, or READY until the following have actually been executed:
- `flutter analyze` (must return 0 issues)
- `flutter test` (must be all green)

### Rule 2 — Independent Sign-Offs
Every major task must sequentially pass through the multi-agent governance board:
Architect → Senior Engineer → QA Lead → Build Verification → Test Verification → Release Manager.
Each role must challenge assumptions rather than blindly trust previous outputs.

### Rule 3 — Zero-Warning Policy
For LifeCircle OS, a task is NOT considered complete unless it meets all of the following:
- 0 compile errors
- 0 analyzer warnings
- 0 failing tests
- 0 dead code
- 0 unused imports
### RULE-017: No Completion Claims Without Verification
No agent may claim completion without:
- `build_runner` green
- `flutter analyze` = 0 issues
- `flutter test` = all green

### RULE-018: Explicit Domain Entity Naming
No framework symbol collisions. Domain entities must use explicit naming: `<EntityName>Entity` (e.g. `FamilyEntity`).

### RULE-019: Git Hygiene
Generated artifacts are forbidden in Git. Never commit `Pods/`, `ephemeral/`, `GeneratedPluginRegistrant.*`, `.fvm/`, `*.code-workspace`, or `android/local.properties`. Only source-of-truth files belong in Git.

### RULE-020: Independent Sign-off
Every feature requires independent sign-off through the pipeline: Developer → Build → QA → Architecture → Release Engineering.

### RULE-021: No Freezed for Enums
Do not use Freezed for simple state enums. Use standard Dart enums to reduce generation overhead and improve code clarity.

### RULE-024: No Domain Coupling
Network code (`core/network/`) must never import feature domains. Only the reverse direction is allowed.

### RULE-025: DTO ≠ Entity
Never expose API models directly to business logic. Always map: `API DTO → Mapper → Domain Entity`.

### RULE-026: Repository Owns Mapping
Repositories act as the anti-corruption layer, orchestrating the translation from DTOs to Entities.

### RULE-027: No Raw Dio Usage
Forbidden to use `Dio().get(...)` directly. Only `ApiClient.get(...)` is allowed. One gateway only.

### RULE-028: Offline First Always Wins
No feature may block on internet availability. Read: `Local DB → Network Refresh (background)`. Write: `Local DB → Outbox → Sync Engine → Server`.

### RULE-029: Last Write Wins (V1)
For V1, use `updatedAt` timestamp to resolve conflicts; latest timestamp wins.

### RULE-030: Zero Secrets In Code
Never commit API URLs, Keys, Tokens, Client IDs, or Environment-specific values. Use `.env` files and typed configuration objects.

### RULE-031: Dotenv Is Configuration Loading Only
Dotenv must only be used for Base URLs, feature flags, etc. Real secrets must NEVER be compiled into mobile binaries.

### RULE-032: Interceptor Ordering
Interceptor ordering is immutable without Architecture Board approval. Current order: `AuthInterceptor` -> `OfflineInterceptor` -> `RetryInterceptor` -> `TelemetryInterceptor` -> `LoggingInterceptor`.

### RULE-033: Retry Policies
Retry policies must be deterministic and unit-tested.
