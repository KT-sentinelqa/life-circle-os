import 'package:lifecircle_mobile/src/features/sync/data/outbox/outbox_datasource.dart';
import 'package:lifecircle_mobile/src/features/sync/data/outbox/outbox_entry_model.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/outbox_entry_entity.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_status_entity.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/repositories/sync_repository.dart';

/// Local implementation of the [SyncRepository] backed by Isar.
class LocalSyncRepository implements SyncRepository {
  /// Creates a [LocalSyncRepository] requiring a datasource.
  LocalSyncRepository(this._datasource);

  final OutboxDatasource _datasource;

  @override
  Future<void> enqueue(OutboxEntryEntity entry) async {
    final model = IsarOutboxEntry.fromDomain(entry);
    await _datasource.save(model);
  }

  @override
  Future<List<OutboxEntryEntity>> getPendingEntries() async {
    final models = await _datasource.getPending();
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<void> updateEntryStatus(
    String id,
    SyncStatusEntity status, {
    int? retryCount,
    DateTime? nextRetryAt,
  }) async {
    final entry = await _datasource.getById(id);
    if (entry == null) return;

    entry
      ..status = status
      ..updatedAt = DateTime.now();
    if (retryCount != null) {
      entry.retryCount = retryCount;
    }
    if (nextRetryAt != null) {
      entry.nextRetryAt = nextRetryAt;
    }
    await _datasource.save(entry);
  }
}
