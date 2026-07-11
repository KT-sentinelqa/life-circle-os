import 'package:flutter/foundation.dart';

@immutable
class RegistrationNumber {
  const RegistrationNumber(this.value) : assert(value.length >= 4, 'Invalid Registration');

  final String value;

  Map<String, dynamic> toJson() => {'value': value};
}
