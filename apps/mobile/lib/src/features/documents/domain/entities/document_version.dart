import 'package:flutter/foundation.dart';
import 'package:lifecircle_mobile/src/features/documents/domain/value_objects/storage_reference.dart';

@immutable
class DocumentVersion {
  const DocumentVersion({
    required this.versionId,
    required this.uploadedAt,
    required this.storage,
    required this.versionNumber,
  });

  final String versionId;
  final DateTime uploadedAt;
  final StorageReference storage;
  final int versionNumber;
}
