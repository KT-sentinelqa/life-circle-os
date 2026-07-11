import 'package:flutter/foundation.dart';

@immutable
class DueDate {
  const DueDate(this.date, {this.gracePeriodDays = 0});

  final DateTime date;
  final int gracePeriodDays;

  bool get isOverdue {
    final effectiveDue = date.add(Duration(days: gracePeriodDays));
    return DateTime.now().isAfter(effectiveDue);
  }

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'gracePeriodDays': gracePeriodDays,
  };
}
