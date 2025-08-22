// UseCase: 一覧取得

import '../1_entities/voice_memo_entity.dart';
import '../2_repositories/voice_memo_repository.dart';

class ListVoiceMemos {
  final VoiceMemoRepository _repository;
  const ListVoiceMemos(this._repository);

  Future<List<VoiceMemo>> call({bool includeTrashed = false}) {
    return _repository.list(includeTrashed: includeTrashed);
  }
}