import 'package:flutter/foundation.dart';

@immutable
class Odometer {
  const Odometer({required this.reading, required this.unit});

  final int reading;
  final String unit; // e.g. 'km', 'mi'

  bool isLessThan(Odometer other) {
    if (unit != other.unit) throw Exception('Unit mismatch');
    return reading < other.reading;
  }

  Map<String, dynamic> toJson() => {
    'reading': reading,
    'unit': unit,
  };
}
