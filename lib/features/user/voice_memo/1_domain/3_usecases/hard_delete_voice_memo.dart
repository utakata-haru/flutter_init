// UseCase: 完全削除（物理削除）

import '../2_repositories/voice_memo_repository.dart';

class HardDeleteVoiceMemo {
  final VoiceMemoRepository _repository;
  const HardDeleteVoiceMemo(this._repository);

  Future<void> call(String id) {
    return _repository.hardDelete(id);
  }
}