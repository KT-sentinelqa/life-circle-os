// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outbox_entry_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OutboxEntryEntity _$OutboxEntryEntityFromJson(Map<String, dynamic> json) {
  return _OutboxEntryEntity.fromJson(json);
}

/// @nodoc
mixin _$OutboxEntryEntity {
  String get id => throw _privateConstructorUsedError;
  String get aggregateId => throw _privateConstructorUsedError;
  String get aggregateType => throw _privateConstructorUsedError;
  String get operationType => throw _privateConstructorUsedError;
  String get payload => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  int get retryCount => throw _privateConstructorUsedError;
  DateTime? get nextRetryAt => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  String get operationId => throw _privateConstructorUsedError;
  SyncStatusEntity get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutboxEntryEntityCopyWith<OutboxEntryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutboxEntryEntityCopyWith<$Res> {
  factory $OutboxEntryEntityCopyWith(
          OutboxEntryEntity value, $Res Function(OutboxEntryEntity) then) =
      _$OutboxEntryEntityCopyWithImpl<$Res, OutboxEntryEntity>;
  @useResult
  $Res call(
      {String id,
      String aggregateId,
      String aggregateType,
      String operationType,
      String payload,
      DateTime createdAt,
      DateTime updatedAt,
      int retryCount,
      DateTime? nextRetryAt,
      String deviceId,
      String operationId,
      SyncStatusEntity status});
}

/// @nodoc
class _$OutboxEntryEntityCopyWithImpl<$Res, $Val extends OutboxEntryEntity>
    implements $OutboxEntryEntityCopyWith<$Res> {
  _$OutboxEntryEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? aggregateId = null,
    Object? aggregateType = null,
    Object? operationType = null,
    Object? payload = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? retryCount = null,
    Object? nextRetryAt = freezed,
    Object? deviceId = null,
    Object? operationId = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      aggregateId: null == aggregateId
          ? _value.aggregateId
          : aggregateId // ignore: cast_nullable_to_non_nullable
              as String,
      aggregateType: null == aggregateType
          ? _value.aggregateType
          : aggregateType // ignore: cast_nullable_to_non_nullable
              as String,
      operationType: null == operationType
          ? _value.operationType
          : operationType // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      nextRetryAt: freezed == nextRetryAt
          ? _value.nextRetryAt
          : nextRetryAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      operationId: null == operationId
          ? _value.operationId
          : operationId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SyncStatusEntity,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutboxEntryEntityImplCopyWith<$Res>
    implements $OutboxEntryEntityCopyWith<$Res> {
  factory _$$OutboxEntryEntityImplCopyWith(_$OutboxEntryEntityImpl value,
          $Res Function(_$OutboxEntryEntityImpl) then) =
      __$$OutboxEntryEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String aggregateId,
      String aggregateType,
      String operationType,
      String payload,
      DateTime createdAt,
      DateTime updatedAt,
      int retryCount,
      DateTime? nextRetryAt,
      String deviceId,
      String operationId,
      SyncStatusEntity status});
}

/// @nodoc
class __$$OutboxEntryEntityImplCopyWithImpl<$Res>
    extends _$OutboxEntryEntityCopyWithImpl<$Res, _$OutboxEntryEntityImpl>
    implements _$$OutboxEntryEntityImplCopyWith<$Res> {
  __$$OutboxEntryEntityImplCopyWithImpl(_$OutboxEntryEntityImpl _value,
      $Res Function(_$OutboxEntryEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? aggregateId = null,
    Object? aggregateType = null,
    Object? operationType = null,
    Object? payload = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? retryCount = null,
    Object? nextRetryAt = freezed,
    Object? deviceId = null,
    Object? operationId = null,
    Object? status = null,
  }) {
    return _then(_$OutboxEntryEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      aggregateId: null == aggregateId
          ? _value.aggregateId
          : aggregateId // ignore: cast_nullable_to_non_nullable
              as String,
      aggregateType: null == aggregateType
          ? _value.aggregateType
          : aggregateType // ignore: cast_nullable_to_non_nullable
              as String,
      operationType: null == operationType
          ? _value.operationType
          : operationType // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      nextRetryAt: freezed == nextRetryAt
          ? _value.nextRetryAt
          : nextRetryAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      operationId: null == operationId
          ? _value.operationId
          : operationId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SyncStatusEntity,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutboxEntryEntityImpl implements _OutboxEntryEntity {
  const _$OutboxEntryEntityImpl(
      {required this.id,
      required this.aggregateId,
      required this.aggregateType,
      required this.operationType,
      required this.payload,
      required this.createdAt,
      required this.updatedAt,
      required this.retryCount,
      this.nextRetryAt,
      required this.deviceId,
      required this.operationId,
      required this.status});

  factory _$OutboxEntryEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutboxEntryEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String aggregateId;
  @override
  final String aggregateType;
  @override
  final String operationType;
  @override
  final String payload;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final int retryCount;
  @override
  final DateTime? nextRetryAt;
  @override
  final String deviceId;
  @override
  final String operationId;
  @override
  final SyncStatusEntity status;

  @override
  String toString() {
    return 'OutboxEntryEntity(id: $id, aggregateId: $aggregateId, aggregateType: $aggregateType, operationType: $operationType, payload: $payload, createdAt: $createdAt, updatedAt: $updatedAt, retryCount: $retryCount, nextRetryAt: $nextRetryAt, deviceId: $deviceId, operationId: $operationId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutboxEntryEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.aggregateId, aggregateId) ||
                other.aggregateId == aggregateId) &&
            (identical(other.aggregateType, aggregateType) ||
                other.aggregateType == aggregateType) &&
            (identical(other.operationType, operationType) ||
                other.operationType == operationType) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount) &&
            (identical(other.nextRetryAt, nextRetryAt) ||
                other.nextRetryAt == nextRetryAt) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.operationId, operationId) ||
                other.operationId == operationId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      aggregateId,
      aggregateType,
      operationType,
      payload,
      createdAt,
      updatedAt,
      retryCount,
      nextRetryAt,
      deviceId,
      operationId,
      status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutboxEntryEntityImplCopyWith<_$OutboxEntryEntityImpl> get copyWith =>
      __$$OutboxEntryEntityImplCopyWithImpl<_$OutboxEntryEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutboxEntryEntityImplToJson(
      this,
    );
  }
}

abstract class _OutboxEntryEntity implements OutboxEntryEntity {
  const factory _OutboxEntryEntity(
      {required final String id,
      required final String aggregateId,
      required final String aggregateType,
      required final String operationType,
      required final String payload,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final int retryCount,
      final DateTime? nextRetryAt,
      required final String deviceId,
      required final String operationId,
      required final SyncStatusEntity status}) = _$OutboxEntryEntityImpl;

  factory _OutboxEntryEntity.fromJson(Map<String, dynamic> json) =
      _$OutboxEntryEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get aggregateId;
  @override
  String get aggregateType;
  @override
  String get operationType;
  @override
  String get payload;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  int get retryCount;
  @override
  DateTime? get nextRetryAt;
  @override
  String get deviceId;
  @override
  String get operationId;
  @override
  SyncStatusEntity get status;
  @override
  @JsonKey(ignore: true)
  _$$OutboxEntryEntityImplCopyWith<_$OutboxEntryEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
