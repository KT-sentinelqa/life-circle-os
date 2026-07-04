// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'family_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FamilyEntity _$FamilyEntityFromJson(Map<String, dynamic> json) {
  return _FamilyEntity.fromJson(json);
}

/// @nodoc
mixin _$FamilyEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FamilyEntityCopyWith<FamilyEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FamilyEntityCopyWith<$Res> {
  factory $FamilyEntityCopyWith(
          FamilyEntity value, $Res Function(FamilyEntity) then) =
      _$FamilyEntityCopyWithImpl<$Res, FamilyEntity>;
  @useResult
  $Res call({String id, String name, DateTime createdAt});
}

/// @nodoc
class _$FamilyEntityCopyWithImpl<$Res, $Val extends FamilyEntity>
    implements $FamilyEntityCopyWith<$Res> {
  _$FamilyEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FamilyEntityImplCopyWith<$Res>
    implements $FamilyEntityCopyWith<$Res> {
  factory _$$FamilyEntityImplCopyWith(
          _$FamilyEntityImpl value, $Res Function(_$FamilyEntityImpl) then) =
      __$$FamilyEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, DateTime createdAt});
}

/// @nodoc
class __$$FamilyEntityImplCopyWithImpl<$Res>
    extends _$FamilyEntityCopyWithImpl<$Res, _$FamilyEntityImpl>
    implements _$$FamilyEntityImplCopyWith<$Res> {
  __$$FamilyEntityImplCopyWithImpl(
      _$FamilyEntityImpl _value, $Res Function(_$FamilyEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
  }) {
    return _then(_$FamilyEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FamilyEntityImpl implements _FamilyEntity {
  const _$FamilyEntityImpl(
      {required this.id, required this.name, required this.createdAt});

  factory _$FamilyEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$FamilyEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'FamilyEntity(id: $id, name: $name, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FamilyEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FamilyEntityImplCopyWith<_$FamilyEntityImpl> get copyWith =>
      __$$FamilyEntityImplCopyWithImpl<_$FamilyEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FamilyEntityImplToJson(
      this,
    );
  }
}

abstract class _FamilyEntity implements FamilyEntity {
  const factory _FamilyEntity(
      {required final String id,
      required final String name,
      required final DateTime createdAt}) = _$FamilyEntityImpl;

  factory _FamilyEntity.fromJson(Map<String, dynamic> json) =
      _$FamilyEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$FamilyEntityImplCopyWith<_$FamilyEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
