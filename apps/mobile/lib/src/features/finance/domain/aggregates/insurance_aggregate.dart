import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/finance/domain/events/finance_events.dart';

@immutable
class InsuranceAggregate {
  const InsuranceAggregate._({
    required this.policyId,
    required this.householdId,
    required this.policyName,
    required this.isExpired,
  });

  final String policyId;
  final String householdId;
  final String policyName;
  final bool isExpired;

  ({InsuranceAggregate aggregate, List<FinanceEvent> events}) markAsExpired() {
    if (isExpired) throw Exception('Insurance is already expired.');

    final event = InsuranceExpired(
      aggregateId: policyId,
      householdId: householdId,
      policyName: policyName,
    );

    return (
      aggregate: InsuranceAggregate._(
        policyId: policyId,
        householdId: householdId,
        policyName: policyName,
        isExpired: true,
      ),
      events: [event],
    );
  }
}
