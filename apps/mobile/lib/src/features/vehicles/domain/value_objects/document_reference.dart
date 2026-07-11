import 'package:flutter/foundation.dart';

@immutable
class DocumentReference {
  const DocumentReference(this.documentId);

  final String documentId;

  Map<String, dynamic> toJson() => {'documentId': documentId};
}
