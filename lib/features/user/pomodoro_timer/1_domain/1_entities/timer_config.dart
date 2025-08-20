// ポモドーロの設定エンティティ（Domain層）
// Freezedで不変・比較容易にする

import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_config.freezed.dart';

@freezed
class TimerConfig with _$TimerConfig {
  const factory TimerConfig({
    // 集中（フォーカス）時間（分）
    required int focusMinutes,
    // 短い休憩（分）
    required int shortBreakMinutes,
    // 長い休憩（分）
    required int longBreakMinutes,
    // 長い休憩の間隔（n回のフォーカスごと）
    required int longBreakInterval,
  }) = _TimerConfig;

  const TimerConfig._();

  // 総分→総秒のユーティリティ（UIやデータ層で利用）
  int get focusSeconds => focusMinutes * 60;
  int get shortBreakSeconds => shortBreakMinutes * 60;
  int get longBreakSeconds => longBreakMinutes * 60;

  // デフォルト設定（おすすめ）
  static const defaultConfig = TimerConfig(
    focusMinutes: 25,
    shortBreakMinutes: 5,
    longBreakMinutes: 15,
    longBreakInterval: 4,
  );
}