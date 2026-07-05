// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'family_health_score.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FamilyHealthScore _$FamilyHealthScoreFromJson(Map<String, dynamic> json) {
  return _FamilyHealthScore.fromJson(json);
}

/// @nodoc
mixin _$FamilyHealthScore {
  /// Total doses scheduled across all family members.
  int get totalDosesScheduled => throw _privateConstructorUsedError;

  /// Total doses taken across all family members.
  int get totalDosesTaken => throw _privateConstructorUsedError;

  /// Total doses missed across all family members.
  int get totalDosesMissed => throw _privateConstructorUsedError;

  /// The weighted adherence percentage for the family (0.0 to 1.0).
  double get adherencePercentage => throw _privateConstructorUsedError;

  /// Number of active caregivers.
  int get activeCaregiverCount => throw _privateConstructorUsedError;

  /// Number of members with 'critical' or 'atRisk' status.
  int get membersAtRisk => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FamilyHealthScoreCopyWith<FamilyHealthScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FamilyHealthScoreCopyWith<$Res> {
  factory $FamilyHealthScoreCopyWith(
          FamilyHealthScore value, $Res Function(FamilyHealthScore) then) =
      _$FamilyHealthScoreCopyWithImpl<$Res, FamilyHealthScore>;
  @useResult
  $Res call(
      {int totalDosesScheduled,
      int totalDosesTaken,
      int totalDosesMissed,
      double adherencePercentage,
      int activeCaregiverCount,
      int membersAtRisk});
}

/// @nodoc
class _$FamilyHealthScoreCopyWithImpl<$Res, $Val extends FamilyHealthScore>
    implements $FamilyHealthScoreCopyWith<$Res> {
  _$FamilyHealthScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalDosesScheduled = null,
    Object? totalDosesTaken = null,
    Object? totalDosesMissed = null,
    Object? adherencePercentage = null,
    Object? activeCaregiverCount = null,
    Object? membersAtRisk = null,
  }) {
    return _then(_value.copyWith(
      totalDosesScheduled: null == totalDosesScheduled
          ? _value.totalDosesScheduled
          : totalDosesScheduled // ignore: cast_nullable_to_non_nullable
              as int,
      totalDosesTaken: null == totalDosesTaken
          ? _value.totalDosesTaken
          : totalDosesTaken // ignore: cast_nullable_to_non_nullable
              as int,
      totalDosesMissed: null == totalDosesMissed
          ? _value.totalDosesMissed
          : totalDosesMissed // ignore: cast_nullable_to_non_nullable
              as int,
      adherencePercentage: null == adherencePercentage
          ? _value.adherencePercentage
          : adherencePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      activeCaregiverCount: null == activeCaregiverCount
          ? _value.activeCaregiverCount
          : activeCaregiverCount // ignore: cast_nullable_to_non_nullable
              as int,
      membersAtRisk: null == membersAtRisk
          ? _value.membersAtRisk
          : membersAtRisk // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FamilyHealthScoreImplCopyWith<$Res>
    implements $FamilyHealthScoreCopyWith<$Res> {
  factory _$$FamilyHealthScoreImplCopyWith(_$FamilyHealthScoreImpl value,
          $Res Function(_$FamilyHealthScoreImpl) then) =
      __$$FamilyHealthScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalDosesScheduled,
      int totalDosesTaken,
      int totalDosesMissed,
      double adherencePercentage,
      int activeCaregiverCount,
      int membersAtRisk});
}

/// @nodoc
class __$$FamilyHealthScoreImplCopyWithImpl<$Res>
    extends _$FamilyHealthScoreCopyWithImpl<$Res, _$FamilyHealthScoreImpl>
    implements _$$FamilyHealthScoreImplCopyWith<$Res> {
  __$$FamilyHealthScoreImplCopyWithImpl(_$FamilyHealthScoreImpl _value,
      $Res Function(_$FamilyHealthScoreImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalDosesScheduled = null,
    Object? totalDosesTaken = null,
    Object? totalDosesMissed = null,
    Object? adherencePercentage = null,
    Object? activeCaregiverCount = null,
    Object? membersAtRisk = null,
  }) {
    return _then(_$FamilyHealthScoreImpl(
      totalDosesScheduled: null == totalDosesScheduled
          ? _value.totalDosesScheduled
          : totalDosesScheduled // ignore: cast_nullable_to_non_nullable
              as int,
      totalDosesTaken: null == totalDosesTaken
          ? _value.totalDosesTaken
          : totalDosesTaken // ignore: cast_nullable_to_non_nullable
              as int,
      totalDosesMissed: null == totalDosesMissed
          ? _value.totalDosesMissed
          : totalDosesMissed // ignore: cast_nullable_to_non_nullable
              as int,
      adherencePercentage: null == adherencePercentage
          ? _value.adherencePercentage
          : adherencePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      activeCaregiverCount: null == activeCaregiverCount
          ? _value.activeCaregiverCount
          : activeCaregiverCount // ignore: cast_nullable_to_non_nullable
              as int,
      membersAtRisk: null == membersAtRisk
          ? _value.membersAtRisk
          : membersAtRisk // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FamilyHealthScoreImpl implements _FamilyHealthScore {
  const _$FamilyHealthScoreImpl(
      {required this.totalDosesScheduled,
      required this.totalDosesTaken,
      required this.totalDosesMissed,
      required this.adherencePercentage,
      required this.activeCaregiverCount,
      required this.membersAtRisk});

  factory _$FamilyHealthScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$FamilyHealthScoreImplFromJson(json);

  /// Total doses scheduled across all family members.
  @override
  final int totalDosesScheduled;

  /// Total doses taken across all family members.
  @override
  final int totalDosesTaken;

  /// Total doses missed across all family members.
  @override
  final int totalDosesMissed;

  /// The weighted adherence percentage for the family (0.0 to 1.0).
  @override
  final double adherencePercentage;

  /// Number of active caregivers.
  @override
  final int activeCaregiverCount;

  /// Number of members with 'critical' or 'atRisk' status.
  @override
  final int membersAtRisk;

  @override
  String toString() {
    return 'FamilyHealthScore(totalDosesScheduled: $totalDosesScheduled, totalDosesTaken: $totalDosesTaken, totalDosesMissed: $totalDosesMissed, adherencePercentage: $adherencePercentage, activeCaregiverCount: $activeCaregiverCount, membersAtRisk: $membersAtRisk)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FamilyHealthScoreImpl &&
            (identical(other.totalDosesScheduled, totalDosesScheduled) ||
                other.totalDosesScheduled == totalDosesScheduled) &&
            (identical(other.totalDosesTaken, totalDosesTaken) ||
                other.totalDosesTaken == totalDosesTaken) &&
            (identical(other.totalDosesMissed, totalDosesMissed) ||
                other.totalDosesMissed == totalDosesMissed) &&
            (identical(other.adherencePercentage, adherencePercentage) ||
                other.adherencePercentage == adherencePercentage) &&
            (identical(other.activeCaregiverCount, activeCaregiverCount) ||
                other.activeCaregiverCount == activeCaregiverCount) &&
            (identical(other.membersAtRisk, membersAtRisk) ||
                other.membersAtRisk == membersAtRisk));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalDosesScheduled,
      totalDosesTaken,
      totalDosesMissed,
      adherencePercentage,
      activeCaregiverCount,
      membersAtRisk);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FamilyHealthScoreImplCopyWith<_$FamilyHealthScoreImpl> get copyWith =>
      __$$FamilyHealthScoreImplCopyWithImpl<_$FamilyHealthScoreImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FamilyHealthScoreImplToJson(
      this,
    );
  }
}

abstract class _FamilyHealthScore implements FamilyHealthScore {
  const factory _FamilyHealthScore(
      {required final int totalDosesScheduled,
      required final int totalDosesTaken,
      required final int totalDosesMissed,
      required final double adherencePercentage,
      required final int activeCaregiverCount,
      required final int membersAtRisk}) = _$FamilyHealthScoreImpl;

  factory _FamilyHealthScore.fromJson(Map<String, dynamic> json) =
      _$FamilyHealthScoreImpl.fromJson;

  @override

  /// Total doses scheduled across all family members.
  int get totalDosesScheduled;
  @override

  /// Total doses taken across all family members.
  int get totalDosesTaken;
  @override

  /// Total doses missed across all family members.
  int get totalDosesMissed;
  @override

  /// The weighted adherence percentage for the family (0.0 to 1.0).
  double get adherencePercentage;
  @override

  /// Number of active caregivers.
  int get activeCaregiverCount;
  @override

  /// Number of members with 'critical' or 'atRisk' status.
  int get membersAtRisk;
  @override
  @JsonKey(ignore: true)
  _$$FamilyHealthScoreImplCopyWith<_$FamilyHealthScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
