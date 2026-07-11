# Known Issues

This document tracks accepted P2 and P3 defects that exist in current release candidates. P0 (Critical) and P1 (High) issues must be resolved before a release is cut, per QA-004.

## Current Release Candidate: v0.9.0-rc1

### UI/UX
- **RESP-012:** Rapidly swiping to complete multiple responsibilities can cause the Haptic Engine to skip a beat on older Android devices (P3).
- **DASH-045:** The Peace Score ring animation stutters slightly if a background sync event initiates simultaneously on iPhone SE (P2).

### Sync Engine
- **SYNC-008:** If a device is offline for >7 days, the initial re-sync payload may take up to 4 seconds to process, slightly exceeding the QA-002 background budget (P2).

### Authentication
- None.

---

*Note to Beta Testers: If you encounter an issue not listed here, please submit a bug report via the Internal Feedback channel.*
