// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoutineTime _$RoutineTimeFromJson(Map<String, dynamic> json) => _RoutineTime(
  hour: (json['hour'] as num).toInt(),
  minute: (json['minute'] as num).toInt(),
);

Map<String, dynamic> _$RoutineTimeToJson(_RoutineTime instance) =>
    <String, dynamic>{'hour': instance.hour, 'minute': instance.minute};

_RoutineThresholdSetting _$RoutineThresholdSettingFromJson(
  Map<String, dynamic> json,
) => _RoutineThresholdSetting(
  allowableDelayMinutes: (json['allowableDelayMinutes'] as num?)?.toInt() ?? 5,
  criticalDelayMinutes: (json['criticalDelayMinutes'] as num?)?.toInt() ?? 15,
);

Map<String, dynamic> _$RoutineThresholdSettingToJson(
  _RoutineThresholdSetting instance,
) => <String, dynamic>{
  'allowableDelayMinutes': instance.allowableDelayMinutes,
  'criticalDelayMinutes': instance.criticalDelayMinutes,
};

_RoutineEntity _$RoutineEntityFromJson(Map<String, dynamic> json) =>
    _RoutineEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      targetTime: RoutineTime.fromJson(
        json['targetTime'] as Map<String, dynamic>,
      ),
      thresholds: json['thresholds'] == null
          ? const RoutineThresholdSetting()
          : RoutineThresholdSetting.fromJson(
              json['thresholds'] as Map<String, dynamic>,
            ),
      lastResult: json['lastResult'] == null
          ? null
          : RoutineCompletionResultEntity.fromJson(
              json['lastResult'] as Map<String, dynamic>,
            ),
      sortIndex: (json['sortIndex'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RoutineEntityToJson(_RoutineEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'targetTime': instance.targetTime,
      'thresholds': instance.thresholds,
      'lastResult': instance.lastResult,
      'sortIndex': instance.sortIndex,
    };
