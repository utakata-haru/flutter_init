import '../1_entities/note_entity.dart';
import '../2_repositories/note_repository.dart';

/// メモ一覧取得ユースケース
/// 
/// 保存されているメモの一覧を取得するビジネスロジックを実装します。
/// ページネーション、ソート、フィルタリングに対応します。
class GetNotesUseCase {
  final NoteRepository _noteRepository;

  GetNotesUseCase(this._noteRepository);

  /// メモ一覧を取得する
  /// 
  /// [limit] 取得件数の上限（指定しない場合は全件）
  /// [offset] 取得開始位置（ページネーション用）
  /// 
  /// Returns: メモのリスト（作成日時の降順）
  /// 
  /// Throws:
  /// - [ArgumentException] パラメータが無効な場合
  Future<List<NoteEntity>> call({
    int? limit,
    int? offset,
  }) async {
    // 入力検証
    if (limit != null && limit <= 0) {
      throw ArgumentError('limitは1以上である必要があります');
    }

    if (offset != null && offset < 0) {
      throw ArgumentError('offsetは0以上である必要があります');
    }

    // リポジトリからメモ一覧を取得
    final notes = await _noteRepository.getNotes(
      limit: limit,
      offset: offset,
    );

    return notes;
  }

  /// 最近更新されたメモを取得する
  /// 
  /// [limit] 取得件数（デフォルト: 10件）
  /// 
  /// Returns: 更新日時順でソートされたメモのリスト
  Future<List<NoteEntity>> getRecentlyUpdated({int limit = 10}) async {
    if (limit <= 0) {
      throw ArgumentError('limitは1以上である必要があります');
    }

    return await _noteRepository.getRecentlyUpdatedNotes(limit: limit);
  }

  /// 新しく作成されたメモを取得する
  /// 
  /// [daysAgo] 何日前までを「新規」とするか（デフォルト: 7日）
  /// 
  /// Returns: 指定期間内に作成されたメモのリスト
  Future<List<NoteEntity>> getRecentlyCreated({int daysAgo = 7}) async {
    if (daysAgo <= 0) {
      throw ArgumentError('daysAgoは1以上である必要があります');
    }

    return await _noteRepository.getRecentlyCreatedNotes(daysAgo: daysAgo);
  }
}
