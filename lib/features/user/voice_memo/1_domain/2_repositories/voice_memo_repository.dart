// ドメイン層: VoiceMemo リポジトリの抽象インターフェース
// インフラ詳細に依存せず、アプリケーションロジックから利用されます。

import '../1_entities/voice_memo_entity.dart';
import '../1_entities/tag_entity.dart';

abstract class VoiceMemoRepository {
  // 作成: id 生成は実装側に委譲
  Future<VoiceMemo> create({
    required String title,
    required List<Tag> tags,
    bool isStarred = false,
    String? note,
    required int durationMs,
    required String audioPath,
    required DateTime createdAt,
  });

  // メタ情報の更新（部分更新）。updatedAt は実装側で適切に更新。
  Future<VoiceMemo> updateMeta({
    required String id,
    String? title,
    List<Tag>? tags,
    bool? isStarred,
    String? note,
  });

  // ゴミ箱への移動/復元/完全削除
  Future<void> moveToTrash(String id);
  Future<void> restoreFromTrash(String id);
  Future<void> hardDelete(String id);

  // 一覧・詳細
  Future<List<VoiceMemo>> list({bool includeTrashed = false});
  Future<VoiceMemo?> getById(String id);

  // 検索（全文: タイトル/メモ/文字起こし、絞り込み: タグ/期間/スター）
  Future<List<VoiceMemo>> search({
    String? query,
    List<Tag>? tags,
    DateTime? from,
    DateTime? to,
    bool? starredOnly,
  });

  // 文字起こしの実行要求（状態遷移は実装側で制御）
  Future<VoiceMemo> requestTranscription({required String id});
}