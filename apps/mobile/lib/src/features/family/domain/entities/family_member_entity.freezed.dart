// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'family_member_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FamilyMemberEntity _$FamilyMemberEntityFromJson(Map<String, dynamic> json) {
  return _FamilyMemberEntity.fromJson(json);
}

/// @nodoc
mixin _$FamilyMemberEntity {
  /// Unique identifier for the member record.
  String get id => throw _privateConstructorUsedError;

  /// The associated user ID.
  String get userId => throw _privateConstructorUsedError;

  /// The associated family ID.
  String get familyId => throw _privateConstructorUsedError;

  /// The role of the member.
  MemberRole get role => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FamilyMemberEntityCopyWith<FamilyMemberEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FamilyMemberEntityCopyWith<$Res> {
  factory $FamilyMemberEntityCopyWith(
          FamilyMemberEntity value, $Res Function(FamilyMemberEntity) then) =
      _$FamilyMemberEntityCopyWithImpl<$Res, FamilyMemberEntity>;
  @useResult
  $Res call({String id, String userId, String familyId, MemberRole role});
}

/// @nodoc
class _$FamilyMemberEntityCopyWithImpl<$Res, $Val extends FamilyMemberEntity>
    implements $FamilyMemberEntityCopyWith<$Res> {
  _$FamilyMemberEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? familyId = null,
    Object? role = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      familyId: null == familyId
          ? _value.familyId
          : familyId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as MemberRole,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FamilyMemberEntityImplCopyWith<$Res>
    implements $FamilyMemberEntityCopyWith<$Res> {
  factory _$$FamilyMemberEntityImplCopyWith(_$FamilyMemberEntityImpl value,
          $Res Function(_$FamilyMemberEntityImpl) then) =
      __$$FamilyMemberEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String userId, String familyId, MemberRole role});
}

/// @nodoc
class __$$FamilyMemberEntityImplCopyWithImpl<$Res>
    extends _$FamilyMemberEntityCopyWithImpl<$Res, _$FamilyMemberEntityImpl>
    implements _$$FamilyMemberEntityImplCopyWith<$Res> {
  __$$FamilyMemberEntityImplCopyWithImpl(_$FamilyMemberEntityImpl _value,
      $Res Function(_$FamilyMemberEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? familyId = null,
    Object? role = null,
  }) {
    return _then(_$FamilyMemberEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      familyId: null == familyId
          ? _value.familyId
          : familyId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as MemberRole,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FamilyMemberEntityImpl implements _FamilyMemberEntity {
  const _$FamilyMemberEntityImpl(
      {required this.id,
      required this.userId,
      required this.familyId,
      this.role = MemberRole.standard});

  factory _$FamilyMemberEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$FamilyMemberEntityImplFromJson(json);

  /// Unique identifier for the member record.
  @override
  final String id;

  /// The associated user ID.
  @override
  final String userId;

  /// The associated family ID.
  @override
  final String familyId;

  /// The role of the member.
  @override
  @JsonKey()
  final MemberRole role;

  @override
  String toString() {
    return 'FamilyMemberEntity(id: $id, userId: $userId, familyId: $familyId, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FamilyMemberEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.familyId, familyId) ||
                other.familyId == familyId) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, familyId, role);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FamilyMemberEntityImplCopyWith<_$FamilyMemberEntityImpl> get copyWith =>
      __$$FamilyMemberEntityImplCopyWithImpl<_$FamilyMemberEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FamilyMemberEntityImplToJson(
      this,
    );
  }
}

abstract class _FamilyMemberEntity implements FamilyMemberEntity {
  const factory _FamilyMemberEntity(
      {required final String id,
      required final String userId,
      required final String familyId,
      final MemberRole role}) = _$FamilyMemberEntityImpl;

  factory _FamilyMemberEntity.fromJson(Map<String, dynamic> json) =
      _$FamilyMemberEntityImpl.fromJson;

  @override

  /// Unique identifier for the member record.
  String get id;
  @override

  /// The associated user ID.
  String get userId;
  @override

  /// The associated family ID.
  String get familyId;
  @override

  /// The role of the member.
  MemberRole get role;
  @override
  @JsonKey(ignore: true)
  _$$FamilyMemberEntityImplCopyWith<_$FamilyMemberEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
