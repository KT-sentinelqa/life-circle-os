import 'package:flutter/foundation.dart';

enum MeasurementSystemType {
  metric,
  imperial,
}

@immutable
class MeasurementSystem {
  const MeasurementSystem(this.type);
  final MeasurementSystemType type;
}
