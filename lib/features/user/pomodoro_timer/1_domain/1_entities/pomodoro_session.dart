// 1回のポモドーロセッション情報（Domain層）

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pomodoro_session.freezed.dart';

enum PomodoroPhase { focus, shortBreak, longBreak }

enum SessionStatus { ongoing, paused, completed, cancelled }

@freezed
class PomodoroSession with _$PomodoroSession {
  const factory PomodoroSession({
    // セッションID（履歴管理用）
    required String id,
    // 現在のフェーズ
    required PomodoroPhase phase,
    // 残り秒数
    required int remainingSeconds,
    // 経過秒数
    required int elapsedSeconds,
    // 状態
    required SessionStatus status,
    // 完了済みフォーカス数（長休憩判定用）
    @Default(0) int completedFocusCount,
    // 開始時刻
    required DateTime startedAt,
  }) = _PomodoroSession;
}