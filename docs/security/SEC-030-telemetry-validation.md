# SEC-030: Telemetry Validation

**Status:** Enforced | **Phase:** 6B

## Policy Rules

### 1. Internal Telemetry Dashboard Only
LifeCircle OS will not integrate third-party telemetry dashboards (e.g., Mixpanel, Firebase Analytics, Amplitude) in order to uphold our Zero Trust and Privacy Constitution. All UX Telemetry will be routed to a bespoke, privacy-preserving internal dashboard.

### 2. Mandatory Data Scrubbing
Before any UX metrics are transmitted to the backend, they must pass through the client-side `AnalyticsService` (implemented in Phase 6A) which enforces SEC-028.

**Permitted Telemetry Data:**
- `Dashboard viewed`
- `Peace Index viewed` (Timestamp only, NOT the score itself if tied to an identity)
- `Responsibility completed`
- `Invite accepted`
- `Offline duration` (Time elapsed)
- `Sync retries` (Count)
- `Feature flag enabled`
- `App version`
- `Screen render time` (Milliseconds)

**Strictly Prohibited Data:**
- Any free-text strings (Medicine names, Document titles, Contact names).
- Exact financial quantities.
- Family relationships (outside of cryptographic authorization logic).

### 3. Telemetry Purpose Restriction
UX Telemetry exists *solely* to diagnose performance bottlenecks and measure feature adoption rates (Product Learning). It may never be used for behavioral profiling, advertising, or cross-referencing with external datasets.
