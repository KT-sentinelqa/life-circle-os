import 'package:flutter/foundation.dart';

@immutable
class DocumentType {
  const DocumentType(this.value);

  final String value; // e.g. 'identity', 'insurance', 'prescription'

  Map<String, dynamic> toJson() => {'value': value};
}
