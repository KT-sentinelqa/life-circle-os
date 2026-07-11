import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/finance/domain/value_objects/money.dart';
import 'package:lifecircle_mobile/src/features/finance/domain/value_objects/due_date.dart';
import 'package:lifecircle_mobile/src/features/finance/domain/aggregates/bill_aggregate.dart';
import 'package:lifecircle_mobile/src/features/finance/domain/events/finance_events.dart';

void main() {
  group('Phase 3B Sprint 2: Finance Domain', () {
    test('Money prevents adding mismatched currencies', () {
      final inr = const Money(amount: 100, currencyCode: 'INR');
      final usd = const Money(amount: 5, currencyCode: 'USD');

      expect(
        () => inr.add(usd),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('Currency mismatch'))),
      );
    });

    test('Money adds correctly for matching currencies', () {
      final m1 = const Money(amount: 100, currencyCode: 'INR');
      final m2 = const Money(amount: 50, currencyCode: 'INR');

      final result = m1.add(m2);
      expect(result.amount, 150.0);
      expect(result.currencyCode, 'INR');
    });

    test('BillAggregate creation yields BillCreated event', () {
      final result = BillAggregate.create(
        householdId: 'hh_1',
        actorId: 'usr_1',
        actorName: 'Krishna',
        name: 'Electricity Bill',
        amount: const Money(amount: 1200, currencyCode: 'INR'),
        dueDate: DueDate(DateTime.now()),
      );

      expect(result.aggregate.name, 'Electricity Bill');
      expect(result.aggregate.isPaid, isFalse);
      expect(result.events.length, 1);
      expect(result.events.first, isA<BillCreated>());
    });

    test('Paying a Bill transitions state and yields BillPaid event', () {
      final init = BillAggregate.create(
        householdId: 'hh_1',
        actorId: 'usr_1',
        actorName: 'Krishna',
        name: 'Water Bill',
        amount: const Money(amount: 500, currencyCode: 'INR'),
        dueDate: DueDate(DateTime.now()),
      );

      final paid = init.aggregate.markAsPaid(actorId: 'usr_1', actorName: 'Krishna');

      expect(paid.aggregate.isPaid, isTrue);
      expect(paid.events.length, 1);
      expect(paid.events.first, isA<BillPaid>());
    });

    test('Cannot pay an already paid Bill', () {
      final init = BillAggregate.create(
        householdId: 'hh_1',
        actorId: 'usr_1',
        actorName: 'Krishna',
        name: 'Water Bill',
        amount: const Money(amount: 500, currencyCode: 'INR'),
        dueDate: DueDate(DateTime.now()),
      );

      final paid = init.aggregate.markAsPaid(actorId: 'usr_1', actorName: 'Krishna');

      expect(
        () => paid.aggregate.markAsPaid(actorId: 'usr_1', actorName: 'Krishna'),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('already paid'))),
      );
    });
  });
}
