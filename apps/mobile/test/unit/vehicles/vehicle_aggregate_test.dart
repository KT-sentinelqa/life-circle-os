import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/vehicles/domain/value_objects/registration_number.dart';
import 'package:lifecircle_mobile/src/features/vehicles/domain/value_objects/odometer.dart';
import 'package:lifecircle_mobile/src/features/vehicles/domain/aggregates/vehicle_aggregate.dart';
import 'package:lifecircle_mobile/src/features/vehicles/domain/events/vehicle_events.dart';

void main() {
  group('Phase 3B Sprint 4: Vehicle Aggregate', () {
    test('Registering vehicle yields VehicleRegistered event', () {
      final result = VehicleAggregate.register(
        householdId: 'hh_1',
        ownerId: 'mem_1',
        ownerName: 'Krishna',
        makeModel: 'Honda City',
        registration: const RegistrationNumber('MH12AB1234'),
      );

      expect(result.aggregate.makeModel, 'Honda City');
      expect(result.aggregate.serviceRecords.isEmpty, isTrue);
      expect(result.events.length, 1);
      expect(result.events.first, isA<VehicleRegistered>());
    });

    test('Recording service increments serviceRecords and yields ServiceRecorded event', () {
      final init = VehicleAggregate.register(
        householdId: 'hh_1',
        ownerId: 'mem_1',
        ownerName: 'Krishna',
        makeModel: 'Honda City',
        registration: const RegistrationNumber('MH12AB1234'),
      );

      final result = init.aggregate.recordService(
        actorId: 'mem_1',
        actorName: 'Krishna',
        odometer: const Odometer(reading: 10000, unit: 'km'),
        description: 'First Service',
      );

      expect(result.aggregate.serviceRecords.length, 1);
      expect(result.events.length, 1);
      expect(result.events.first, isA<ServiceRecorded>());
    });

    test('Odometer strictly enforces monotonic invariant', () {
      final init = VehicleAggregate.register(
        householdId: 'hh_1',
        ownerId: 'mem_1',
        ownerName: 'Krishna',
        makeModel: 'Honda City',
        registration: const RegistrationNumber('MH12AB1234'),
      );

      final service1 = init.aggregate.recordService(
        actorId: 'mem_1',
        actorName: 'Krishna',
        odometer: const Odometer(reading: 10000, unit: 'km'),
        description: 'First Service',
      );

      expect(
        () => service1.aggregate.recordService(
          actorId: 'mem_1',
          actorName: 'Krishna',
          odometer: const Odometer(reading: 9000, unit: 'km'), // Invalid! Lower than max
          description: 'Second Service',
        ),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('Monotonic Violation'))),
      );
    });

    test('Cannot record service on archived vehicle', () {
      final init = VehicleAggregate.register(
        householdId: 'hh_1',
        ownerId: 'mem_1',
        ownerName: 'Krishna',
        makeModel: 'Honda City',
        registration: const RegistrationNumber('MH12AB1234'),
      );

      final archived = init.aggregate.copyWith(isArchived: true);

      expect(
        () => archived.recordService(
          actorId: 'mem_1',
          actorName: 'Krishna',
          odometer: const Odometer(reading: 10000, unit: 'km'),
          description: 'First Service',
        ),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('archived vehicle'))),
      );
    });
  });
}
