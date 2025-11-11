import 'package:freezed_annotation/freezed_annotation.dart';

import 'routine_entity.dart';

part 'routine_completion_result_entity.freezed.dart';
part 'routine_completion_result_entity.g.dart';

@freezed
abstract class RoutineCompletionResultEntity
    with _$RoutineCompletionResultEntity {
  const RoutineCompletionResultEntity._();

  const factory RoutineCompletionResultEntity({
    required String routineId,
    required DateTime scheduledDateTime,
    required DateTime completedAt,
    required RoutineComplianceStatus status,
    required int delayMinutes,
  }) = _RoutineCompletionResultEntity;

  factory RoutineCompletionResultEntity.fromJson(Map<String, dynamic> json) =>
      _$RoutineCompletionResultEntityFromJson(json);

  bool get isOnTime => status == RoutineComplianceStatus.onTime;
}
