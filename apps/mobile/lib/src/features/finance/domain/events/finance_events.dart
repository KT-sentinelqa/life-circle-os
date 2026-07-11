import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';
import 'package:lifecircle_mobile/src/features/events/application/timeline_subscriber.dart';

abstract class FinanceEvent implements DomainEvent {
  FinanceEvent({
    required this.aggregateId,
  })  : eventId = const Uuid().v4(),
        timestamp = DateTime.now().toUtc();

  @override
  final String eventId;
  @override
  final String aggregateId;
  @override
  final DateTime timestamp;
}

class BillCreated extends FinanceEvent implements TimelineRoutableEvent {
  BillCreated({
    required super.aggregateId,
    required this.householdId,
    required this.actorId,
    required this.actorName,
    required this.billName,
    required this.amount,
  });

  @override
  final String householdId;
  @override
  final String actorId;
  @override
  final String actorName;
  final String billName;
  final double amount;

  @override
  String get activityTypeName => 'bill_created';

  @override
  Map<String, dynamic> toJson() => {
    'eventType': 'BillCreated',
    'householdId': householdId,
    'actorId': actorId,
    'billName': billName,
    'amount': amount,
  };
}

class BillPaid extends FinanceEvent implements TimelineRoutableEvent {
  BillPaid({
    required super.aggregateId,
    required this.householdId,
    required this.actorId,
    required this.actorName,
    required this.billName,
  });

  @override
  final String householdId;
  @override
  final String actorId;
  @override
  final String actorName;
  final String billName;

  @override
  String get activityTypeName => 'bill_paid';

  @override
  Map<String, dynamic> toJson() => {
    'eventType': 'BillPaid',
    'householdId': householdId,
    'actorId': actorId,
    'billName': billName,
  };
}

class InsuranceExpired extends FinanceEvent {
  InsuranceExpired({
    required super.aggregateId,
    required this.householdId,
    required this.policyName,
  });

  final String householdId;
  final String policyName;

  @override
  Map<String, dynamic> toJson() => {
    'eventType': 'InsuranceExpired',
    'householdId': householdId,
    'policyName': policyName,
  };
}
