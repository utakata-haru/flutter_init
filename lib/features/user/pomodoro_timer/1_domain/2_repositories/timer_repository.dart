// タイマー制御の抽象リポジトリ（Domain層）
// Infrastructure層で実装し、アプリケーションからはこの抽象に依存

import '../1_entities/timer_config.dart';
import '../1_entities/pomodoro_session.dart';

abstract class TimerRepository {
  // 現在進行中のセッションストリーム（UI購読用）
  Stream<PomodoroSession?> watchSession();

  // セッションの開始
  Future<void> start({required TimerConfig config});

  // 一時停止/再開/停止
  Future<void> pause();
  Future<void> resume();
  Future<void> reset();
}