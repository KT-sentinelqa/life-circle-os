import 'package:flutter/foundation.dart';

@immutable
class Schedule {
  const Schedule({
    required this.frequency,
    required this.timeOfDay,
  });

  final String frequency; // e.g. 'daily', 'weekly'
  final String timeOfDay; // e.g. '08:00', 'after_meals'

  Map<String, dynamic> toJson() => {
    'frequency': frequency,
    'timeOfDay': timeOfDay,
  };
}
