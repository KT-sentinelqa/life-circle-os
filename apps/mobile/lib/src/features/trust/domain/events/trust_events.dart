import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';
import 'package:lifecircle_mobile/src/features/events/application/timeline_subscriber.dart';

abstract class TrustEvent implements DomainEvent {
  TrustEvent({
    required this.networkId,
  })  : eventId = const Uuid().v4(),
        timestamp = DateTime.now().toUtc();

  @override
  final String eventId;
  final String networkId;
  @override
  final DateTime timestamp;

  @override
  String get aggregateId => networkId;
}

class TrustedContactAdded extends TrustEvent implements TimelineRoutableEvent {
  TrustedContactAdded({
    required super.networkId,
    required this.householdId,
    required this.ownerId,
    required this.ownerName,
    required this.contactName,
  });

  @override
  final String householdId;
  final String ownerId;
  final String ownerName;
  final String contactName;

  @override
  String get actorId => ownerId;
  @override
  String get actorName => ownerName;
  @override
  String get activityTypeName => 'trusted_contact_added';

  @override
  Map<String, dynamic> toJson() => {
    'eventType': 'TrustedContactAdded',
    'householdId': householdId,
    'ownerId': ownerId,
    'contactName': contactName,
  };
}

class EmergencyProfileActivated extends TrustEvent implements TimelineRoutableEvent {
  EmergencyProfileActivated({
    required super.networkId,
    required this.householdId,
    required this.ownerId,
    required this.ownerName,
  });

  @override
  final String householdId;
  final String ownerId;
  final String ownerName;

  @override
  String get actorId => ownerId;
  @override
  String get actorName => ownerName;
  @override
  String get activityTypeName => 'emergency_profile_activated';

  @override
  Map<String, dynamic> toJson() => {
    'eventType': 'EmergencyProfileActivated',
    'householdId': householdId,
    'ownerId': ownerId,
  };
}
