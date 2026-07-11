import 'package:lifecircle_mobile/src/sdk/v1/models/dto/medicine_dto.dart';

abstract class MedicineSDK {
  /// Adds a new medicine tracking schedule for a household member.
  Future<MedicineDTO> addMedicine({
    required String householdId,
    required String patientId,
    required String name,
    required double dosageAmount,
    required String dosageUnit,
    required String frequency,
    required String timeOfDay,
  });

  /// Records a successful dose taken, generating a Timeline event.
  Future<void> recordDoseTaken({
    required String medicineId,
    required String patientName,
  });

  /// Records a missed dose, generating a Timeline event.
  Future<void> recordMissedDose({
    required String medicineId,
    required String patientName,
  });

  /// Retrieves the current adherence state.
  Future<MedicineDTO> getMedicine(String medicineId);
}
