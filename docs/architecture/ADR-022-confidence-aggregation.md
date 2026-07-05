# ADR-022: Confidence Aggregation Engine

## Context
The `FamilyPeaceIndex` requires rolling up the individual `confidenceScore` of potentially hundreds of historical and active `FamilyResponsibility` entities into a single metric.

## Decision
We will calculate the `FamilyPeaceIndex` **on-the-fly via Riverpod** for local display, but **materialize it locally in Isar** via background workers for offline persistence and historical charting.

### 1. The Riverpod Provider (Instant UI)
A `peaceIndexProvider` will actively listen to the `familyResponsibilitiesProvider`. Whenever a task transitions to `ESCALATED`, the provider instantly recalculates and broadcasts the new score to the UI, driving the Exception-Based Dashboard.

### 2. The Isar Materialization (Background)
A background Isar transaction runs periodically (or upon app backgrounding) to snapshot the `FamilyPeaceIndex` into the database. 

## Rationale
* **Performance**: We avoid heavy SQL-like aggregations on the UI thread during scrolling.
* **Offline First**: If the device loses connection, the Riverpod provider continues to calculate the score perfectly based on the local Isar database.
* **Historical Trends**: Materializing the score allows us to build a chart showing "Anxiety over the last 30 days" without replaying thousands of events.

## Consequences
* We must ensure the Riverpod logic and the background Isar logic use the exact same mathematical penalty algorithms.
