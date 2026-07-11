import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/finance/domain/value_objects/money.dart';
import 'package:lifecircle_mobile/src/features/finance/domain/value_objects/due_date.dart';

@immutable
class EMIAggregate {
  const EMIAggregate._({
    required this.emiId,
    required this.householdId,
    required this.loanName,
    required this.installmentAmount,
    required this.totalInstallments,
    required this.installmentsPaid,
    required this.nextDueDate,
  });

  final String emiId;
  final String householdId;
  final String loanName;
  final Money installmentAmount;
  final int totalInstallments;
  final int installmentsPaid;
  final DueDate nextDueDate;

  // Real logic would be similar to BillAggregate. Kept minimal for Sprint 2.
}
