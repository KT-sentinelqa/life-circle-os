import 'package:isar/isar.dart';

import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/features/sync/data/outbox/outbox_entry_model.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_status_entity.dart';

/// Provides direct Isar database access for outbox entries.
class OutboxDatasource {
  /// Creates an [OutboxDatasource] with the given [DatabaseService].
  OutboxDatasource(this._dbService);

  final DatabaseService _dbService;

  /// Saves an outbox entry to the database within a transaction.
  Future<void> save(IsarOutboxEntry entry) async {
    await _dbService.db.writeTxn(() async {
      await _dbService.db.isarOutboxEntrys.put(entry);
    });
  }

  /// Retrieves all pending and failed outbox entries, sorted by creation time.
  Future<List<IsarOutboxEntry>> getPending() async {
    return _dbService.db.isarOutboxEntrys
        .filter()
        .statusEqualTo(SyncStatusEntity.pending)
        .or()
        .statusEqualTo(SyncStatusEntity.failed)
        .sortByCreatedAt()
        .findAll();
  }

  /// Retrieves a specific outbox entry by its external identifier.
  Future<IsarOutboxEntry?> getById(String id) async {
    return _dbService.db.isarOutboxEntrys.filter().idEqualTo(id).findFirst();
  }
}
