// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'family_invitation_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FamilyInvitationEntity _$FamilyInvitationEntityFromJson(
    Map<String, dynamic> json) {
  return _FamilyInvitationEntity.fromJson(json);
}

/// @nodoc
mixin _$FamilyInvitationEntity {
  /// Unique identifier for the invitation.
  String get id => throw _privateConstructorUsedError;

  /// The family ID the user is invited to.
  String get familyId => throw _privateConstructorUsedError;

  /// The email address of the invited user.
  String get email => throw _privateConstructorUsedError;

  /// The status of the invitation.
  InvitationStatus get status => throw _privateConstructorUsedError;

  /// The time the invitation was sent.
  DateTime get invitedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FamilyInvitationEntityCopyWith<FamilyInvitationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FamilyInvitationEntityCopyWith<$Res> {
  factory $FamilyInvitationEntityCopyWith(FamilyInvitationEntity value,
          $Res Function(FamilyInvitationEntity) then) =
      _$FamilyInvitationEntityCopyWithImpl<$Res, FamilyInvitationEntity>;
  @useResult
  $Res call(
      {String id,
      String familyId,
      String email,
      InvitationStatus status,
      DateTime invitedAt});
}

/// @nodoc
class _$FamilyInvitationEntityCopyWithImpl<$Res,
        $Val extends FamilyInvitationEntity>
    implements $FamilyInvitationEntityCopyWith<$Res> {
  _$FamilyInvitationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? familyId = null,
    Object? email = null,
    Object? status = null,
    Object? invitedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      familyId: null == familyId
          ? _value.familyId
          : familyId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InvitationStatus,
      invitedAt: null == invitedAt
          ? _value.invitedAt
          : invitedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FamilyInvitationEntityImplCopyWith<$Res>
    implements $FamilyInvitationEntityCopyWith<$Res> {
  factory _$$FamilyInvitationEntityImplCopyWith(
          _$FamilyInvitationEntityImpl value,
          $Res Function(_$FamilyInvitationEntityImpl) then) =
      __$$FamilyInvitationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String familyId,
      String email,
      InvitationStatus status,
      DateTime invitedAt});
}

/// @nodoc
class __$$FamilyInvitationEntityImplCopyWithImpl<$Res>
    extends _$FamilyInvitationEntityCopyWithImpl<$Res,
        _$FamilyInvitationEntityImpl>
    implements _$$FamilyInvitationEntityImplCopyWith<$Res> {
  __$$FamilyInvitationEntityImplCopyWithImpl(
      _$FamilyInvitationEntityImpl _value,
      $Res Function(_$FamilyInvitationEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? familyId = null,
    Object? email = null,
    Object? status = null,
    Object? invitedAt = null,
  }) {
    return _then(_$FamilyInvitationEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      familyId: null == familyId
          ? _value.familyId
          : familyId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InvitationStatus,
      invitedAt: null == invitedAt
          ? _value.invitedAt
          : invitedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FamilyInvitationEntityImpl implements _FamilyInvitationEntity {
  const _$FamilyInvitationEntityImpl(
      {required this.id,
      required this.familyId,
      required this.email,
      this.status = InvitationStatus.pending,
      required this.invitedAt});

  factory _$FamilyInvitationEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$FamilyInvitationEntityImplFromJson(json);

  /// Unique identifier for the invitation.
  @override
  final String id;

  /// The family ID the user is invited to.
  @override
  final String familyId;

  /// The email address of the invited user.
  @override
  final String email;

  /// The status of the invitation.
  @override
  @JsonKey()
  final InvitationStatus status;

  /// The time the invitation was sent.
  @override
  final DateTime invitedAt;

  @override
  String toString() {
    return 'FamilyInvitationEntity(id: $id, familyId: $familyId, email: $email, status: $status, invitedAt: $invitedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FamilyInvitationEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.familyId, familyId) ||
                other.familyId == familyId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.invitedAt, invitedAt) ||
                other.invitedAt == invitedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, familyId, email, status, invitedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FamilyInvitationEntityImplCopyWith<_$FamilyInvitationEntityImpl>
      get copyWith => __$$FamilyInvitationEntityImplCopyWithImpl<
          _$FamilyInvitationEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FamilyInvitationEntityImplToJson(
      this,
    );
  }
}

abstract class _FamilyInvitationEntity implements FamilyInvitationEntity {
  const factory _FamilyInvitationEntity(
      {required final String id,
      required final String familyId,
      required final String email,
      final InvitationStatus status,
      required final DateTime invitedAt}) = _$FamilyInvitationEntityImpl;

  factory _FamilyInvitationEntity.fromJson(Map<String, dynamic> json) =
      _$FamilyInvitationEntityImpl.fromJson;

  @override

  /// Unique identifier for the invitation.
  String get id;
  @override

  /// The family ID the user is invited to.
  String get familyId;
  @override

  /// The email address of the invited user.
  String get email;
  @override

  /// The status of the invitation.
  InvitationStatus get status;
  @override

  /// The time the invitation was sent.
  DateTime get invitedAt;
  @override
  @JsonKey(ignore: true)
  _$$FamilyInvitationEntityImplCopyWith<_$FamilyInvitationEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
