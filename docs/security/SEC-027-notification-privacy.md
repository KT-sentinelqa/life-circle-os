# SEC-027: Notification Privacy

**Status:** Enforced | **Phase:** 6A

## Policy Rules

### 1. Zero PII in Push Payloads
Apple Push Notification service (APNs) and Firebase Cloud Messaging (FCM) are external third-party services. To maintain Zero Trust, absolutely NO Personally Identifiable Information (PII) may be transmitted through these networks.

**Prohibited Data in Push Payloads:**
- User Names (e.g., "Arjun", "Papa")
- Entity Names (e.g., "Aspirin", "Rent Payment")
- Exact Financial Amounts
- Plaintext Medical Conditions

### 2. Allowed Payload Structure
Push payloads must only contain routing information and entity references.

**Example Valid Payload:**
```json
{
  "type": "responsibility.escalated",
  "entity_uuid": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
  "category": "health",
  "priority": "important"
}
```

### 3. Local Hydration
When the mobile client receives the push notification, it must intercept it in the background, read the `entity_uuid`, look up the entity in the local Isar database (which is encrypted), and construct the human-readable notification text locally.

If the entity does not exist locally, the client must trigger a silent background sync to fetch it before displaying the notification.
