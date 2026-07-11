import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/medicines/domain/aggregates/medicine_aggregate.dart';
import 'package:lifecircle_mobile/src/features/medicines/domain/value_objects/dosage.dart';
import 'package:lifecircle_mobile/src/features/medicines/domain/value_objects/schedule.dart';
import 'package:lifecircle_mobile/src/features/medicines/domain/events/medicine_events.dart';

void main() {
  group('Phase 3B Sprint 1: Medicine Aggregate', () {
    late Dosage dummyDosage;
    late Schedule dummySchedule;

    setUp(() {
      dummyDosage = const Dosage(amount: 500, unit: 'mg');
      dummySchedule = const Schedule(frequency: 'daily', timeOfDay: '08:00');
    });

    test('Adding medicine yields MedicineAdded event', () {
      final result = MedicineAggregate.addMedicine(
        householdId: 'hh_1',
        patientId: 'mem_1',
        name: 'Paracetamol',
        dosage: dummyDosage,
        schedule: dummySchedule,
      );

      expect(result.aggregate.name, 'Paracetamol');
      expect(result.aggregate.dosesTaken, 0);
      expect(result.events.length, 1);
      expect(result.events.first, isA<MedicineAdded>());
    });

    test('Recording dose taken increments count and yields MedicineTaken event', () {
      final init = MedicineAggregate.addMedicine(
        householdId: 'hh_1',
        patientId: 'mem_1',
        name: 'Paracetamol',
        dosage: dummyDosage,
        schedule: dummySchedule,
      );

      final result = init.aggregate.recordDoseTaken('Krishna');

      expect(result.aggregate.dosesTaken, 1);
      expect(result.events.length, 1);
      expect(result.events.first, isA<MedicineTaken>());
      
      final event = result.events.first as MedicineTaken;
      expect(event.activityTypeName, 'medicine_taken');
      expect(event.actorName, 'Krishna');
    });

    test('Recording missed dose increments count and yields MissedDoseRecorded event', () {
      final init = MedicineAggregate.addMedicine(
        householdId: 'hh_1',
        patientId: 'mem_1',
        name: 'Paracetamol',
        dosage: dummyDosage,
        schedule: dummySchedule,
      );

      final result = init.aggregate.recordMissedDose('Krishna');

      expect(result.aggregate.dosesMissed, 1);
      expect(result.events.length, 1);
      expect(result.events.first, isA<MissedDoseRecorded>());
      
      final event = result.events.first as MissedDoseRecorded;
      expect(event.activityTypeName, 'medicine_missed');
      expect(event.actorName, 'Krishna');
    });

    test('Cannot record dose on inactive medicine', () {
      final init = MedicineAggregate.addMedicine(
        householdId: 'hh_1',
        patientId: 'mem_1',
        name: 'Paracetamol',
        dosage: dummyDosage,
        schedule: dummySchedule,
      );

      final inactive = init.aggregate.copyWith(isActive: false);

      expect(
        () => inactive.recordDoseTaken('Krishna'),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('inactive medicine'))),
      );
    });
  });
}
