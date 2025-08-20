// ポモドーロリセット（停止）ユースケース

import '../2_repositories/timer_repository.dart';

class ResetPomodoro {
  final TimerRepository _repo;
  const ResetPomodoro(this._repo);

  Future<void> call() => _repo.reset();
}