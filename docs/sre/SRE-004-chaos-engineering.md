# SRE-004: Chaos Engineering & Resilience Testing

## 1. Objective
To proactively discover systemic weaknesses in the Cloud Trust Platform before they impact real families by intentionally injecting failures into the production-like staging environment.

## 2. The Mandate
Before LifeCircle OS graduates from the Design Partner Program (F001-F010) to a public rollout, the system must survive the following automated disaster scenarios without any permanent data loss or corruption of the Immutable Event Ledger.

## 3. Resilience Scenarios

### Scenario A: The PostgreSQL Partition
* **Action**: Sever the network connection between the FastAPI pods and the PostgreSQL database for exactly 5 minutes during a simulated high-volume sync event.
* **Expected Result**: API returns HTTP 503 Service Unavailable. Redis queues buffer outgoing pushes. Mobile devices cleanly handle the 503 by retaining events in their local Isar Outbox and retrying with exponential backoff. Zero events dropped.

### Scenario B: The Time Traveler (Clock Skew)
* **Action**: Artificially skew a mobile device's system clock 48 hours into the future, and attempt to sync a `ResponsibilityCompleted` event.
* **Expected Result**: The backend `TrustedClock` validation rejects the event as statistically impossible (drifting beyond acceptable NTP bounds), preserving the integrity of the LWW Conflict Resolution.

### Scenario C: The Zombie Device
* **Action**: Disconnect a device from the network. Generate 500 local sync events. Reconnect the device after 14 days.
* **Expected Result**: The device successfully authenticates via its Secure Enclave signature, fetches the massive Inbox delta, and deterministically merges its 500 Outbox events into the cloud ledger without overwhelming the FastAPI rate limiters.

## 4. Execution Rules
Chaos experiments must only be run in the Staging (`STG`) environment. If an experiment fails (results in data loss or a crash loop), it is treated as a Tier-1 incident and must be structurally mitigated before the next production release.
