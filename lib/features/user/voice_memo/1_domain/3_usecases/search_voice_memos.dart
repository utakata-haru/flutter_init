// UseCase: 検索（テキスト/タグ/期間/スター）

import '../1_entities/tag_entity.dart';
import '../1_entities/voice_memo_entity.dart';
import '../2_repositories/voice_memo_repository.dart';

class SearchVoiceMemos {
  final VoiceMemoRepository _repository;
  const SearchVoiceMemos(this._repository);

  Future<List<VoiceMemo>> call({
    String? query,
    List<Tag>? tags,
    DateTime? from,
    DateTime? to,
    bool? starredOnly,
  }) {
    return _repository.search(
      query: query,
      tags: tags,
      from: from,
      to: to,
      starredOnly: starredOnly,
    );
  }
}