import 'package:lifecircle_mobile/src/features/medicine/domain/entities/escalation_policy.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/visibility_policy.dart';

/// Represents a medicine assigned to a family member.
class MedicineEntity {
  /// Creates a new [MedicineEntity].
  const MedicineEntity({
    required this.id,
    required this.familyId,
    required this.memberId,
    required this.name,
    required this.dosage,
    required this.form,
    required this.instructions,
    required this.createdAtUtc,
    required this.updatedAtUtc,
    this.ownerUserId = '',
    this.caregiverIds = const [],
    this.visibilityPolicy = VisibilityPolicy.family,
    this.escalationPolicy = EscalationPolicy.standard,
  });

  /// Unique identifier for the medicine.
  final String id;

  /// Identifier of the family owning this medicine.
  final String familyId;

  /// Identifier of the family member taking this medicine.
  final String memberId;

  /// Name of the medicine (e.g., Aspirin).
  final String name;

  /// Dosage amount (e.g., 100mg).
  final String dosage;

  /// Form of the medicine (e.g., Pill, Syrup).
  final String form;

  /// Specific instructions for taking the medicine.
  final String instructions;

  /// UTC timestamp of creation.
  final DateTime createdAtUtc;

  /// UTC timestamp of the last update.
  final DateTime updatedAtUtc;

  /// User ID of the family member who created/owns this medicine record.
  final String ownerUserId;

  /// List of caregiver User IDs specifically assigned to this medicine.
  final List<String> caregiverIds;

  /// Defines who can view this medicine.
  final VisibilityPolicy visibilityPolicy;

  /// Defines the escalation path for missed doses.
  final EscalationPolicy escalationPolicy;
}
