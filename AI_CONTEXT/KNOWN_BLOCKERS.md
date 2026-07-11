---
blocker_count: 3
highest_severity: "High"
---
# Known Blockers & Technical Debt

| ID | Severity | Category | Description |
|---|---|---|---|
| B-02 | High | Data | Missing background sync manager & conflict resolution logic. |
| B-03 | Med | Ops | Missing Prometheus/Grafana telemetry hooks. |
| B-04 | Critical | Security | 8 production placeholders (Mocks/Demos) present in execution paths (See `SECURITY_INVENTORY.md`). |
| B-05 | High | Backend | Production authentication backend contract not yet implemented; returns `UnimplementedError`. |
