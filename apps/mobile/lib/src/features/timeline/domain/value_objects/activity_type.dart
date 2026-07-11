import 'package:flutter/foundation.dart';

@immutable
class ActivityType {
  const ActivityType(this.name) : assert(name.length > 0);
  
  final String name; // e.g., 'medicine_taken', 'household_created'
}
