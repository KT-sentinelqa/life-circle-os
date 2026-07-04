/// Defines the scheduling rules for a MedicineEntity.
class DosageScheduleEntity {
  /// Creates a new [DosageScheduleEntity].
  const DosageScheduleEntity({
    required this.id,
    required this.medicineId,
    required this.familyId,
    required this.memberId,
    required this.frequencyPerDay,
    required this.timesOfDay,
    required this.specificDaysOfWeek,
    required this.createdAtUtc,
    required this.updatedAtUtc,
  });

  /// Unique identifier for the dosage schedule.
  final String id;

  /// Identifier of the associated medicine.
  final String medicineId;

  /// Identifier of the family.
  final String familyId;

  /// Identifier of the family member.
  final String memberId;

  /// Number of times the medicine should be taken per day.
  final int frequencyPerDay;

  /// Specific times of day for the dosage (e.g., ['08:00', '20:00']).
  final List<String> timesOfDay;

  /// Specific days of the week (1 = Monday, 7 = Sunday).
  final List<int> specificDaysOfWeek;

  /// UTC timestamp of creation.
  final DateTime createdAtUtc;

  /// UTC timestamp of the last update.
  final DateTime updatedAtUtc;
}
