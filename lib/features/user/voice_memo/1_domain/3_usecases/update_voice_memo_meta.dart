// UseCase: メタ情報の更新（タイトル/タグ/スター/メモ）

import '../1_entities/tag_entity.dart';
import '../1_entities/voice_memo_entity.dart';
import '../2_repositories/voice_memo_repository.dart';

class UpdateVoiceMemoMeta {
  final VoiceMemoRepository _repository;
  const UpdateVoiceMemoMeta(this._repository);

  Future<VoiceMemo> call({
    required String id,
    String? title,
    List<Tag>? tags,
    bool? isStarred,
    String? note,
  }) {
    return _repository.updateMeta(
      id: id,
      title: title,
      tags: tags,
      isStarred: isStarred,
      note: note,
    );
  }
}