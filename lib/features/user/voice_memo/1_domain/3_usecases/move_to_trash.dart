// UseCase: ゴミ箱に移動

import '../2_repositories/voice_memo_repository.dart';

class MoveToTrash {
  final VoiceMemoRepository _repository;
  const MoveToTrash(this._repository);

  Future<void> call(String id) {
    return _repository.moveToTrash(id);
  }
}