import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/medicines/domain/value_objects/dosage.dart';
import 'package:lifecircle_mobile/src/features/medicines/domain/value_objects/schedule.dart';
import 'package:lifecircle_mobile/src/features/medicines/domain/value_objects/prescription.dart';
import 'package:lifecircle_mobile/src/features/medicines/domain/events/medicine_events.dart';

@immutable
class MedicineAggregate {
  const MedicineAggregate._({
    required this.medicineId,
    required this.householdId,
    required this.patientId,
    required this.name,
    required this.dosage,
    required this.schedule,
    this.prescription,
    required this.isActive,
    required this.dosesTaken,
    required this.dosesMissed,
  });

  final String medicineId;
  final String householdId;
  final String patientId;
  final String name;
  final Dosage dosage;
  final Schedule schedule;
  final Prescription? prescription;
  final bool isActive;
  final int dosesTaken;
  final int dosesMissed;

  // --- Aggregate Behaviors ---

  static ({MedicineAggregate aggregate, List<MedicineEvent> events}) addMedicine({
    required String householdId,
    required String patientId,
    required String name,
    required Dosage dosage,
    required Schedule schedule,
    Prescription? prescription,
  }) {
    final medicineId = const Uuid().v4();

    final aggregate = MedicineAggregate._(
      medicineId: medicineId,
      householdId: householdId,
      patientId: patientId,
      name: name,
      dosage: dosage,
      schedule: schedule,
      prescription: prescription,
      isActive: true,
      dosesTaken: 0,
      dosesMissed: 0,
    );

    final event = MedicineAdded(
      medicineId: medicineId,
      householdId: householdId,
      name: name,
      patientId: patientId,
    );

    return (aggregate: aggregate, events: [event]);
  }

  ({MedicineAggregate aggregate, List<MedicineEvent> events}) recordDoseTaken(String patientName) {
    if (!isActive) throw Exception('Cannot record dose for an inactive medicine.');

    final event = MedicineTaken(
      medicineId: medicineId,
      householdId: householdId,
      patientId: patientId,
      patientName: patientName,
      medicineName: name,
    );

    return (
      aggregate: copyWith(dosesTaken: dosesTaken + 1),
      events: [event],
    );
  }

  ({MedicineAggregate aggregate, List<MedicineEvent> events}) recordMissedDose(String patientName) {
    if (!isActive) throw Exception('Cannot record dose for an inactive medicine.');

    final event = MissedDoseRecorded(
      medicineId: medicineId,
      householdId: householdId,
      patientId: patientId,
      patientName: patientName,
      medicineName: name,
    );

    return (
      aggregate: copyWith(dosesMissed: dosesMissed + 1),
      events: [event],
    );
  }

  // --- Helpers ---

  MedicineAggregate copyWith({
    bool? isActive,
    int? dosesTaken,
    int? dosesMissed,
  }) {
    return MedicineAggregate._(
      medicineId: medicineId,
      householdId: householdId,
      patientId: patientId,
      name: name,
      dosage: dosage,
      schedule: schedule,
      prescription: prescription,
      isActive: isActive ?? this.isActive,
      dosesTaken: dosesTaken ?? this.dosesTaken,
      dosesMissed: dosesMissed ?? this.dosesMissed,
    );
  }
}
