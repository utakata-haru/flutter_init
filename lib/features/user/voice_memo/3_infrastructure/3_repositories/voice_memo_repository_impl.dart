// インフラ層: VoiceMemoRepository の実装
// 役割: DataSource を用いてドメインの抽象リポジトリを実現する

import '../../1_domain/1_entities/tag_entity.dart';
import '../../1_domain/1_entities/voice_memo_entity.dart';
import '../../1_domain/2_repositories/voice_memo_repository.dart';
import '../1_data_sources/1_local/voice_memo_local_data_source.dart';

class VoiceMemoRepositoryImpl implements VoiceMemoRepository {
  final VoiceMemoLocalDataSource _local;

  VoiceMemoRepositoryImpl({VoiceMemoLocalDataSource? local})
      : _local = local ?? VoiceMemoLocalDataSource();

  @override
  Future<VoiceMemo> create({
    required String title,
    required List<Tag> tags,
    bool isStarred = false,
    String? note,
    required int durationMs,
    required String audioPath,
    required DateTime createdAt,
  }) {
    return _local.create(
      title: title,
      tags: tags,
      isStarred: isStarred,
      note: note,
      durationMs: durationMs,
      audioPath: audioPath,
      createdAt: createdAt,
    );
  }

  @override
  Future<VoiceMemo> updateMeta({
    required String id,
    String? title,
    List<Tag>? tags,
    bool? isStarred,
    String? note,
  }) {
    return _local.updateMeta(
      id: id,
      title: title,
      tags: tags,
      isStarred: isStarred,
      note: note,
    );
  }

  @override
  Future<void> moveToTrash(String id) {
    return _local.moveToTrash(id);
  }

  @override
  Future<void> restoreFromTrash(String id) {
    return _local.restoreFromTrash(id);
  }

  @override
  Future<void> hardDelete(String id) {
    return _local.hardDelete(id);
  }

  @override
  Future<List<VoiceMemo>> list({bool includeTrashed = false}) {
    return _local.list(includeTrashed: includeTrashed);
  }

  @override
  Future<VoiceMemo?> getById(String id) {
    return _local.getById(id);
  }

  @override
  Future<List<VoiceMemo>> search({
    String? query,
    List<Tag>? tags,
    DateTime? from,
    DateTime? to,
    bool? starredOnly,
  }) {
    return _local.search(
      query: query,
      tags: tags,
      from: from,
      to: to,
      starredOnly: starredOnly,
    );
  }

  @override
  Future<VoiceMemo> requestTranscription({required String id}) {
    return _local.requestTranscription(id: id);
  }
}