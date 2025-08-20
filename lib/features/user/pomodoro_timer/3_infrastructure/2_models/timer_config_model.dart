// TimerConfigのデータモデル（Domain Entity ↔ データストレージ間の変換）
// Infrastructure層でのデータ永続化時に使用

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../1_domain/1_entities/timer_config.dart';

part 'timer_config_model.freezed.dart';
part 'timer_config_model.g.dart';

@freezed
class TimerConfigModel with _$TimerConfigModel {
  const factory TimerConfigModel({
    required int focusMinutes,
    required int shortBreakMinutes,
    required int longBreakMinutes,
    required int longBreakInterval,
  }) = _TimerConfigModel;

  factory TimerConfigModel.fromJson(Map<String, dynamic> json) =>
      _$TimerConfigModelFromJson(json);
}

// Domain Entity → Data Model への変換拡張
extension TimerConfigModelExtension on TimerConfigModel {
  // Data Model → Domain Entity への変換
  TimerConfig toDomainEntity() {
    return TimerConfig(
      focusMinutes: focusMinutes,
      shortBreakMinutes: shortBreakMinutes,
      longBreakMinutes: longBreakMinutes,
      longBreakInterval: longBreakInterval,
    );
  }
}

// Domain Entity → Data Model への変換拡張
extension TimerConfigToDomainExtension on TimerConfig {
  // Domain Entity → Data Model への変換
  TimerConfigModel toDataModel() {
    return TimerConfigModel(
      focusMinutes: focusMinutes,
      shortBreakMinutes: shortBreakMinutes,
      longBreakMinutes: longBreakMinutes,
      longBreakInterval: longBreakInterval,
    );
  }
}