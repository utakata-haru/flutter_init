// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_completion_result_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoutineCompletionResultEntity _$RoutineCompletionResultEntityFromJson(
  Map<String, dynamic> json,
) => _RoutineCompletionResultEntity(
  routineId: json['routineId'] as String,
  scheduledDateTime: DateTime.parse(json['scheduledDateTime'] as String),
  completedAt: DateTime.parse(json['completedAt'] as String),
  status: $enumDecode(_$RoutineComplianceStatusEnumMap, json['status']),
  delayMinutes: (json['delayMinutes'] as num).toInt(),
  edited: json['edited'] as bool? ?? false,
);

Map<String, dynamic> _$RoutineCompletionResultEntityToJson(
  _RoutineCompletionResultEntity instance,
) => <String, dynamic>{
  'routineId': instance.routineId,
  'scheduledDateTime': instance.scheduledDateTime.toIso8601String(),
  'completedAt': instance.completedAt.toIso8601String(),
  'status': _$RoutineComplianceStatusEnumMap[instance.status]!,
  'delayMinutes': instance.delayMinutes,
  'edited': instance.edited,
};

const _$RoutineComplianceStatusEnumMap = {
  RoutineComplianceStatus.onTime: 'onTime',
  RoutineComplianceStatus.warning: 'warning',
  RoutineComplianceStatus.late: 'late',
};
