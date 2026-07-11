import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/vehicles/domain/value_objects/registration_number.dart';
import 'package:lifecircle_mobile/src/features/vehicles/domain/value_objects/odometer.dart';
import 'package:lifecircle_mobile/src/features/vehicles/domain/value_objects/document_reference.dart';
import 'package:lifecircle_mobile/src/features/vehicles/domain/entities/service_record.dart';
import 'package:lifecircle_mobile/src/features/vehicles/domain/events/vehicle_events.dart';

@immutable
class VehicleAggregate {
  const VehicleAggregate._({
    required this.vehicleId,
    required this.householdId,
    required this.ownerId,
    required this.makeModel,
    required this.registrationNumber,
    required this.isArchived,
    required this.serviceRecords,
    this.insuranceReference,
  });

  final String vehicleId;
  final String householdId;
  final String ownerId;
  final String makeModel;
  final RegistrationNumber registrationNumber;
  final bool isArchived;
  final List<ServiceRecord> serviceRecords;
  final DocumentReference? insuranceReference;

  Odometer get maxOdometer {
    if (serviceRecords.isEmpty) return const Odometer(reading: 0, unit: 'km');
    return serviceRecords.reduce((a, b) => a.odometer.isLessThan(b.odometer) ? b : a).odometer;
  }

  static ({VehicleAggregate aggregate, List<VehicleEvent> events}) register({
    required String householdId,
    required String ownerId,
    required String ownerName,
    required String makeModel,
    required RegistrationNumber registration,
  }) {
    final vehicleId = const Uuid().v4();

    final aggregate = VehicleAggregate._(
      vehicleId: vehicleId,
      householdId: householdId,
      ownerId: ownerId,
      makeModel: makeModel,
      registrationNumber: registration,
      isArchived: false,
      serviceRecords: const [],
    );

    final event = VehicleRegistered(
      vehicleId: vehicleId,
      householdId: householdId,
      ownerId: ownerId,
      ownerName: ownerName,
      makeModel: makeModel,
    );

    return (aggregate: aggregate, events: [event]);
  }

  ({VehicleAggregate aggregate, List<VehicleEvent> events}) recordService({
    required String actorId,
    required String actorName,
    required Odometer odometer,
    required String description,
    DocumentReference? invoiceReference,
  }) {
    if (isArchived) throw Exception('Cannot add service record to an archived vehicle.');
    if (odometer.isLessThan(maxOdometer)) {
      throw Exception('Monotonic Violation: Service odometer reading cannot be less than the current max reading.');
    }

    final newRecord = ServiceRecord(
      recordedAt: DateTime.now().toUtc(),
      odometer: odometer,
      description: description,
      invoiceReference: invoiceReference,
    );

    final event = ServiceRecorded(
      vehicleId: vehicleId,
      householdId: householdId,
      actorId: actorId,
      actorName: actorName,
      makeModel: makeModel,
      odometerReading: odometer.reading,
    );

    return (
      aggregate: copyWith(
        serviceRecords: List.unmodifiable([...serviceRecords, newRecord]),
      ),
      events: [event],
    );
  }

  VehicleAggregate copyWith({
    bool? isArchived,
    List<ServiceRecord>? serviceRecords,
    DocumentReference? insuranceReference,
  }) {
    return VehicleAggregate._(
      vehicleId: vehicleId,
      householdId: householdId,
      ownerId: ownerId,
      makeModel: makeModel,
      registrationNumber: registrationNumber,
      isArchived: isArchived ?? this.isArchived,
      serviceRecords: serviceRecords ?? this.serviceRecords,
      insuranceReference: insuranceReference ?? this.insuranceReference,
    );
  }
}
