# Executive Decision Register

This document records major strategic and business decisions (distinct from Architectural Decision Records (ADRs) which record engineering decisions).

| ID | Date | Decision | Rationale | Status |
|---|---|---|---|---|
| BDR-001 | 2026-07-10 | **No Ad-Supported Free Tier** | Protecting family data is the core value proposition. Ads require behavioral tracking, violating the Privacy Constitution. | Active |
| BDR-002 | 2026-07-10 | **Flat-Rate Pricing ($99/yr)** | Per-seat pricing penalizes families for adding grandparents/caregivers, reducing app stickiness. Flat rate encourages network effects within the household. | Active |
| BDR-003 | 2026-07-10 | **No Third-Party Analytics SDKs** | Tools like Mixpanel/Firebase Analytics often scrape PII by default. We will build an internal UX Telemetry dashboard (SEC-030). | Active |
| BDR-004 | 2026-07-10 | **Bypass Public Beta initially** | To ensure the offline-first sync engine handles edge cases (e.g., divorce transitions, complex permissions), we will test strictly with 10 Design Partners (F001-F010) before GA. | Active |
