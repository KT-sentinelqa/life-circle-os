import 'package:flutter/foundation.dart';

@immutable
class MedicineDTO {
  const MedicineDTO({
    required this.medicineId,
    required this.householdId,
    required this.patientId,
    required this.name,
    required this.dosesTaken,
    required this.dosesMissed,
  });

  final String medicineId;
  final String householdId;
  final String patientId;
  final String name;
  final int dosesTaken;
  final int dosesMissed;

  Map<String, dynamic> toJson() => {
    'medicineId': medicineId,
    'householdId': householdId,
    'patientId': patientId,
    'name': name,
    'dosesTaken': dosesTaken,
    'dosesMissed': dosesMissed,
  };
}
