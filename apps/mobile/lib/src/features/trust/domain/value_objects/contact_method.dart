import 'package:flutter/foundation.dart';

@immutable
class ContactMethod {
  const ContactMethod({
    required this.type,
    required this.value,
  });

  final String type; // e.g., 'phone', 'email'
  final String value;

  Map<String, dynamic> toJson() => {
    'type': type,
    'value': value,
  };
}
