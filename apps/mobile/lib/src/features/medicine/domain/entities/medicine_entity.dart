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
}
