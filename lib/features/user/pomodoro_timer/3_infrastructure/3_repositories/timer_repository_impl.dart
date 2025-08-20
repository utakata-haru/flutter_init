// TimerRepository の具体実装（Infrastructure層）
// 内部タイマー（Timer.periodic）で1秒ごとに経過を更新し、
// 現在のセッション状態をStreamで公開します。

import 'dart:async';

import '../../1_domain/1_entities/pomodoro_session.dart';
import '../../1_domain/1_entities/timer_config.dart';
import '../../1_domain/2_repositories/timer_repository.dart';

class TimerRepositoryImpl implements TimerRepository {
  // セッションのブロードキャスト用ストリーム
  final _controller = StreamController<PomodoroSession?>.broadcast();

  // 現在のセッションとタイマー
  PomodoroSession? _current;
  Timer? _ticker;

  // 現在の設定と完了フォーカス回数
  TimerConfig _config = TimerConfig.defaultConfig;
  int _completedFocusCount = 0;

  // セッションの購読
  @override
  Stream<PomodoroSession?> watchSession() => _controller.stream;

  // ポモドーロ開始
  @override
  Future<void> start({required TimerConfig config}) async {
    // 既存のタイマーを停止
    await _stopTicker();

    // 設定を保存
    _config = config;

    // 新しいセッションを作成（フォーカスから開始）
    _current = PomodoroSession(
      id: DateTime.now().microsecondsSinceEpoch.toString(), // 簡易な一意ID
      phase: PomodoroPhase.focus,
      remainingSeconds: config.focusSeconds,
      elapsedSeconds: 0,
      status: SessionStatus.ongoing,
      completedFocusCount: _completedFocusCount,
      startedAt: DateTime.now(),
    );

    // ストリームに初期状態を流す
    _emit();

    // 1秒ごとのタイマー開始
    _startTicker();
  }

  // 一時停止
  @override
  Future<void> pause() async {
    if (_current == null) return;
    await _stopTicker();
    _current = _current!.copyWith(status: SessionStatus.paused);
    _emit();
  }

  // 再開
  @override
  Future<void> resume() async {
    if (_current == null) return;
    if (_current!.status == SessionStatus.paused) {
      _current = _current!.copyWith(status: SessionStatus.ongoing);
      _emit();
      _startTicker();
    }
  }

  // リセット（停止）
  @override
  Future<void> reset() async {
    await _stopTicker();
    _current = null;
    _emit();
  }

  // タイマー開始
  void _startTicker() {
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      final cur = _current;
      if (cur == null) return;
      if (cur.status != SessionStatus.ongoing) return;

      final remaining = cur.remainingSeconds - 1;
      final elapsed = cur.elapsedSeconds + 1;

      if (remaining <= 0) {
        // フェーズ完了時の遷移
        _handlePhaseCompletion(cur);
        return;
      }

      _current = cur.copyWith(
        remainingSeconds: remaining,
        elapsedSeconds: elapsed,
      );
      _emit();
    });
  }

  // タイマー停止
  Future<void> _stopTicker() async {
    _ticker?.cancel();
    _ticker = null;
  }

  // フェーズ完了時の処理と遷移
  void _handlePhaseCompletion(PomodoroSession cur) {
    if (cur.phase == PomodoroPhase.focus) {
      // フォーカス終了
      _completedFocusCount = cur.completedFocusCount + 1;
      final isLongBreak = _completedFocusCount % _config.longBreakInterval == 0;
      final nextPhase = isLongBreak ? PomodoroPhase.longBreak : PomodoroPhase.shortBreak;
      final nextSeconds = isLongBreak ? _config.longBreakSeconds : _config.shortBreakSeconds;

      _current = cur.copyWith(
        phase: nextPhase,
        remainingSeconds: nextSeconds,
        elapsedSeconds: 0,
        status: SessionStatus.ongoing,
        completedFocusCount: _completedFocusCount,
      );
      _emit();
      return;
    }

    // 休憩終了 -> 次はフォーカス
    _current = cur.copyWith(
      phase: PomodoroPhase.focus,
      remainingSeconds: _config.focusSeconds,
      elapsedSeconds: 0,
      status: SessionStatus.ongoing,
    );
    _emit();
  }

  // 現在のセッションをストリームに流す
  void _emit() {
    if (!_controller.isClosed) {
      _controller.add(_current);
    }
  }

  // 明示的に破棄したい場合に呼び出し可能
  Future<void> dispose() async {
    await _stopTicker();
    await _controller.close();
  }
}