// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_event_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SyncEventEntity {
  SyncEventType get type => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get jobId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SyncEventEntityCopyWith<SyncEventEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncEventEntityCopyWith<$Res> {
  factory $SyncEventEntityCopyWith(
          SyncEventEntity value, $Res Function(SyncEventEntity) then) =
      _$SyncEventEntityCopyWithImpl<$Res, SyncEventEntity>;
  @useResult
  $Res call(
      {SyncEventType type, DateTime timestamp, String? message, String? jobId});
}

/// @nodoc
class _$SyncEventEntityCopyWithImpl<$Res, $Val extends SyncEventEntity>
    implements $SyncEventEntityCopyWith<$Res> {
  _$SyncEventEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? timestamp = null,
    Object? message = freezed,
    Object? jobId = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SyncEventType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      jobId: freezed == jobId
          ? _value.jobId
          : jobId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncEventEntityImplCopyWith<$Res>
    implements $SyncEventEntityCopyWith<$Res> {
  factory _$$SyncEventEntityImplCopyWith(_$SyncEventEntityImpl value,
          $Res Function(_$SyncEventEntityImpl) then) =
      __$$SyncEventEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SyncEventType type, DateTime timestamp, String? message, String? jobId});
}

/// @nodoc
class __$$SyncEventEntityImplCopyWithImpl<$Res>
    extends _$SyncEventEntityCopyWithImpl<$Res, _$SyncEventEntityImpl>
    implements _$$SyncEventEntityImplCopyWith<$Res> {
  __$$SyncEventEntityImplCopyWithImpl(
      _$SyncEventEntityImpl _value, $Res Function(_$SyncEventEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? timestamp = null,
    Object? message = freezed,
    Object? jobId = freezed,
  }) {
    return _then(_$SyncEventEntityImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SyncEventType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      jobId: freezed == jobId
          ? _value.jobId
          : jobId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SyncEventEntityImpl implements _SyncEventEntity {
  const _$SyncEventEntityImpl(
      {required this.type, required this.timestamp, this.message, this.jobId});

  @override
  final SyncEventType type;
  @override
  final DateTime timestamp;
  @override
  final String? message;
  @override
  final String? jobId;

  @override
  String toString() {
    return 'SyncEventEntity(type: $type, timestamp: $timestamp, message: $message, jobId: $jobId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncEventEntityImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.jobId, jobId) || other.jobId == jobId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, timestamp, message, jobId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncEventEntityImplCopyWith<_$SyncEventEntityImpl> get copyWith =>
      __$$SyncEventEntityImplCopyWithImpl<_$SyncEventEntityImpl>(
          this, _$identity);
}

abstract class _SyncEventEntity implements SyncEventEntity {
  const factory _SyncEventEntity(
      {required final SyncEventType type,
      required final DateTime timestamp,
      final String? message,
      final String? jobId}) = _$SyncEventEntityImpl;

  @override
  SyncEventType get type;
  @override
  DateTime get timestamp;
  @override
  String? get message;
  @override
  String? get jobId;
  @override
  @JsonKey(ignore: true)
  _$$SyncEventEntityImplCopyWith<_$SyncEventEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
