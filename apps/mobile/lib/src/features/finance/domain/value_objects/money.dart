import 'package:flutter/foundation.dart';

@immutable
class Money {
  const Money({
    required this.amount,
    required this.currencyCode,
  });

  final double amount;
  final String currencyCode; // e.g. 'INR', 'USD'

  Money add(Money other) {
    if (currencyCode != other.currencyCode) {
      throw Exception('Currency mismatch: Cannot add $currencyCode and ${other.currencyCode}');
    }
    return Money(amount: amount + other.amount, currencyCode: currencyCode);
  }

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'currencyCode': currencyCode,
  };
}
