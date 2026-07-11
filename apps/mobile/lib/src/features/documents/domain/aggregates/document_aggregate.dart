import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/documents/domain/value_objects/document_type.dart';
import 'package:lifecircle_mobile/src/features/documents/domain/value_objects/document_status.dart';
import 'package:lifecircle_mobile/src/features/documents/domain/value_objects/expiry_date.dart';
import 'package:lifecircle_mobile/src/features/documents/domain/value_objects/storage_reference.dart';
import 'package:lifecircle_mobile/src/features/documents/domain/entities/document_version.dart';
import 'package:lifecircle_mobile/src/features/documents/domain/events/document_events.dart';

@immutable
class DocumentAggregate {
  const DocumentAggregate._({
    required this.documentId,
    required this.householdId,
    required this.ownerId,
    required this.name,
    required this.type,
    required this.status,
    this.expiryDate,
    required this.versions,
  });

  final String documentId;
  final String householdId;
  final String ownerId;
  final String name;
  final DocumentType type;
  final DocumentStatus status;
  final ExpiryDate? expiryDate;
  final List<DocumentVersion> versions;

  DocumentVersion get activeVersion => versions.last;

  static ({DocumentAggregate aggregate, List<DocumentEvent> events}) uploadNew({
    required String householdId,
    required String ownerId,
    required String ownerName,
    required String name,
    required DocumentType type,
    required StorageReference storage,
    ExpiryDate? expiryDate,
  }) {
    final documentId = const Uuid().v4();

    final initialVersion = DocumentVersion(
      versionId: const Uuid().v4(),
      uploadedAt: DateTime.now().toUtc(),
      storage: storage,
      versionNumber: 1,
    );

    final aggregate = DocumentAggregate._(
      documentId: documentId,
      householdId: householdId,
      ownerId: ownerId,
      name: name,
      type: type,
      status: DocumentStatus.active,
      expiryDate: expiryDate,
      versions: [initialVersion],
    );

    final event = DocumentUploaded(
      documentId: documentId,
      householdId: householdId,
      ownerId: ownerId,
      ownerName: ownerName,
      documentName: name,
    );

    return (aggregate: aggregate, events: [event]);
  }

  ({DocumentAggregate aggregate, List<DocumentEvent> events}) replaceVersion({
    required String ownerName,
    required StorageReference newStorage,
    ExpiryDate? newExpiryDate,
  }) {
    if (status == DocumentStatus.archived) {
      throw Exception('Cannot replace an archived document.');
    }

    final newVersion = DocumentVersion(
      versionId: const Uuid().v4(),
      uploadedAt: DateTime.now().toUtc(),
      storage: newStorage,
      versionNumber: activeVersion.versionNumber + 1,
    );

    final event = DocumentReplaced(
      documentId: documentId,
      householdId: householdId,
      ownerId: ownerId,
      ownerName: ownerName,
      documentName: name,
      newVersionNumber: newVersion.versionNumber,
    );

    return (
      aggregate: copyWith(
        versions: List.unmodifiable([...versions, newVersion]),
        expiryDate: newExpiryDate ?? expiryDate,
        status: DocumentStatus.active, // Clears expired state if replacing
      ),
      events: [event],
    );
  }

  DocumentAggregate copyWith({
    DocumentStatus? status,
    ExpiryDate? expiryDate,
    List<DocumentVersion>? versions,
  }) {
    return DocumentAggregate._(
      documentId: documentId,
      householdId: householdId,
      ownerId: ownerId,
      name: name,
      type: type,
      status: status ?? this.status,
      expiryDate: expiryDate ?? this.expiryDate,
      versions: versions ?? this.versions,
    );
  }
}
