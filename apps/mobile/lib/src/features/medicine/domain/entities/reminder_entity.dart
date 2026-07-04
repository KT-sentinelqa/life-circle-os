/// Represents a specific, executable reminder instance for a medicine dose.
class ReminderEntity {
  /// Creates a new [ReminderEntity].
  const ReminderEntity({
    required this.id,
    required this.medicineId,
    required this.familyId,
    required this.memberId,
    required this.scheduledTimeUtc,
    this.isTaken = false,
    this.takenTimeUtc,
  });

  /// Unique identifier for this reminder instance.
  final String id;

  /// Identifier of the associated medicine.
  final String medicineId;

  /// Identifier of the family.
  final String familyId;

  /// Identifier of the family member.
  final String memberId;

  /// UTC timestamp when the dose is scheduled to be taken.
  final DateTime scheduledTimeUtc;

  /// Whether the dose has been marked as taken.
  final bool isTaken;

  /// UTC timestamp when the dose was actually taken, if applicable.
  final DateTime? takenTimeUtc;
}
