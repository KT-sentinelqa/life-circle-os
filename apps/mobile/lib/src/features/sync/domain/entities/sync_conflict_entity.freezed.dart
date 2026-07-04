// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_conflict_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SyncConflictEntity _$SyncConflictEntityFromJson(Map<String, dynamic> json) {
  return _SyncConflictEntity.fromJson(json);
}

/// @nodoc
mixin _$SyncConflictEntity {
  DateTime get serverTimestamp => throw _privateConstructorUsedError;
  DateTime get clientTimestamp => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  String get operationId => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SyncConflictEntityCopyWith<SyncConflictEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncConflictEntityCopyWith<$Res> {
  factory $SyncConflictEntityCopyWith(
          SyncConflictEntity value, $Res Function(SyncConflictEntity) then) =
      _$SyncConflictEntityCopyWithImpl<$Res, SyncConflictEntity>;
  @useResult
  $Res call(
      {DateTime serverTimestamp,
      DateTime clientTimestamp,
      String deviceId,
      String operationId,
      int version});
}

/// @nodoc
class _$SyncConflictEntityCopyWithImpl<$Res, $Val extends SyncConflictEntity>
    implements $SyncConflictEntityCopyWith<$Res> {
  _$SyncConflictEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverTimestamp = null,
    Object? clientTimestamp = null,
    Object? deviceId = null,
    Object? operationId = null,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      serverTimestamp: null == serverTimestamp
          ? _value.serverTimestamp
          : serverTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      clientTimestamp: null == clientTimestamp
          ? _value.clientTimestamp
          : clientTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      operationId: null == operationId
          ? _value.operationId
          : operationId // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncConflictEntityImplCopyWith<$Res>
    implements $SyncConflictEntityCopyWith<$Res> {
  factory _$$SyncConflictEntityImplCopyWith(_$SyncConflictEntityImpl value,
          $Res Function(_$SyncConflictEntityImpl) then) =
      __$$SyncConflictEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime serverTimestamp,
      DateTime clientTimestamp,
      String deviceId,
      String operationId,
      int version});
}

/// @nodoc
class __$$SyncConflictEntityImplCopyWithImpl<$Res>
    extends _$SyncConflictEntityCopyWithImpl<$Res, _$SyncConflictEntityImpl>
    implements _$$SyncConflictEntityImplCopyWith<$Res> {
  __$$SyncConflictEntityImplCopyWithImpl(_$SyncConflictEntityImpl _value,
      $Res Function(_$SyncConflictEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverTimestamp = null,
    Object? clientTimestamp = null,
    Object? deviceId = null,
    Object? operationId = null,
    Object? version = null,
  }) {
    return _then(_$SyncConflictEntityImpl(
      serverTimestamp: null == serverTimestamp
          ? _value.serverTimestamp
          : serverTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      clientTimestamp: null == clientTimestamp
          ? _value.clientTimestamp
          : clientTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      operationId: null == operationId
          ? _value.operationId
          : operationId // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncConflictEntityImpl implements _SyncConflictEntity {
  const _$SyncConflictEntityImpl(
      {required this.serverTimestamp,
      required this.clientTimestamp,
      required this.deviceId,
      required this.operationId,
      required this.version});

  factory _$SyncConflictEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncConflictEntityImplFromJson(json);

  @override
  final DateTime serverTimestamp;
  @override
  final DateTime clientTimestamp;
  @override
  final String deviceId;
  @override
  final String operationId;
  @override
  final int version;

  @override
  String toString() {
    return 'SyncConflictEntity(serverTimestamp: $serverTimestamp, clientTimestamp: $clientTimestamp, deviceId: $deviceId, operationId: $operationId, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncConflictEntityImpl &&
            (identical(other.serverTimestamp, serverTimestamp) ||
                other.serverTimestamp == serverTimestamp) &&
            (identical(other.clientTimestamp, clientTimestamp) ||
                other.clientTimestamp == clientTimestamp) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.operationId, operationId) ||
                other.operationId == operationId) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, serverTimestamp, clientTimestamp,
      deviceId, operationId, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncConflictEntityImplCopyWith<_$SyncConflictEntityImpl> get copyWith =>
      __$$SyncConflictEntityImplCopyWithImpl<_$SyncConflictEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncConflictEntityImplToJson(
      this,
    );
  }
}

abstract class _SyncConflictEntity implements SyncConflictEntity {
  const factory _SyncConflictEntity(
      {required final DateTime serverTimestamp,
      required final DateTime clientTimestamp,
      required final String deviceId,
      required final String operationId,
      required final int version}) = _$SyncConflictEntityImpl;

  factory _SyncConflictEntity.fromJson(Map<String, dynamic> json) =
      _$SyncConflictEntityImpl.fromJson;

  @override
  DateTime get serverTimestamp;
  @override
  DateTime get clientTimestamp;
  @override
  String get deviceId;
  @override
  String get operationId;
  @override
  int get version;
  @override
  @JsonKey(ignore: true)
  _$$SyncConflictEntityImplCopyWith<_$SyncConflictEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
