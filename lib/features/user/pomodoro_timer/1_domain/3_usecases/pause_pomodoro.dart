// ポモドーロ一時停止ユースケース

import '../2_repositories/timer_repository.dart';

class PausePomodoro {
  final TimerRepository _repo;
  const PausePomodoro(this._repo);

  Future<void> call() => _repo.pause();
}