import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_conflict_entity.freezed.dart';
part 'sync_conflict_entity.g.dart';

/// Represents a detected conflict between local and remote state.
@freezed
class SyncConflictEntity with _$SyncConflictEntity {
  /// Creates a new [SyncConflictEntity].
  const factory SyncConflictEntity({
    required DateTime serverTimestamp,
    required DateTime clientTimestamp,
    required String deviceId,
    required String operationId,
    required int version,
  }) = _SyncConflictEntity;

  /// Restores a [SyncConflictEntity] from a JSON map.
  factory SyncConflictEntity.fromJson(Map<String, dynamic> json) =>
      _$SyncConflictEntityFromJson(json);
}
