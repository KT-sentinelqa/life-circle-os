import 'package:flutter/foundation.dart';

@immutable
class Currency {
  const Currency(this.code) : assert(code.length == 3);
  final String code; // e.g., 'USD', 'EUR'
}
