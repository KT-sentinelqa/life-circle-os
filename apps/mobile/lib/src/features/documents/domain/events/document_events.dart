import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';
import 'package:lifecircle_mobile/src/features/events/application/timeline_subscriber.dart';

abstract class DocumentEvent implements DomainEvent {
  DocumentEvent({
    required this.documentId,
  })  : eventId = const Uuid().v4(),
        timestamp = DateTime.now().toUtc();

  @override
  final String eventId;
  final String documentId;
  @override
  final DateTime timestamp;

  @override
  String get aggregateId => documentId;
}

class DocumentUploaded extends DocumentEvent implements TimelineRoutableEvent {
  DocumentUploaded({
    required super.documentId,
    required this.householdId,
    required this.ownerId,
    required this.ownerName,
    required this.documentName,
  });

  @override
  final String householdId;
  final String ownerId;
  final String ownerName;
  final String documentName;

  @override
  String get actorId => ownerId;
  @override
  String get actorName => ownerName;
  @override
  String get activityTypeName => 'document_uploaded';

  @override
  Map<String, dynamic> toJson() => {
    'eventType': 'DocumentUploaded',
    'householdId': householdId,
    'ownerId': ownerId,
    'documentName': documentName,
  };
}

class DocumentReplaced extends DocumentEvent implements TimelineRoutableEvent {
  DocumentReplaced({
    required super.documentId,
    required this.householdId,
    required this.ownerId,
    required this.ownerName,
    required this.documentName,
    required this.newVersionNumber,
  });

  @override
  final String householdId;
  final String ownerId;
  final String ownerName;
  final String documentName;
  final int newVersionNumber;

  @override
  String get actorId => ownerId;
  @override
  String get actorName => ownerName;
  @override
  String get activityTypeName => 'document_replaced';

  @override
  Map<String, dynamic> toJson() => {
    'eventType': 'DocumentReplaced',
    'householdId': householdId,
    'ownerId': ownerId,
    'documentName': documentName,
    'newVersionNumber': newVersionNumber,
  };
}

class DocumentExpired extends DocumentEvent {
  DocumentExpired({
    required super.documentId,
    required this.householdId,
    required this.documentName,
  });

  final String householdId;
  final String documentName;

  @override
  Map<String, dynamic> toJson() => {
    'eventType': 'DocumentExpired',
    'householdId': householdId,
    'documentName': documentName,
  };
}
