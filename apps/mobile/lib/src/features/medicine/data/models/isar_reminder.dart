import 'package:isar/isar.dart';

import 'package:lifecircle_mobile/src/core/utils/hash.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_entity.dart';

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
      ..isTaken = entity.isTaken
      ..takenTimeUtc = entity.takenTimeUtc;
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

  /// Whether the dose is taken.
  late bool isTaken;

  /// UTC timestamp when the dose was taken.
  DateTime? takenTimeUtc;

  /// Converts this Isar model into a domain [ReminderEntity].
  ReminderEntity toEntity() {
    return ReminderEntity(
      id: id,
      medicineId: medicineId,
      familyId: familyId,
      memberId: memberId,
      scheduledTimeUtc: scheduledTimeUtc,
      isTaken: isTaken,
      takenTimeUtc: takenTimeUtc,
    );
  }
}
