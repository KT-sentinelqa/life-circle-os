/// Represents prescription details associated with a medicine.
class PrescriptionEntity {
  /// Creates a new [PrescriptionEntity].
  const PrescriptionEntity({
    required this.id,
    required this.medicineId,
    required this.familyId,
    required this.memberId,
    required this.doctorName,
    required this.refillDateUtc,
    required this.createdAtUtc,
    required this.updatedAtUtc,
  });

  /// Unique identifier for the prescription.
  final String id;

  /// Identifier of the associated medicine.
  final String medicineId;

  /// Identifier of the family.
  final String familyId;

  /// Identifier of the family member.
  final String memberId;

  /// Name of the prescribing doctor.
  final String doctorName;

  /// UTC timestamp for the next required refill.
  final DateTime refillDateUtc;

  /// UTC timestamp of creation.
  final DateTime createdAtUtc;

  /// UTC timestamp of the last update.
  final DateTime updatedAtUtc;
}
