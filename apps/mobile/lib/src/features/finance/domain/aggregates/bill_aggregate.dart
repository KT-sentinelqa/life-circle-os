import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/finance/domain/value_objects/money.dart';
import 'package:lifecircle_mobile/src/features/finance/domain/value_objects/due_date.dart';
import 'package:lifecircle_mobile/src/features/finance/domain/events/finance_events.dart';

@immutable
class BillAggregate {
  const BillAggregate._({
    required this.billId,
    required this.householdId,
    required this.name,
    required this.amount,
    required this.dueDate,
    required this.isPaid,
  });

  final String billId;
  final String householdId;
  final String name;
  final Money amount;
  final DueDate dueDate;
  final bool isPaid;

  static ({BillAggregate aggregate, List<FinanceEvent> events}) create({
    required String householdId,
    required String actorId,
    required String actorName,
    required String name,
    required Money amount,
    required DueDate dueDate,
  }) {
    final billId = const Uuid().v4();

    final aggregate = BillAggregate._(
      billId: billId,
      householdId: householdId,
      name: name,
      amount: amount,
      dueDate: dueDate,
      isPaid: false,
    );

    final event = BillCreated(
      aggregateId: billId,
      householdId: householdId,
      actorId: actorId,
      actorName: actorName,
      billName: name,
      amount: amount.amount,
    );

    return (aggregate: aggregate, events: [event]);
  }

  ({BillAggregate aggregate, List<FinanceEvent> events}) markAsPaid({
    required String actorId,
    required String actorName,
  }) {
    if (isPaid) throw Exception('Bill is already paid.');

    final event = BillPaid(
      aggregateId: billId,
      householdId: householdId,
      actorId: actorId,
      actorName: actorName,
      billName: name,
    );

    return (
      aggregate: copyWith(isPaid: true),
      events: [event],
    );
  }

  BillAggregate copyWith({
    bool? isPaid,
  }) {
    return BillAggregate._(
      billId: billId,
      householdId: householdId,
      name: name,
      amount: amount,
      dueDate: dueDate,
      isPaid: isPaid ?? this.isPaid,
    );
  }
}
