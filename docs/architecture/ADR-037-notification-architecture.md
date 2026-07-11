# ADR-037: Notification Architecture

**Date:** 2026-07-10  
**Status:** Accepted  

## Context
Notifications can easily become a source of anxiety, contradicting the core product philosophy of LifeCircle OS (Calm interface). We must architect a unified notification dispatch system that categorizes, rate-limits, and respects user peace.

## Decision
All notifications must be categorized into one of four priority levels. The cloud backend enforces this categorization before sending any push payload to FCM/APNs.

1. **Critical:** Bypasses Do Not Disturb (DND). Used exclusively for Emergency situations or severe health escalations (e.g., missed life-saving medication). Emits a unique, non-standard sound.
2. **Important:** Standard push notification with sound and vibration. Used for standard responsibility escalations and direct mentions.
3. **Informational:** Delivered silently. Appears in the notification tray but does not vibrate or play sound. Used for routine completions (e.g., "Arjun completed household chores").
4. **Digest:** Never sent as a push. Aggregated and shown inside the app UI only (e.g., Weekly Peace Index summary).

## Privacy Constraint (SEC-027)
No Personally Identifiable Information (PII) is included in the notification payload. The payload only contains a generic message and an `entity_uuid`. The mobile app receives the push, fetches the entity from Isar (or Cloud if missing), and constructs the final text locally.

## Consequences
- Requires a backend notification dispatch service.
- Mobile client must implement background message handlers to hydrate notification text locally.
