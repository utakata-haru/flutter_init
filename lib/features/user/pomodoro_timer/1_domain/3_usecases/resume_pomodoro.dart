// ポモドーロ再開ユースケース

import '../2_repositories/timer_repository.dart';

class ResumePomodoro {
  final TimerRepository _repo;
  const ResumePomodoro(this._repo);

  Future<void> call() => _repo.resume();
}