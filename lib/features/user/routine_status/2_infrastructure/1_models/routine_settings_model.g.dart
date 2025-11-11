// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutineSettingsModel _$RoutineSettingsModelFromJson(
  Map<String, dynamic> json,
) => RoutineSettingsModel(
  id: json['id'] as String,
  allowableDelayMinutes: (json['allowableDelayMinutes'] as num).toInt(),
  criticalDelayMinutes: (json['criticalDelayMinutes'] as num).toInt(),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$RoutineSettingsModelToJson(
  RoutineSettingsModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'allowableDelayMinutes': instance.allowableDelayMinutes,
  'criticalDelayMinutes': instance.criticalDelayMinutes,
  'updatedAt': instance.updatedAt.toIso8601String(),
};
