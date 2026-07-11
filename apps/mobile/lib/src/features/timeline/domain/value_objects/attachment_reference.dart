import 'package:flutter/foundation.dart';

@immutable
class AttachmentReference {
  const AttachmentReference({
    required this.uri,
    required this.mimeType,
  });

  final String uri;
  final String mimeType;
}
