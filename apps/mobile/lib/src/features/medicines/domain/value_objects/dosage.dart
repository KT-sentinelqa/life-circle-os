import 'package:flutter/foundation.dart';

@immutable
class Dosage {
  const Dosage({
    required this.amount,
    required this.unit,
  });

  final double amount;
  final String unit; // e.g. 'mg', 'ml', 'tablet'

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'unit': unit,
  };
}
