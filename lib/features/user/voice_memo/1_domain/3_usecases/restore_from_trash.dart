// UseCase: ゴミ箱から復元

import '../2_repositories/voice_memo_repository.dart';

class RestoreFromTrash {
  final VoiceMemoRepository _repository;
  const RestoreFromTrash(this._repository);

  Future<void> call(String id) {
    return _repository.restoreFromTrash(id);
  }
}