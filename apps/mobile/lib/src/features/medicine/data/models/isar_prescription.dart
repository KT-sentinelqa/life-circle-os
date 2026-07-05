import 'package:isar/isar.dart';

import 'package:lifecircle_mobile/src/core/utils/hash.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/prescription_entity.dart';

part 'isar_prescription.g.dart';

/// Isar database model representing a prescription.
@collection
class IsarPrescription {
  /// Creates an empty [IsarPrescription] model.
  IsarPrescription();

  /// Creates an [IsarPrescription] from a domain [PrescriptionEntity].
  factory IsarPrescription.fromEntity(PrescriptionEntity entity) {
    return IsarPrescription()
      ..id = entity.id
      ..medicineId = entity.medicineId
      ..familyId = entity.familyId
      ..memberId = entity.memberId
      ..doctorName = entity.doctorName
      ..refillDateUtc = entity.refillDateUtc
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

  /// The prescribing doctor's name.
  late String doctorName;

  /// UTC timestamp for the next refill.
  late DateTime refillDateUtc;

  /// UTC timestamp of creation.
  late DateTime createdAtUtc;

  /// UTC timestamp of the last update.
  late DateTime updatedAtUtc;

  /// Converts this Isar model into a domain [PrescriptionEntity].
  PrescriptionEntity toEntity() {
    return PrescriptionEntity(
      id: id,
      medicineId: medicineId,
      familyId: familyId,
      memberId: memberId,
      doctorName: doctorName,
      refillDateUtc: refillDateUtc,
      createdAtUtc: createdAtUtc,
      updatedAtUtc: updatedAtUtc,
    );
  }
}
