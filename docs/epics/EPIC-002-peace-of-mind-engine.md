# EPIC-002: Peace of Mind Engine

## Overview
Families do not want task managers. They want to know everything is okay. The Peace of Mind Engine shifts the core UI paradigm of LifeCircle OS from "Things to Do" to "Current Household Confidence".

## Business Value
* **Anxiety Reduction**: The primary value proposition.
* **Exception-Based Attention**: Users only need to interact with the app if the confidence score drops due to an escalation.
* **Monetization Wedge**: High-confidence scores provide tangible proof that the trust infrastructure is working, driving subscription retention (Phase 3 Diamond Signal).

## Core Requirements
1. **The Family Peace Index**: A 0-100 metric calculated based on the aggregate `confidenceScore` of all active responsibilities.
2. **The Exception Dashboard**: A UI that defaults to "All Clear" (green/invisible) and only displays tasks if their SLA is breached.
3. **Decay Mechanics**: The index must decay rapidly when critical tasks (like Medicines) escalate, but recover slowly when tasks are marked complete, mirroring real human anxiety patterns.

## Success Metrics
* Daily Active Anxiety (DAA): Goal is to minimize the time spent checking the app when the Peace Index is 100.
* Time-to-Resolution: When the index drops, how fast does the backup owner intervene?
