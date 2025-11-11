import 'package:freezed_annotation/freezed_annotation.dart';

import 'routine_completion_result_entity.dart';

part 'routine_entity.freezed.dart';
part 'routine_entity.g.dart';

/// Routine compliance state evaluated against the configured thresholds.
enum RoutineComplianceStatus { onTime, warning, late }

@freezed
abstract class RoutineTime with _$RoutineTime {
  const RoutineTime._();

  const factory RoutineTime({required int hour, required int minute}) =
      _RoutineTime;

  factory RoutineTime.fromJson(Map<String, dynamic> json) =>
      _$RoutineTimeFromJson(json);

  /// Returns the scheduled `DateTime` for the supplied [referenceDate].
  DateTime asDateTime(DateTime referenceDate) => DateTime(
    referenceDate.year,
    referenceDate.month,
    referenceDate.day,
    hour,
    minute,
  );

  bool get isValid => hour >= 0 && hour <= 23 && minute >= 0 && minute <= 59;
}

@freezed
abstract class RoutineThresholdSetting with _$RoutineThresholdSetting {
  const RoutineThresholdSetting._();

  const factory RoutineThresholdSetting({
    @Default(5) int allowableDelayMinutes,
    @Default(15) int criticalDelayMinutes,
  }) = _RoutineThresholdSetting;

  factory RoutineThresholdSetting.fromJson(Map<String, dynamic> json) =>
      _$RoutineThresholdSettingFromJson(json);

  RoutineComplianceStatus evaluate(Duration delta) {
    final minutes = delta.inMinutes;
    if (minutes <= allowableDelayMinutes) {
      return RoutineComplianceStatus.onTime;
    }
    if (minutes <= criticalDelayMinutes) {
      return RoutineComplianceStatus.warning;
    }
    return RoutineComplianceStatus.late;
  }

  bool get isValid =>
      allowableDelayMinutes >= 0 &&
      criticalDelayMinutes >= allowableDelayMinutes;
}

@freezed
abstract class RoutineEntity with _$RoutineEntity {
  const RoutineEntity._();

  const factory RoutineEntity({
    required String id,
    required String name,
    required RoutineTime targetTime,
    @Default(RoutineThresholdSetting()) RoutineThresholdSetting thresholds,
    RoutineCompletionResultEntity? lastResult,
  }) = _RoutineEntity;

  factory RoutineEntity.fromJson(Map<String, dynamic> json) =>
      _$RoutineEntityFromJson(json);

  RoutineEntity applyThresholds(RoutineThresholdSetting setting) =>
      copyWith(thresholds: setting);

  RoutineComplianceStatus evaluateStatus(
    DateTime completionTime, {
    DateTime? referenceDate,
  }) {
    final scheduled = targetTime.asDateTime(referenceDate ?? completionTime);
    final delta = completionTime.difference(scheduled).abs();
    return thresholds.evaluate(delta);
  }

  RoutineEntity applyResult(RoutineCompletionResultEntity result) =>
      copyWith(lastResult: result);
}
