// UseCase: ボイスメモの作成
// Repository に委譲し、ドメインルールの単一入口を提供します。

import '../1_entities/tag_entity.dart';
import '../1_entities/voice_memo_entity.dart';
import '../2_repositories/voice_memo_repository.dart';

class CreateVoiceMemo {
  final VoiceMemoRepository _repository;
  const CreateVoiceMemo(this._repository);

  Future<VoiceMemo> call({
    required String title,
    required List<Tag> tags,
    bool isStarred = false,
    String? note,
    required int durationMs,
    required String audioPath,
    required DateTime createdAt,
  }) {
    return _repository.create(
      title: title,
      tags: tags,
      isStarred: isStarred,
      note: note,
      durationMs: durationMs,
      audioPath: audioPath,
      createdAt: createdAt,
    );
  }
}