// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insurance_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InsuranceEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  DateTime get renewalDate => throw _privateConstructorUsedError;
  bool get isRenewed => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InsuranceEntityCopyWith<InsuranceEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsuranceEntityCopyWith<$Res> {
  factory $InsuranceEntityCopyWith(
          InsuranceEntity value, $Res Function(InsuranceEntity) then) =
      _$InsuranceEntityCopyWithImpl<$Res, InsuranceEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      DateTime renewalDate,
      bool isRenewed});
}

/// @nodoc
class _$InsuranceEntityCopyWithImpl<$Res, $Val extends InsuranceEntity>
    implements $InsuranceEntityCopyWith<$Res> {
  _$InsuranceEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? renewalDate = null,
    Object? isRenewed = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      renewalDate: null == renewalDate
          ? _value.renewalDate
          : renewalDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRenewed: null == isRenewed
          ? _value.isRenewed
          : isRenewed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InsuranceEntityImplCopyWith<$Res>
    implements $InsuranceEntityCopyWith<$Res> {
  factory _$$InsuranceEntityImplCopyWith(_$InsuranceEntityImpl value,
          $Res Function(_$InsuranceEntityImpl) then) =
      __$$InsuranceEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      DateTime renewalDate,
      bool isRenewed});
}

/// @nodoc
class __$$InsuranceEntityImplCopyWithImpl<$Res>
    extends _$InsuranceEntityCopyWithImpl<$Res, _$InsuranceEntityImpl>
    implements _$$InsuranceEntityImplCopyWith<$Res> {
  __$$InsuranceEntityImplCopyWithImpl(
      _$InsuranceEntityImpl _value, $Res Function(_$InsuranceEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? renewalDate = null,
    Object? isRenewed = null,
  }) {
    return _then(_$InsuranceEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      renewalDate: null == renewalDate
          ? _value.renewalDate
          : renewalDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRenewed: null == isRenewed
          ? _value.isRenewed
          : isRenewed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$InsuranceEntityImpl implements _InsuranceEntity {
  const _$InsuranceEntityImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.renewalDate,
      this.isRenewed = false});

  @override
  final String id;
  @override
  final String name;
  @override
  final String type;
  @override
  final DateTime renewalDate;
  @override
  @JsonKey()
  final bool isRenewed;

  @override
  String toString() {
    return 'InsuranceEntity(id: $id, name: $name, type: $type, renewalDate: $renewalDate, isRenewed: $isRenewed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsuranceEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.renewalDate, renewalDate) ||
                other.renewalDate == renewalDate) &&
            (identical(other.isRenewed, isRenewed) ||
                other.isRenewed == isRenewed));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, type, renewalDate, isRenewed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsuranceEntityImplCopyWith<_$InsuranceEntityImpl> get copyWith =>
      __$$InsuranceEntityImplCopyWithImpl<_$InsuranceEntityImpl>(
          this, _$identity);
}

abstract class _InsuranceEntity implements InsuranceEntity {
  const factory _InsuranceEntity(
      {required final String id,
      required final String name,
      required final String type,
      required final DateTime renewalDate,
      final bool isRenewed}) = _$InsuranceEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get type;
  @override
  DateTime get renewalDate;
  @override
  bool get isRenewed;
  @override
  @JsonKey(ignore: true)
  _$$InsuranceEntityImplCopyWith<_$InsuranceEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
