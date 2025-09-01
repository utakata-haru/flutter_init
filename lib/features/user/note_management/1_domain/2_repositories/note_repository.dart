import '../1_entities/note_entity.dart';

/// メモ管理のためのリポジトリインターフェース
/// 
/// データアクセスの抽象化を提供し、具体的な実装（SQLite、API等）から
/// ドメイン層を分離する役割を担います。
abstract class NoteRepository {
  /// 単一メモの取得
  /// 
  /// [id] 取得したいメモのID
  /// 戻り値: 指定されたIDのメモ、存在しない場合はnull
  Future<NoteEntity?> getNoteById(String id);

  /// 全メモの取得
  /// 
  /// [limit] 取得件数の上限（指定しない場合は全件）
  /// [offset] 取得開始位置（ページネーション用）
  /// 戻り値: メモのリスト（作成日時の降順）
  Future<List<NoteEntity>> getNotes({
    int? limit,
    int? offset,
  });

  /// メモの検索
  /// 
  /// [query] 検索クエリ（タイトルと本文を対象）
  /// [limit] 取得件数の上限
  /// [offset] 取得開始位置
  /// 戻り値: 検索条件に合致するメモのリスト
  Future<List<NoteEntity>> searchNotes(
    String query, {
    int? limit,
    int? offset,
  });

  /// メモの作成
  /// 
  /// [note] 作成するメモのエンティティ
  /// 戻り値: 作成されたメモ（IDや作成日時が設定済み）
  Future<NoteEntity> createNote(NoteEntity note);

  /// メモの更新
  /// 
  /// [note] 更新するメモのエンティティ
  /// 戻り値: 更新されたメモ
  /// 例外: 指定されたIDのメモが存在しない場合
  Future<NoteEntity> updateNote(NoteEntity note);

  /// メモの削除
  /// 
  /// [id] 削除するメモのID
  /// 例外: 指定されたIDのメモが存在しない場合
  Future<void> deleteNote(String id);

  /// 全メモの削除
  /// 
  /// 主にテストやリセット処理で使用
  Future<void> deleteAllNotes();

  /// メモ件数の取得
  /// 
  /// 戻り値: 保存されているメモの総数
  Future<int> getNotesCount();

  /// 最近更新されたメモの取得
  /// 
  /// [limit] 取得件数（デフォルト: 10件）
  /// 戻り値: 更新日時の降順でソートされたメモのリスト
  Future<List<NoteEntity>> getRecentlyUpdatedNotes({int limit = 10});

  /// 新規作成されたメモの取得
  /// 
  /// [daysAgo] 何日前までを「新規」とするか（デフォルト: 7日）
  /// 戻り値: 指定期間内に作成されたメモのリスト
  Future<List<NoteEntity>> getRecentlyCreatedNotes({int daysAgo = 7});
}
