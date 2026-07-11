import 'package:flutter/foundation.dart';

enum CycleType { monthly, quarterly, semiAnnually, annually }

@immutable
class BillingCycle {
  const BillingCycle(this.type);

  final CycleType type;

  Map<String, dynamic> toJson() => {
    'type': type.name,
  };
}
