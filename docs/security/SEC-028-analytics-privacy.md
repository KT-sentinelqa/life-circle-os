# SEC-028: Analytics Privacy

**Status:** Enforced | **Phase:** 6A

## Policy Rules

### 1. Principle of Data Minimization
LifeCircle OS collects analytics exclusively for "Product Learning" (improving stability, measuring feature adoption, diagnosing UX bottlenecks). Marketing analytics and third-party tracking pixels (e.g., Meta Pixel, Google Analytics advertising IDs) are strictly forbidden.

### 2. Anonymization at the Source
Analytics events must be stripped of PII on the client device before transmission to the analytics sink. 

**Prohibited Analytics Data:**
- User Names
- Responsibility Names/Titles
- Contact Names/Roles
- Free-text input of any kind

### 3. Permitted Analytics Data
Events should track *behavior*, not *content*.

**Example Valid Analytics Event:**
```json
{
  "event": "responsibility_completed",
  "properties": {
    "category": "finance",
    "time_to_complete_seconds": 340,
    "was_escalated": true,
    "completed_offline": true,
    "sync_latency_ms": 120
  }
}
```

### 4. Opt-Out Guarantee
Users must be able to entirely opt-out of Product Learning Analytics during onboarding, and toggle this setting at any time in the Privacy Settings. If opted out, the Analytics Service must short-circuit all event logging instantly.
