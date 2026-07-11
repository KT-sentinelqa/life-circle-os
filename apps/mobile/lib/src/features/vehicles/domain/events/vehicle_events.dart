import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';
import 'package:lifecircle_mobile/src/features/events/application/timeline_subscriber.dart';

abstract class VehicleEvent implements DomainEvent {
  VehicleEvent({
    required this.vehicleId,
  })  : eventId = const Uuid().v4(),
        timestamp = DateTime.now().toUtc();

  @override
  final String eventId;
  final String vehicleId;
  @override
  final DateTime timestamp;

  @override
  String get aggregateId => vehicleId;
}

class VehicleRegistered extends VehicleEvent implements TimelineRoutableEvent {
  VehicleRegistered({
    required super.vehicleId,
    required this.householdId,
    required this.ownerId,
    required this.ownerName,
    required this.makeModel,
  });

  @override
  final String householdId;
  final String ownerId;
  final String ownerName;
  final String makeModel;

  @override
  String get actorId => ownerId;
  @override
  String get actorName => ownerName;
  @override
  String get activityTypeName => 'vehicle_registered';

  @override
  Map<String, dynamic> toJson() => {
    'eventType': 'VehicleRegistered',
    'householdId': householdId,
    'ownerId': ownerId,
    'makeModel': makeModel,
  };
}

class ServiceRecorded extends VehicleEvent implements TimelineRoutableEvent {
  ServiceRecorded({
    required super.vehicleId,
    required this.householdId,
    required this.actorId,
    required this.actorName,
    required this.makeModel,
    required this.odometerReading,
  });

  @override
  final String householdId;
  final String actorId;
  final String actorName;
  final String makeModel;
  final int odometerReading;

  @override
  String get actorId => actorId;
  @override
  String get actorName => actorName;
  @override
  String get activityTypeName => 'vehicle_service_recorded';

  @override
  Map<String, dynamic> toJson() => {
    'eventType': 'ServiceRecorded',
    'householdId': householdId,
    'actorId': actorId,
    'makeModel': makeModel,
    'odometerReading': odometerReading,
  };
}
