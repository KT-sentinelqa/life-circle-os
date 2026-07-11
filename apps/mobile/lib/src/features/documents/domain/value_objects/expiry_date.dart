import 'package:flutter/foundation.dart';

@immutable
class ExpiryDate {
  const ExpiryDate(this.date);

  final DateTime date;

  bool get isExpired => DateTime.now().toUtc().isAfter(date);

  Map<String, dynamic> toJson() => {'date': date.toIso8601String()};
}
