import 'package:isar/isar.dart';

import 'package:lifecircle_mobile/src/core/utils/hash.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_log_entity.dart';

part 'isar_medicine_log.g.dart';

/// Isar database model representing a medicine log entry.
@collection
class IsarMedicineLog {
  /// Creates an empty [IsarMedicineLog] model.
  IsarMedicineLog();

  /// Creates an [IsarMedicineLog] from a domain [MedicineLogEntity].
  factory IsarMedicineLog.fromEntity(MedicineLogEntity entity) {
    return IsarMedicineLog()
      ..id = entity.id
      ..medicineId = entity.medicineId
      ..familyId = entity.familyId
      ..memberId = entity.memberId
      ..scheduledAtUtc = entity.scheduledAtUtc
      ..takenAtUtc = entity.takenAtUtc
      ..status = entity.status
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

  /// UTC timestamp when the dose was scheduled.
  late DateTime scheduledAtUtc;

  /// UTC timestamp when the dose was taken.
  DateTime? takenAtUtc;

  /// The status of the medicine log.
  @Enumerated(EnumType.name)
  late MedicineLogStatus status;

  /// UTC timestamp of creation.
  late DateTime createdAtUtc;

  /// UTC timestamp of the last update.
  late DateTime updatedAtUtc;

  /// Converts this Isar model into a domain [MedicineLogEntity].
  MedicineLogEntity toEntity() {
    return MedicineLogEntity(
      id: id,
      medicineId: medicineId,
      familyId: familyId,
      memberId: memberId,
      scheduledAtUtc: scheduledAtUtc,
      takenAtUtc: takenAtUtc,
      status: status,
      createdAtUtc: createdAtUtc,
      updatedAtUtc: updatedAtUtc,
    );
  }
}
