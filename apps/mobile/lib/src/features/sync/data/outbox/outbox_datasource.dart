import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/features/sync/data/outbox/outbox_entry_model.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_status_entity.dart';

class OutboxDatasource {
  final DatabaseService _dbService;

  OutboxDatasource(this._dbService);

  Future<void> save(IsarOutboxEntry entry) async {
    await _dbService.db.writeTxn(() async {
      await _dbService.db.isarOutboxEntrys.put(entry);
    });
  }

  Future<List<IsarOutboxEntry>> getPending() async {
    return _dbService.db.isarOutboxEntrys
        .filter()
        .statusEqualTo(SyncStatusEntity.pending)
        .or()
        .statusEqualTo(SyncStatusEntity.failed)
        .sortByCreatedAt()
        .findAll();
  }

  Future<IsarOutboxEntry?> getById(String id) async {
    return _dbService.db.isarOutboxEntrys.filter().idEqualTo(id).findFirst();
  }
}
