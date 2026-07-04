import 'package:isar/isar.dart';

import 'package:lifecircle_mobile/src/core/utils/hash.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_status.dart';

part 'isar_reminder.g.dart';

/// Isar database model representing a reminder instance.
@collection
class IsarReminder {
  /// Creates an empty [IsarReminder] model.
  IsarReminder();

  /// Creates an [IsarReminder] from a domain [ReminderEntity].
  factory IsarReminder.fromEntity(ReminderEntity entity) {
    return IsarReminder()
      ..id = entity.id
      ..medicineId = entity.medicineId
      ..familyId = entity.familyId
      ..memberId = entity.memberId
      ..scheduledTimeUtc = entity.scheduledTimeUtc
      ..status = entity.status.name
      ..completedAt = entity.completedAt
      ..skippedAt = entity.skippedAt
      ..snoozedUntil = entity.snoozedUntil
      ..note = entity.note
      ..createdAt = entity.createdAt
      ..updatedAt = entity.updatedAt;
  }

  /// The internal Isar identifier.
  Id get isarId => fastHash(id);

  /// Unique external identifier.
  @Index(unique: true, replace: true)
  late String id;

  /// Identifier of the associated medicine.
  @Index()
  late String medicineId;

  /// Identifier of the family.
  @Index()
  late String familyId;
  
  /// Identifier of the family member.
  @Index()
  late String memberId;

  /// UTC timestamp when the dose is scheduled.
  late DateTime scheduledTimeUtc;

  /// The current state of this reminder, stored as string.
  @Index()
  late String status;

  /// UTC timestamp when the dose was taken.
  DateTime? completedAt;

  /// UTC timestamp when the dose was skipped.
  DateTime? skippedAt;

  /// UTC timestamp until which the reminder is snoozed.
  DateTime? snoozedUntil;

  /// Optional note.
  String? note;

  /// UTC timestamp of creation.
  late DateTime createdAt;

  /// UTC timestamp of the last update.
  late DateTime updatedAt;

  /// Converts this Isar model into a domain [ReminderEntity].
  ReminderEntity toEntity() {
    return ReminderEntity(
      id: id,
      medicineId: medicineId,
      familyId: familyId,
      memberId: memberId,
      scheduledTimeUtc: scheduledTimeUtc,
      status: ReminderStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => ReminderStatus.pending,
      ),
      completedAt: completedAt,
      skippedAt: skippedAt,
      snoozedUntil: snoozedUntil,
      note: note,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
