import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/database/database.dart';
import '../../1_domain/1_entities/routine_entity.dart';

part 'routine_settings_model.g.dart';

@JsonSerializable()
class RoutineSettingsModel {
  const RoutineSettingsModel({
    required this.id,
    required this.allowableDelayMinutes,
    required this.criticalDelayMinutes,
    required this.updatedAt,
  });

  final String id;
  final int allowableDelayMinutes;
  final int criticalDelayMinutes;
  final DateTime updatedAt;

  factory RoutineSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$RoutineSettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineSettingsModelToJson(this);

  RoutineThresholdSetting toEntity() => RoutineThresholdSetting(
        allowableDelayMinutes: allowableDelayMinutes,
        criticalDelayMinutes: criticalDelayMinutes,
      );

  RoutineSettingsModel copyWith({
    String? id,
    int? allowableDelayMinutes,
    int? criticalDelayMinutes,
    DateTime? updatedAt,
  }) {
    return RoutineSettingsModel(
      id: id ?? this.id,
      allowableDelayMinutes:
          allowableDelayMinutes ?? this.allowableDelayMinutes,
      criticalDelayMinutes: criticalDelayMinutes ?? this.criticalDelayMinutes,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  RoutineSettingsTableCompanion toCompanion({DateTime? now}) {
    final effectiveUpdatedAt = now ?? updatedAt;
    return RoutineSettingsTableCompanion(
      id: Value(id),
      allowableDelayMinutes: Value(allowableDelayMinutes),
      criticalDelayMinutes: Value(criticalDelayMinutes),
      updatedAt: Value(effectiveUpdatedAt),
    );
  }

  static RoutineSettingsModel fromData(RoutineSettingsTableData data) {
    return RoutineSettingsModel(
      id: data.id,
      allowableDelayMinutes: data.allowableDelayMinutes,
      criticalDelayMinutes: data.criticalDelayMinutes,
      updatedAt: data.updatedAt,
    );
  }

  static RoutineSettingsModel fromEntity(
    RoutineThresholdSetting entity, {
    required String id,
    DateTime? updatedAt,
  }) {
    return RoutineSettingsModel(
      id: id,
      allowableDelayMinutes: entity.allowableDelayMinutes,
      criticalDelayMinutes: entity.criticalDelayMinutes,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}