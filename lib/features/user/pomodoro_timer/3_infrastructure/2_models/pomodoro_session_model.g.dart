// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PomodoroSessionModelImpl _$$PomodoroSessionModelImplFromJson(
  Map<String, dynamic> json,
) => _$PomodoroSessionModelImpl(
  id: json['id'] as String,
  phase: json['phase'] as String,
  remainingSeconds: (json['remainingSeconds'] as num).toInt(),
  elapsedSeconds: (json['elapsedSeconds'] as num).toInt(),
  status: json['status'] as String,
  completedFocusCount: (json['completedFocusCount'] as num).toInt(),
  startedAt: DateTime.parse(json['startedAt'] as String),
);

Map<String, dynamic> _$$PomodoroSessionModelImplToJson(
  _$PomodoroSessionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'phase': instance.phase,
  'remainingSeconds': instance.remainingSeconds,
  'elapsedSeconds': instance.elapsedSeconds,
  'status': instance.status,
  'completedFocusCount': instance.completedFocusCount,
  'startedAt': instance.startedAt.toIso8601String(),
};
