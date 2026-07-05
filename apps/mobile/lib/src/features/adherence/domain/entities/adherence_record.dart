import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_status.dart';

/// Represents a materialized record of a user's adherence on a specific date.
class AdherenceRecord {
  /// Creates an [AdherenceRecord].
  const AdherenceRecord({
    required this.id,
    required this.familyId,
    required this.memberId,
    required this.dateUtc,
    required this.dosesScheduled,
    required this.dosesTaken,
    required this.status,
    this.dosesSkipped = 0,
    this.dosesMissed = 0,
    this.medicineId,
  });

  /// Unique identifier (e.g., "$memberId-$medicineId-YYYY-MM-DD").
  final String id;

  /// The family this record belongs to.
  final String familyId;

  /// The specific member this record belongs to.
  final String memberId;

  /// If null, this record represents the aggregated daily adherence
  /// across all medicines.
  final String? medicineId;

  /// The specific day this record belongs to (normalized to UTC midnight).
  final DateTime dateUtc;

  /// Total doses scheduled for this day.
  final int dosesScheduled;

  /// Total doses successfully taken.
  final int dosesTaken;

  /// Total doses explicitly skipped.
  final int dosesSkipped;

  /// Total doses missed (passed without action).
  final int dosesMissed;

  /// Precomputed status for the day.
  final AdherenceStatus status;

  /// Calculates the adherence percentage (0.0 to 1.0).
  double get percentage =>
      dosesScheduled > 0 ? (dosesTaken / dosesScheduled) : 0.0;
}
