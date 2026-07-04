import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_status.dart';

/// Represents a specific, executable reminder instance for a medicine dose.
class ReminderEntity {
  /// Creates a new [ReminderEntity].
  const ReminderEntity({
    required this.id,
    required this.medicineId,
    required this.familyId,
    required this.memberId,
    required this.scheduledTimeUtc,
    required this.createdAt,
    required this.updatedAt,
    this.status = ReminderStatus.pending,
    this.completedAt,
    this.skippedAt,
    this.snoozedUntil,
    this.note,
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

  /// The current state of this reminder.
  final ReminderStatus status;

  /// UTC timestamp when the dose was actually taken, if applicable.
  final DateTime? completedAt;

  /// UTC timestamp when the dose was skipped, if applicable.
  final DateTime? skippedAt;

  /// UTC timestamp until which the reminder is snoozed.
  final DateTime? snoozedUntil;

  /// Optional note about this reminder instance.
  final String? note;

  /// UTC timestamp of creation.
  final DateTime createdAt;

  /// UTC timestamp of the last update.
  final DateTime updatedAt;
}
