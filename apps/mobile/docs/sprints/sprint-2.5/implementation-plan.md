# Sprint 2.5 Implementation Plan

## Phase 1: Local Notification Infrastructure
1. Setup the `timezone` package initialization.
2. Implement `notification_permission_service.dart` to request precise alarm/notification OS permissions.
3. Migrate `LocalNotificationService` to leverage `zonedSchedule` from `flutter_local_notifications`.
4. Ensure APIs for `schedule`, `cancel`, and `reschedule` are idempotent.
5. Create tests asserting deterministic scheduling boundaries.

## Phase 2: Medication Adherence Engine
1. Define the `AdherenceMetrics` domain entity with calculations for: `adherencePercentage`, `currentStreak`, and `riskLevel`.
2. Build `MedicineAdherenceService` combining historical logs and pending reminders to compute metrics.
3. Add robust unit testing using `MockAppClock`.

## Phase 3: Family Visibility & Caregiver Awareness
1. Define `FamilyMedicationSummary` entity.
2. Create `family_medication_status_provider.dart` to fetch state across multiple member profiles within the same family ID.

## Phase 4: Dashboard Analytics
1. Build intelligent widgets: `AdherenceCard`, `MedicationStreakCard`, `FamilyOverviewCard`, and `MissedMedicineBanner`.
2. Connect them to the new adherence and family providers.
3. Update the `MedicineDashboardScreen` layout to incorporate these panels.
