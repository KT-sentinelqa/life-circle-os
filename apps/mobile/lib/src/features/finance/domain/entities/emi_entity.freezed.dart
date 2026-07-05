// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'emi_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EmiEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  bool get isPaid => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EmiEntityCopyWith<EmiEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmiEntityCopyWith<$Res> {
  factory $EmiEntityCopyWith(EmiEntity value, $Res Function(EmiEntity) then) =
      _$EmiEntityCopyWithImpl<$Res, EmiEntity>;
  @useResult
  $Res call(
      {String id, String name, double amount, DateTime dueDate, bool isPaid});
}

/// @nodoc
class _$EmiEntityCopyWithImpl<$Res, $Val extends EmiEntity>
    implements $EmiEntityCopyWith<$Res> {
  _$EmiEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? dueDate = null,
    Object? isPaid = null,
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
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmiEntityImplCopyWith<$Res>
    implements $EmiEntityCopyWith<$Res> {
  factory _$$EmiEntityImplCopyWith(
          _$EmiEntityImpl value, $Res Function(_$EmiEntityImpl) then) =
      __$$EmiEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String name, double amount, DateTime dueDate, bool isPaid});
}

/// @nodoc
class __$$EmiEntityImplCopyWithImpl<$Res>
    extends _$EmiEntityCopyWithImpl<$Res, _$EmiEntityImpl>
    implements _$$EmiEntityImplCopyWith<$Res> {
  __$$EmiEntityImplCopyWithImpl(
      _$EmiEntityImpl _value, $Res Function(_$EmiEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? dueDate = null,
    Object? isPaid = null,
  }) {
    return _then(_$EmiEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$EmiEntityImpl implements _EmiEntity {
  const _$EmiEntityImpl(
      {required this.id,
      required this.name,
      required this.amount,
      required this.dueDate,
      this.isPaid = false});

  @override
  final String id;
  @override
  final String name;
  @override
  final double amount;
  @override
  final DateTime dueDate;
  @override
  @JsonKey()
  final bool isPaid;

  @override
  String toString() {
    return 'EmiEntity(id: $id, name: $name, amount: $amount, dueDate: $dueDate, isPaid: $isPaid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmiEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, amount, dueDate, isPaid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmiEntityImplCopyWith<_$EmiEntityImpl> get copyWith =>
      __$$EmiEntityImplCopyWithImpl<_$EmiEntityImpl>(this, _$identity);
}

abstract class _EmiEntity implements EmiEntity {
  const factory _EmiEntity(
      {required final String id,
      required final String name,
      required final double amount,
      required final DateTime dueDate,
      final bool isPaid}) = _$EmiEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  double get amount;
  @override
  DateTime get dueDate;
  @override
  bool get isPaid;
  @override
  @JsonKey(ignore: true)
  _$$EmiEntityImplCopyWith<_$EmiEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
