// ポモドーロタイマーのNotifierクラス（Riverpodアノテーション使用）
// セッション制御と状態管理を行う

import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../1_domain/1_entities/timer_config.dart';
import '../../1_domain/1_entities/pomodoro_session.dart';
import '../../1_domain/2_repositories/timer_repository.dart';
import '../1_states/pomodoro_state.dart';
import '../2_providers/timer_repository_provider.dart';

part 'pomodoro_notifier.g.dart';

@riverpod
class PomodoroNotifier extends _$PomodoroNotifier {
  late final TimerRepository _timerRepository;
  StreamSubscription<PomodoroSession?>? _subscription;
  
  @override
  PomodoroState build() {
    // Infrastructure層の実装が提供されるまで、ここは未実装例外が飛ぶ可能性があります
    _timerRepository = ref.watch(timerRepositoryProvider);

    // セッション状態の購読を開始（dispose時に解除）
    _subscribeToSession();
    ref.onDispose(() async {
      await _subscription?.cancel();
    });

    return const PomodoroState();
  }
  
  // セッション状態を購読してstate更新
  void _subscribeToSession() {
    _subscription?.cancel();
    _subscription = _timerRepository.watchSession().listen((session) {
      state = state.copyWith(currentSession: session);
    });
  }
  
  // ポモドーロ開始
  Future<void> startPomodoro({TimerConfig? config}) async {
    try {
      state = state.copyWith(isStarting: true, errorMessage: null);

      final useConfig = config ?? state.config;
      await _timerRepository.start(config: useConfig);

      state = state.copyWith(
        isStarting: false,
        config: useConfig,
      );
    } catch (e) {
      state = state.copyWith(
        isStarting: false,
        errorMessage: 'タイマーの開始に失敗しました: $e',
      );
    }
  }
  
  // 一時停止
  Future<void> pausePomodoro() async {
    try {
      state = state.copyWith(isUpdating: true);
      await _timerRepository.pause();
      state = state.copyWith(isUpdating: false);
    } catch (e) {
      state = state.copyWith(
        isUpdating: false,
        errorMessage: '一時停止に失敗しました: $e',
      );
    }
  }
  
  // 再開
  Future<void> resumePomodoro() async {
    try {
      state = state.copyWith(isUpdating: true);
      await _timerRepository.resume();
      state = state.copyWith(isUpdating: false);
    } catch (e) {
      state = state.copyWith(
        isUpdating: false,
        errorMessage: '再開に失敗しました: $e',
      );
    }
  }
  
  // リセット（停止）
  Future<void> resetPomodoro() async {
    try {
      state = state.copyWith(isUpdating: true);
      await _timerRepository.reset();
      state = state.copyWith(isUpdating: false);
    } catch (e) {
      state = state.copyWith(
        isUpdating: false,
        errorMessage: 'リセットに失敗しました: $e',
      );
    }
  }
  
  // 設定を更新
  void updateConfig(TimerConfig config) {
    state = state.copyWith(config: config);
  }
  
  // エラーメッセージをクリア
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}