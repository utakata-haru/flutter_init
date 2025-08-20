// ポモドーロタイマーのApplication層状態クラス
// UIに表示される情報を集約

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../1_domain/1_entities/pomodoro_session.dart';
import '../../1_domain/1_entities/timer_config.dart';

part 'pomodoro_state.freezed.dart';

@freezed
class PomodoroState with _$PomodoroState {
  // Freezedクラスに独自メソッド/ゲッターを定義するためのプライベートコンストラクタ
  const PomodoroState._();

  const factory PomodoroState({
    // 現在のセッション（ない場合null）
    PomodoroSession? currentSession,

    // 使用中の設定
    @Default(TimerConfig.defaultConfig) TimerConfig config,

    // UI状態のメタ情報
    @Default(false) bool isStarting, // 開始処理中フラグ
    @Default(false) bool isUpdating, // 状態変更処理中フラグ

    // エラーハンドリング
    String? errorMessage,
  }) = _PomodoroState;

  // セッション実行中かどうか
  bool get isRunning => currentSession != null;

  // 現在の進捗率（0.0-1.0）
  double get progress {
    final session = currentSession;
    if (session == null) return 0.0;

    final phaseSeconds = _getPhaseDurationSeconds(session.phase);
    if (phaseSeconds == 0) return 0.0;

    final elapsed = session.elapsedSeconds;
    return (elapsed / phaseSeconds).clamp(0.0, 1.0);
  }

  // フェーズごとの継続時間を取得
  int _getPhaseDurationSeconds(PomodoroPhase phase) {
    switch (phase) {
      case PomodoroPhase.focus:
        return config.focusMinutes * 60;
      case PomodoroPhase.shortBreak:
        return config.shortBreakMinutes * 60;
      case PomodoroPhase.longBreak:
        return config.longBreakMinutes * 60;
    }
  }
}