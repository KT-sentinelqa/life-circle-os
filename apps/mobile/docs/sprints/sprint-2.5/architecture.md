# Sprint 2.5 Architecture: Medication Intelligence & Notification Engine

## Design Philosophy
Continue adhering to the robust principles set in Sprint 2.3 & 2.4:
- **Offline-First:** All business rules execute locally.
- **DDD Aggregate Ownership:** Entities like `AdherenceMetrics` and `FamilyMedicationSummary` encapsulate complex calculations, keeping them out of providers.
- **Repository Pattern:** State mutations flow purely through the data layer, not the application layer.

## Subsystem Breakdown

### 1. Core Notifications (`lib/src/core/notifications/`)
- **`notification_service.dart` (Contract)**: Interface for timezone-aware, idempotent scheduling APIs.
- **`flutter_notification_service.dart` (Impl)**: Replaces the stubbed memory service with native timezone scheduling via `flutter_local_notifications` and `timezone/data/latest.dart`.
- **`notification_permission_service.dart`**: Handles OS-level permission requests safely.

### 2. Medication Adherence (`lib/src/features/medicine/domain/services/`)
- **`medicine_adherence_service.dart`**: Calculates streaks and risk categorization (Excellent, Good, Needs Attention, High Risk) dynamically based on repository data. Returns structured `AdherenceMetrics`.

### 3. Family Coordination (`lib/src/features/medicine/domain/services/`)
- **`family_medication_provider.dart`**: Aggregates `ReminderStatus` for multiple family members into a summarized `FamilyMedicationSummary`, updating offline.

### 4. Presentation & Dashboards (`lib/src/features/medicine/presentation/`)
- New Providers: `adherence_provider`, `notification_permission_provider`
- New Widgets: `AdherenceCard`, `MedicationStreakCard`, `FamilyOverviewCard`, `MissedMedicineBanner`
