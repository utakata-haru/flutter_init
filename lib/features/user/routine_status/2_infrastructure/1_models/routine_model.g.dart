// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutineModel _$RoutineModelFromJson(Map<String, dynamic> json) => RoutineModel(
  id: json['id'] as String,
  name: json['name'] as String,
  targetHour: (json['targetHour'] as num).toInt(),
  targetMinute: (json['targetMinute'] as num).toInt(),
  allowableDelayMinutes: (json['allowableDelayMinutes'] as num).toInt(),
  criticalDelayMinutes: (json['criticalDelayMinutes'] as num).toInt(),
  sortIndex: (json['sortIndex'] as num).toInt(),
  lastScheduledAt: json['lastScheduledAt'] == null
      ? null
      : DateTime.parse(json['lastScheduledAt'] as String),
  lastCompletedAt: json['lastCompletedAt'] == null
      ? null
      : DateTime.parse(json['lastCompletedAt'] as String),
  lastDelayMinutes: (json['lastDelayMinutes'] as num?)?.toInt(),
  lastStatus: $enumDecodeNullable(
    _$RoutineComplianceStatusEnumMap,
    json['lastStatus'],
  ),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  lastEdited: json['lastEdited'] as bool? ?? false,
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$RoutineModelToJson(RoutineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'targetHour': instance.targetHour,
      'targetMinute': instance.targetMinute,
      'allowableDelayMinutes': instance.allowableDelayMinutes,
      'criticalDelayMinutes': instance.criticalDelayMinutes,
      'sortIndex': instance.sortIndex,
      'lastScheduledAt': instance.lastScheduledAt?.toIso8601String(),
      'lastCompletedAt': instance.lastCompletedAt?.toIso8601String(),
      'lastDelayMinutes': instance.lastDelayMinutes,
      'lastStatus': _$RoutineComplianceStatusEnumMap[instance.lastStatus],
      'lastEdited': instance.lastEdited,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$RoutineComplianceStatusEnumMap = {
  RoutineComplianceStatus.onTime: 'onTime',
  RoutineComplianceStatus.warning: 'warning',
  RoutineComplianceStatus.late: 'late',
};
