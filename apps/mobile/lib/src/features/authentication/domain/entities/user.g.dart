// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      familyId: json['familyId'] as String?,
      authStage: $enumDecodeNullable(_$AuthStageEnumMap, json['authStage']) ??
          AuthStage.completed,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'familyId': instance.familyId,
      'authStage': _$AuthStageEnumMap[instance.authStage]!,
    };

const _$AuthStageEnumMap = {
  AuthStage.awaitingOtp: 'awaitingOtp',
  AuthStage.awaitingTwoFactor: 'awaitingTwoFactor',
  AuthStage.awaitingDeviceTrust: 'awaitingDeviceTrust',
  AuthStage.awaitingBiometrics: 'awaitingBiometrics',
  AuthStage.awaitingRecoveryCodes: 'awaitingRecoveryCodes',
  AuthStage.completed: 'completed',
};
