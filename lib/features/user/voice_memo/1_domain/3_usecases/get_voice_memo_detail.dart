// UseCase: 詳細取得

import '../1_entities/voice_memo_entity.dart';
import '../2_repositories/voice_memo_repository.dart';

class GetVoiceMemoDetail {
  final VoiceMemoRepository _repository;
  const GetVoiceMemoDetail(this._repository);

  Future<VoiceMemo?> call(String id) {
    return _repository.getById(id);
  }
}