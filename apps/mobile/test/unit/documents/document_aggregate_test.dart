import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/documents/domain/value_objects/document_type.dart';
import 'package:lifecircle_mobile/src/features/documents/domain/value_objects/document_status.dart';
import 'package:lifecircle_mobile/src/features/documents/domain/value_objects/expiry_date.dart';
import 'package:lifecircle_mobile/src/features/documents/domain/value_objects/storage_reference.dart';
import 'package:lifecircle_mobile/src/features/documents/domain/aggregates/document_aggregate.dart';
import 'package:lifecircle_mobile/src/features/documents/domain/events/document_events.dart';

void main() {
  group('Phase 3B Sprint 3: Document Aggregate', () {
    late StorageReference dummyStorage1;
    late StorageReference dummyStorage2;

    setUp(() {
      dummyStorage1 = const StorageReference(
        provider: 'mock_provider',
        uri: 'mock/path/doc1.pdf',
        checksum: 'abc123hash',
      );
      dummyStorage2 = const StorageReference(
        provider: 'mock_provider',
        uri: 'mock/path/doc2.pdf',
        checksum: 'def456hash',
      );
    });

    test('Uploading document creates active version 1 and yields DocumentUploaded', () {
      final result = DocumentAggregate.uploadNew(
        householdId: 'hh_1',
        ownerId: 'mem_1',
        ownerName: 'Krishna',
        name: 'Passport',
        type: const DocumentType('identity'),
        storage: dummyStorage1,
      );

      expect(result.aggregate.versions.length, 1);
      expect(result.aggregate.activeVersion.versionNumber, 1);
      expect(result.aggregate.status, DocumentStatus.active);
      expect(result.events.length, 1);
      expect(result.events.first, isA<DocumentUploaded>());
    });

    test('Replacing document appends version 2 and yields DocumentReplaced', () {
      final init = DocumentAggregate.uploadNew(
        householdId: 'hh_1',
        ownerId: 'mem_1',
        ownerName: 'Krishna',
        name: 'Passport',
        type: const DocumentType('identity'),
        storage: dummyStorage1,
      );

      final result = init.aggregate.replaceVersion(
        ownerName: 'Krishna',
        newStorage: dummyStorage2,
      );

      expect(result.aggregate.versions.length, 2);
      expect(result.aggregate.activeVersion.versionNumber, 2);
      expect(result.aggregate.activeVersion.storage.checksum, 'def456hash');
      
      expect(result.events.length, 1);
      expect(result.events.first, isA<DocumentReplaced>());
      
      final event = result.events.first as DocumentReplaced;
      expect(event.newVersionNumber, 2);
    });

    test('Cannot replace an archived document', () {
      final init = DocumentAggregate.uploadNew(
        householdId: 'hh_1',
        ownerId: 'mem_1',
        ownerName: 'Krishna',
        name: 'Old Prescription',
        type: const DocumentType('prescription'),
        storage: dummyStorage1,
      );

      final archived = init.aggregate.copyWith(status: DocumentStatus.archived);

      expect(
        () => archived.replaceVersion(
          ownerName: 'Krishna',
          newStorage: dummyStorage2,
        ),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('archived'))),
      );
    });

    test('ExpiryDate computes isExpired accurately', () {
      final pastDate = ExpiryDate(DateTime.now().subtract(const Duration(days: 1)));
      final futureDate = ExpiryDate(DateTime.now().add(const Duration(days: 1)));

      expect(pastDate.isExpired, isTrue);
      expect(futureDate.isExpired, isFalse);
    });
  });
}
