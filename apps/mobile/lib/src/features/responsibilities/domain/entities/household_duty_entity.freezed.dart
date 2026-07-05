// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'household_duty_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HouseholdDutyEntity {
  String get id => throw _privateConstructorUsedError;
  String get assigneeId => throw _privateConstructorUsedError;
  String get assigneeName => throw _privateConstructorUsedError;
  String get taskName => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  String? get specialEventDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HouseholdDutyEntityCopyWith<HouseholdDutyEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HouseholdDutyEntityCopyWith<$Res> {
  factory $HouseholdDutyEntityCopyWith(
          HouseholdDutyEntity value, $Res Function(HouseholdDutyEntity) then) =
      _$HouseholdDutyEntityCopyWithImpl<$Res, HouseholdDutyEntity>;
  @useResult
  $Res call(
      {String id,
      String assigneeId,
      String assigneeName,
      String taskName,
      bool isCompleted,
      String? specialEventDate});
}

/// @nodoc
class _$HouseholdDutyEntityCopyWithImpl<$Res, $Val extends HouseholdDutyEntity>
    implements $HouseholdDutyEntityCopyWith<$Res> {
  _$HouseholdDutyEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? assigneeId = null,
    Object? assigneeName = null,
    Object? taskName = null,
    Object? isCompleted = null,
    Object? specialEventDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      assigneeId: null == assigneeId
          ? _value.assigneeId
          : assigneeId // ignore: cast_nullable_to_non_nullable
              as String,
      assigneeName: null == assigneeName
          ? _value.assigneeName
          : assigneeName // ignore: cast_nullable_to_non_nullable
              as String,
      taskName: null == taskName
          ? _value.taskName
          : taskName // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      specialEventDate: freezed == specialEventDate
          ? _value.specialEventDate
          : specialEventDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HouseholdDutyEntityImplCopyWith<$Res>
    implements $HouseholdDutyEntityCopyWith<$Res> {
  factory _$$HouseholdDutyEntityImplCopyWith(_$HouseholdDutyEntityImpl value,
          $Res Function(_$HouseholdDutyEntityImpl) then) =
      __$$HouseholdDutyEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String assigneeId,
      String assigneeName,
      String taskName,
      bool isCompleted,
      String? specialEventDate});
}

/// @nodoc
class __$$HouseholdDutyEntityImplCopyWithImpl<$Res>
    extends _$HouseholdDutyEntityCopyWithImpl<$Res, _$HouseholdDutyEntityImpl>
    implements _$$HouseholdDutyEntityImplCopyWith<$Res> {
  __$$HouseholdDutyEntityImplCopyWithImpl(_$HouseholdDutyEntityImpl _value,
      $Res Function(_$HouseholdDutyEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? assigneeId = null,
    Object? assigneeName = null,
    Object? taskName = null,
    Object? isCompleted = null,
    Object? specialEventDate = freezed,
  }) {
    return _then(_$HouseholdDutyEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      assigneeId: null == assigneeId
          ? _value.assigneeId
          : assigneeId // ignore: cast_nullable_to_non_nullable
              as String,
      assigneeName: null == assigneeName
          ? _value.assigneeName
          : assigneeName // ignore: cast_nullable_to_non_nullable
              as String,
      taskName: null == taskName
          ? _value.taskName
          : taskName // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      specialEventDate: freezed == specialEventDate
          ? _value.specialEventDate
          : specialEventDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$HouseholdDutyEntityImpl implements _HouseholdDutyEntity {
  const _$HouseholdDutyEntityImpl(
      {required this.id,
      required this.assigneeId,
      required this.assigneeName,
      required this.taskName,
      required this.isCompleted,
      this.specialEventDate});

  @override
  final String id;
  @override
  final String assigneeId;
  @override
  final String assigneeName;
  @override
  final String taskName;
  @override
  final bool isCompleted;
  @override
  final String? specialEventDate;

  @override
  String toString() {
    return 'HouseholdDutyEntity(id: $id, assigneeId: $assigneeId, assigneeName: $assigneeName, taskName: $taskName, isCompleted: $isCompleted, specialEventDate: $specialEventDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HouseholdDutyEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.assigneeId, assigneeId) ||
                other.assigneeId == assigneeId) &&
            (identical(other.assigneeName, assigneeName) ||
                other.assigneeName == assigneeName) &&
            (identical(other.taskName, taskName) ||
                other.taskName == taskName) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.specialEventDate, specialEventDate) ||
                other.specialEventDate == specialEventDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, assigneeId, assigneeName,
      taskName, isCompleted, specialEventDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HouseholdDutyEntityImplCopyWith<_$HouseholdDutyEntityImpl> get copyWith =>
      __$$HouseholdDutyEntityImplCopyWithImpl<_$HouseholdDutyEntityImpl>(
          this, _$identity);
}

abstract class _HouseholdDutyEntity implements HouseholdDutyEntity {
  const factory _HouseholdDutyEntity(
      {required final String id,
      required final String assigneeId,
      required final String assigneeName,
      required final String taskName,
      required final bool isCompleted,
      final String? specialEventDate}) = _$HouseholdDutyEntityImpl;

  @override
  String get id;
  @override
  String get assigneeId;
  @override
  String get assigneeName;
  @override
  String get taskName;
  @override
  bool get isCompleted;
  @override
  String? get specialEventDate;
  @override
  @JsonKey(ignore: true)
  _$$HouseholdDutyEntityImplCopyWith<_$HouseholdDutyEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
