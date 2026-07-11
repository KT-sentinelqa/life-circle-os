import 'package:flutter/foundation.dart';

@immutable
class EmergencyPriority {
  const EmergencyPriority(this.level) : assert(level > 0, 'Priority must be > 0');

  final int level; // 1 = highest priority

  bool isHigherPriorityThan(EmergencyPriority other) {
    return level < other.level;
  }

  Map<String, dynamic> toJson() => {'level': level};
}
