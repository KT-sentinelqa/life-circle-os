# ADR-023: Runtime Feature Governance (Kill Switches)

## Context
When an enterprise app is deployed globally, a zero-day bug in a new feature (like the Peace of Mind Engine aggregation logic) can corrupt user data or cause severe anxiety before an App Store update can be approved.

## Decision
We will implement an **Architecture of Remote Kill Switches**.

### Implementation Rules
1. A lightweight, unauthenticated JSON configuration file is hosted on a high-availability CDN.
2. On app startup (and every 6 hours in the background), the app fetches this configuration.
3. The configuration dictates which engines are active:
```json
{
  "features": {
    "responsibility_engine": true,
    "peace_of_mind_engine": false, 
    "cloud_sync": true
  }
}
```
4. If `peace_of_mind_engine` is `false`, the UI gracefully falls back to a safe legacy state (e.g., the standard task list) without crashing.

## Consequences
* Protects the family trust infrastructure from buggy releases.
* Requires architectural discipline to wrap entire feature modules in feature-flag providers within Riverpod.
