import 'package:isar/isar.dart';

import 'package:lifecircle_mobile/src/core/utils/hash.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/escalation_policy.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/visibility_policy.dart';

part 'isar_medicine.g.dart';

/// Isar database model representing a medicine.
@collection
class IsarMedicine {
  /// Creates an empty [IsarMedicine] model.
  IsarMedicine();

  /// Creates an [IsarMedicine] from a domain [MedicineEntity].
  factory IsarMedicine.fromEntity(MedicineEntity entity) {
    return IsarMedicine()
      ..id = entity.id
      ..familyId = entity.familyId
      ..memberId = entity.memberId
      ..name = entity.name
      ..dosage = entity.dosage
      ..form = entity.form
      ..instructions = entity.instructions
      ..createdAtUtc = entity.createdAtUtc
      ..updatedAtUtc = entity.updatedAtUtc
      ..ownerUserId = entity.ownerUserId
      ..caregiverIds = entity.caregiverIds
      ..visibilityPolicy = entity.visibilityPolicy
      ..escalationPolicy = entity.escalationPolicy;
  }

  /// The internal Isar identifier.
  Id get isarId => fastHash(id);

  /// Unique external identifier.
  @Index(unique: true, replace: true)
  late String id;

  /// Identifier of the family owning this medicine.
  @Index()
  late String familyId;

  /// Identifier of the family member.
  @Index()
  late String memberId;

  /// The name of the medicine.
  late String name;

  /// The dosage amount.
  late String dosage;

  /// The form of the medicine (e.g., Pill).
  late String form;

  /// Specific instructions.
  late String instructions;

  /// UTC timestamp of creation.
  late DateTime createdAtUtc;

  /// UTC timestamp of the last update.
  late DateTime updatedAtUtc;

  /// User ID of the owner.
  late String ownerUserId;

  /// List of assigned caregiver user IDs.
  late List<String> caregiverIds;

  /// The visibility policy for this medicine.
  @Enumerated(EnumType.name)
  late VisibilityPolicy visibilityPolicy;

  /// The escalation policy for this medicine.
  @Enumerated(EnumType.name)
  late EscalationPolicy escalationPolicy;

  /// Converts this Isar model into a domain [MedicineEntity].
  MedicineEntity toEntity() {
    return MedicineEntity(
      id: id,
      familyId: familyId,
      memberId: memberId,
      name: name,
      dosage: dosage,
      form: form,
      instructions: instructions,
      createdAtUtc: createdAtUtc,
      updatedAtUtc: updatedAtUtc,
      ownerUserId: ownerUserId,
      caregiverIds: caregiverIds,
      visibilityPolicy: visibilityPolicy,
      escalationPolicy: escalationPolicy,
    );
  }
}
