// ポモドーロ開始ユースケース

import '../1_entities/timer_config.dart';
import '../2_repositories/timer_repository.dart';

class StartPomodoro {
  final TimerRepository _repo;
  const StartPomodoro(this._repo);

  Future<void> call({TimerConfig config = TimerConfig.defaultConfig}) async {
    // デフォルト設定で開始（ユーザー設定はApplication層→Infrastructureで適用予定）
    await _repo.start(config: config);
  }
}