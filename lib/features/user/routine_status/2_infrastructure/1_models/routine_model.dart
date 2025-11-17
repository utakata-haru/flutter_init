import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/database/database.dart';
import '../../1_domain/1_entities/routine_completion_result_entity.dart';
import '../../1_domain/1_entities/routine_entity.dart';

part 'routine_model.g.dart';

@JsonSerializable()
class RoutineModel {
  const RoutineModel({
    required this.id,
    required this.name,
    required this.targetHour,
    required this.targetMinute,
    required this.allowableDelayMinutes,
    required this.criticalDelayMinutes,
    required this.sortIndex,
    this.lastScheduledAt,
    this.lastCompletedAt,
    this.lastDelayMinutes,
    this.lastStatus,
    this.createdAt,
    this.lastEdited = false,
    this.updatedAt,
  });

  final String id;
  final String name;
  final int targetHour;
  final int targetMinute;
  final int allowableDelayMinutes;
  final int criticalDelayMinutes;
  final int sortIndex;
  final DateTime? lastScheduledAt;
  final DateTime? lastCompletedAt;
  final int? lastDelayMinutes;
  final RoutineComplianceStatus? lastStatus;
  final bool lastEdited;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory RoutineModel.fromJson(Map<String, dynamic> json) =>
      _$RoutineModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineModelToJson(this);

  RoutineEntity toEntity() {
    final thresholds = RoutineThresholdSetting(
      allowableDelayMinutes: allowableDelayMinutes,
      criticalDelayMinutes: criticalDelayMinutes,
    );

    return RoutineEntity(
      id: id,
      name: name,
      targetTime: RoutineTime(hour: targetHour, minute: targetMinute),
      thresholds: thresholds,
      lastResult: _lastCompletionResult(),
      sortIndex: sortIndex,
    );
  }

  RoutineCompletionResultEntity? _lastCompletionResult() {
    if (lastScheduledAt == null ||
        lastCompletedAt == null ||
        lastDelayMinutes == null ||
        lastStatus == null) {
      return null;
    }

    return RoutineCompletionResultEntity(
      routineId: id,
      scheduledDateTime: lastScheduledAt!,
      completedAt: lastCompletedAt!,
      status: lastStatus!,
      delayMinutes: lastDelayMinutes!,
      edited: lastEdited,
    );
  }

  RoutineTableCompanion toCompanion({DateTime? now}) {
    final effectiveNow = now ?? DateTime.now();
    return RoutineTableCompanion(
      id: Value(id),
      name: Value(name),
      targetHour: Value(targetHour),
      targetMinute: Value(targetMinute),
      allowableDelayMinutes: Value(allowableDelayMinutes),
      criticalDelayMinutes: Value(criticalDelayMinutes),
      sortIndex: Value(sortIndex),
      lastScheduledAt: Value(lastScheduledAt),
      lastCompletedAt: Value(lastCompletedAt),
      lastDelayMinutes: Value(lastDelayMinutes),
      lastStatus: Value(lastStatus?.name),
      lastEdited: Value(lastEdited),
      createdAt: Value(createdAt ?? effectiveNow),
      updatedAt: Value(effectiveNow),
    );
  }

  RoutineModel copyWithCompletion(RoutineCompletionResultEntity result) =>
      copyWith(
        lastScheduledAt: result.scheduledDateTime,
        lastCompletedAt: result.completedAt,
        lastDelayMinutes: result.delayMinutes,
        lastStatus: result.status,
      );

  RoutineModel copyWith({
    String? id,
    String? name,
    int? targetHour,
    int? targetMinute,
    int? allowableDelayMinutes,
    int? criticalDelayMinutes,
    int? sortIndex,
    DateTime? lastScheduledAt,
    DateTime? lastCompletedAt,
    int? lastDelayMinutes,
    RoutineComplianceStatus? lastStatus,
    bool? lastEdited,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RoutineModel(
      id: id ?? this.id,
      name: name ?? this.name,
      targetHour: targetHour ?? this.targetHour,
      targetMinute: targetMinute ?? this.targetMinute,
      allowableDelayMinutes:
          allowableDelayMinutes ?? this.allowableDelayMinutes,
      criticalDelayMinutes: criticalDelayMinutes ?? this.criticalDelayMinutes,
      sortIndex: sortIndex ?? this.sortIndex,
      lastScheduledAt: lastScheduledAt ?? this.lastScheduledAt,
      lastCompletedAt: lastCompletedAt ?? this.lastCompletedAt,
      lastDelayMinutes: lastDelayMinutes ?? this.lastDelayMinutes,
      lastStatus: lastStatus ?? this.lastStatus,
      lastEdited: lastEdited ?? this.lastEdited,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static RoutineModel fromEntity(RoutineEntity entity) {
    final lastResult = entity.lastResult;
    return RoutineModel(
      id: entity.id,
      name: entity.name,
      targetHour: entity.targetTime.hour,
      targetMinute: entity.targetTime.minute,
      allowableDelayMinutes: entity.thresholds.allowableDelayMinutes,
      criticalDelayMinutes: entity.thresholds.criticalDelayMinutes,
      sortIndex: entity.sortIndex,
      lastScheduledAt: lastResult?.scheduledDateTime,
      lastCompletedAt: lastResult?.completedAt,
      lastDelayMinutes: lastResult?.delayMinutes,
      lastStatus: lastResult?.status,
      lastEdited: lastResult?.edited ?? false,
    );
  }

  static RoutineModel fromData(RoutineTableData data) {
    return RoutineModel(
      id: data.id,
      name: data.name,
      targetHour: data.targetHour,
      targetMinute: data.targetMinute,
      allowableDelayMinutes: data.allowableDelayMinutes,
      criticalDelayMinutes: data.criticalDelayMinutes,
      sortIndex: data.sortIndex,
      lastScheduledAt: data.lastScheduledAt,
      lastCompletedAt: data.lastCompletedAt,
      lastDelayMinutes: data.lastDelayMinutes,
      lastStatus: _parseStatus(data.lastStatus),
      lastEdited: data.lastEdited,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  static RoutineComplianceStatus? _parseStatus(String? value) {
    if (value == null) {
      return null;
    }
    return RoutineComplianceStatus.values.firstWhere(
      (element) => element.name == value,
      orElse: () => RoutineComplianceStatus.onTime,
    );
  }
}
