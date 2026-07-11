import 'package:flutter/foundation.dart';

@immutable
class Timezone {
  const Timezone(this.value) : assert(value.length > 2);
  final String value; // e.g., 'America/New_York'
}
