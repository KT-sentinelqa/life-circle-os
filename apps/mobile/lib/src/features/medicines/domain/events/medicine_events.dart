import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';
import 'package:lifecircle_mobile/src/features/events/application/timeline_subscriber.dart';

abstract class MedicineEvent implements DomainEvent {
  MedicineEvent({
    required this.medicineId,
  })  : eventId = const Uuid().v4(),
        timestamp = DateTime.now().toUtc();

  @override
  final String eventId;
  final String medicineId;
  @override
  final DateTime timestamp;

  @override
  String get aggregateId => medicineId;
}

class MedicineAdded extends MedicineEvent {
  MedicineAdded({
    required super.medicineId,
    required this.householdId,
    required this.name,
    required this.patientId,
  });

  final String householdId;
  final String name;
  final String patientId;

  @override
  Map<String, dynamic> toJson() => {
    'eventType': 'MedicineAdded',
    'householdId': householdId,
    'name': name,
    'patientId': patientId,
  };
}

class MedicineTaken extends MedicineEvent implements TimelineRoutableEvent {
  MedicineTaken({
    required super.medicineId,
    required this.householdId,
    required this.patientId,
    required this.patientName,
    required this.medicineName,
  });

  @override
  final String householdId;
  final String patientId;
  final String patientName;
  final String medicineName;

  // TimelineRoutableEvent Implementation
  @override
  String get actorId => patientId;
  @override
  String get actorName => patientName;
  @override
  String get activityTypeName => 'medicine_taken';

  @override
  Map<String, dynamic> toJson() => {
    'eventType': 'MedicineTaken',
    'householdId': householdId,
    'patientId': patientId,
    'medicineName': medicineName,
  };
}

class MissedDoseRecorded extends MedicineEvent implements TimelineRoutableEvent {
  MissedDoseRecorded({
    required super.medicineId,
    required this.householdId,
    required this.patientId,
    required this.patientName,
    required this.medicineName,
  });

  @override
  final String householdId;
  final String patientId;
  final String patientName;
  final String medicineName;

  // TimelineRoutableEvent Implementation
  @override
  String get actorId => patientId;
  @override
  String get actorName => patientName;
  @override
  String get activityTypeName => 'medicine_missed';

  @override
  Map<String, dynamic> toJson() => {
    'eventType': 'MissedDoseRecorded',
    'householdId': householdId,
    'patientId': patientId,
    'medicineName': medicineName,
  };
}
