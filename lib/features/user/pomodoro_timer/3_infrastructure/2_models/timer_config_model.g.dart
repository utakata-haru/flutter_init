// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimerConfigModelImpl _$$TimerConfigModelImplFromJson(
  Map<String, dynamic> json,
) => _$TimerConfigModelImpl(
  focusMinutes: (json['focusMinutes'] as num).toInt(),
  shortBreakMinutes: (json['shortBreakMinutes'] as num).toInt(),
  longBreakMinutes: (json['longBreakMinutes'] as num).toInt(),
  longBreakInterval: (json['longBreakInterval'] as num).toInt(),
);

Map<String, dynamic> _$$TimerConfigModelImplToJson(
  _$TimerConfigModelImpl instance,
) => <String, dynamic>{
  'focusMinutes': instance.focusMinutes,
  'shortBreakMinutes': instance.shortBreakMinutes,
  'longBreakMinutes': instance.longBreakMinutes,
  'longBreakInterval': instance.longBreakInterval,
};
