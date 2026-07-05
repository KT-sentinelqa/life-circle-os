import 'package:isar/isar.dart';

import 'package:lifecircle_mobile/src/core/utils/hash.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/dosage_schedule_entity.dart';

part 'isar_dosage_schedule.g.dart';

/// Isar database model representing a dosage schedule.
@collection
class IsarDosageSchedule {
  /// Creates an empty [IsarDosageSchedule] model.
  IsarDosageSchedule();

  /// Creates an [IsarDosageSchedule] from a domain [DosageScheduleEntity].
  factory IsarDosageSchedule.fromEntity(DosageScheduleEntity entity) {
    return IsarDosageSchedule()
      ..id = entity.id
      ..medicineId = entity.medicineId
      ..familyId = entity.familyId
      ..memberId = entity.memberId
      ..frequencyPerDay = entity.frequencyPerDay
      ..timesOfDay = entity.timesOfDay
      ..specificDaysOfWeek = entity.specificDaysOfWeek
      ..remindersEnabled = entity.remindersEnabled
      ..createdAtUtc = entity.createdAtUtc
      ..updatedAtUtc = entity.updatedAtUtc;
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

  /// Number of times per day.
  late int frequencyPerDay;

  /// Specific times of day.
  late List<String> timesOfDay;

  /// Specific days of the week.
  late List<int> specificDaysOfWeek;

  /// Whether reminders are enabled.
  late bool remindersEnabled;

  /// UTC timestamp of creation.
  late DateTime createdAtUtc;

  /// UTC timestamp of the last update.
  late DateTime updatedAtUtc;

  /// Converts this Isar model into a domain [DosageScheduleEntity].
  DosageScheduleEntity toEntity() {
    return DosageScheduleEntity(
      id: id,
      medicineId: medicineId,
      familyId: familyId,
      memberId: memberId,
      frequencyPerDay: frequencyPerDay,
      timesOfDay: timesOfDay,
      specificDaysOfWeek: specificDaysOfWeek,
      remindersEnabled: remindersEnabled,
      createdAtUtc: createdAtUtc,
      updatedAtUtc: updatedAtUtc,
    );
  }
}
