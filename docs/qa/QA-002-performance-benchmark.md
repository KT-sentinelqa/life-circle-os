# QA-002: Performance Benchmark

**Status:** Active | **Phase:** 6B

Enterprise apps do not guess performance; they measure it against strict budgets. LifeCircle OS targets non-technical users and older devices; therefore, performance must be stellar to prevent frustration and panic during emergencies.

## Core Budgets (Global)
- **Target Framerate:** 60 FPS (no dropped frames on scroll)
- **Jank Tolerance:** < 16ms per frame render time
- **Memory Footprint:** < 180 MB under normal load

## Screen-Specific Benchmarks

### Dashboard
- **Cold Start:** < 2 seconds (from app icon tap to interactive UI)
- **Warm Start:** < 700 ms (resume from background)
- **Peace Score Recomputation:** < 100 ms (must not block UI thread)

### Responsibilities List
- Must render and scroll smoothly (60 FPS) with 10, 100, and 1000 items in Isar.

### Sync Engine
- **Queue Latency:** Background sync processing must not impact UI thread. Isar `writeTxn` operations must be batched or executed asynchronously.

## Measurement Protocol
1. Benchmarks must be captured using **Flutter Profile Mode** on physical devices (not debug mode, not simulators).
2. Use Flutter DevTools to capture memory snapshots and frame timings.
3. Telemetry is collected via `PerformanceMetricsObserver` and routed to the internal UX dashboard (SEC-030).
