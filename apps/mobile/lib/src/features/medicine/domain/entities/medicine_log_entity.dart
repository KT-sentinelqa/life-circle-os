/// Represents the status of a medicine log entry.
enum MedicineLogStatus {
  /// The dose is scheduled but not yet due or taken.
  scheduled,

  /// The dose was taken.
  taken,

  /// The dose was intentionally skipped.
  skipped,

  /// The dose was missed (time passed without action).
  missed,

  /// The dose was postponed to a later time.
  postponed,
}

/// Represents an audit trail entry for a specific medicine dose.
class MedicineLogEntity {
  /// Creates a new [MedicineLogEntity].
  const MedicineLogEntity({
    required this.id,
    required this.medicineId,
    required this.familyId,
    required this.memberId,
    required this.scheduledAtUtc,
    required this.status,
    required this.createdAtUtc,
    required this.updatedAtUtc,
    this.takenAtUtc,
  });

  /// Unique identifier for the log entry.
  final String id;

  /// Identifier of the associated medicine.
  final String medicineId;

  /// Identifier of the family.
  final String familyId;

  /// Identifier of the family member.
  final String memberId;

  /// UTC timestamp when the dose was originally scheduled.
  final DateTime scheduledAtUtc;

  /// The current status of this scheduled dose.
  final MedicineLogStatus status;

  /// UTC timestamp of creation.
  final DateTime createdAtUtc;

  /// UTC timestamp of the last update.
  final DateTime updatedAtUtc;

  /// UTC timestamp when the dose was taken, if applicable.
  final DateTime? takenAtUtc;
}
