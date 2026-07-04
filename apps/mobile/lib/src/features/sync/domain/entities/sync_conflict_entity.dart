import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_conflict_entity.freezed.dart';
part 'sync_conflict_entity.g.dart';

@freezed
class SyncConflictEntity with _$SyncConflictEntity {
  const factory SyncConflictEntity({
    required DateTime serverTimestamp,
    required DateTime clientTimestamp,
    required String deviceId,
    required String operationId,
    required int version,
  }) = _SyncConflictEntity;

  factory SyncConflictEntity.fromJson(Map<String, dynamic> json) => _$SyncConflictEntityFromJson(json);
}
