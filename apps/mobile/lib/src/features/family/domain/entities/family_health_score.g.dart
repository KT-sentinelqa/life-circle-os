// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_health_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FamilyHealthScoreImpl _$$FamilyHealthScoreImplFromJson(
        Map<String, dynamic> json) =>
    _$FamilyHealthScoreImpl(
      totalDosesScheduled: (json['totalDosesScheduled'] as num).toInt(),
      totalDosesTaken: (json['totalDosesTaken'] as num).toInt(),
      totalDosesMissed: (json['totalDosesMissed'] as num).toInt(),
      adherencePercentage: (json['adherencePercentage'] as num).toDouble(),
      activeCaregiverCount: (json['activeCaregiverCount'] as num).toInt(),
      membersAtRisk: (json['membersAtRisk'] as num).toInt(),
      peaceScore: (json['peaceScore'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$FamilyHealthScoreImplToJson(
        _$FamilyHealthScoreImpl instance) =>
    <String, dynamic>{
      'totalDosesScheduled': instance.totalDosesScheduled,
      'totalDosesTaken': instance.totalDosesTaken,
      'totalDosesMissed': instance.totalDosesMissed,
      'adherencePercentage': instance.adherencePercentage,
      'activeCaregiverCount': instance.activeCaregiverCount,
      'membersAtRisk': instance.membersAtRisk,
      'peaceScore': instance.peaceScore,
    };
