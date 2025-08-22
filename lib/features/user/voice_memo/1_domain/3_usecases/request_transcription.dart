// UseCase: 文字起こしの実行要求

import '../1_entities/voice_memo_entity.dart';
import '../2_repositories/voice_memo_repository.dart';

class RequestTranscription {
  final VoiceMemoRepository _repository;
  const RequestTranscription(this._repository);

  Future<VoiceMemo> call({required String id}) {
    return _repository.requestTranscription(id: id);
  }
}