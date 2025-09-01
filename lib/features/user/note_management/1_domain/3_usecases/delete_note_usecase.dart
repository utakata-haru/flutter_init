import '../2_repositories/note_repository.dart';

/// メモ削除ユースケース
/// 
/// 指定されたメモを削除するビジネスロジックを実装します。
/// 存在確認、削除処理を行います。
class DeleteNoteUseCase {
  final NoteRepository _noteRepository;

  DeleteNoteUseCase(this._noteRepository);

  /// 指定されたIDのメモを削除する
  /// 
  /// [id] 削除するメモのID
  /// 
  /// Throws:
  /// - [ArgumentException] IDが無効な場合
  /// - [NoteNotFoundException] メモが見つからない場合
  Future<void> call(String id) async {
    // 入力検証
    if (id.isEmpty) {
      throw ArgumentError('メモIDは必須です');
    }

    // メモの存在確認
    final existingNote = await _noteRepository.getNoteById(id);
    if (existingNote == null) {
      throw NoteNotFoundException('ID: $id のメモが見つかりません');
    }

    // リポジトリを通じてメモを削除
    await _noteRepository.deleteNote(id);
  }

  /// メモの存在確認なしで削除する（パフォーマンス重視版）
  /// 
  /// [id] 削除するメモのID
  /// 
  /// 注意: メモの存在確認を行わないため、存在しないIDを指定しても
  /// 例外はスローされません。パフォーマンスを重視する場合に使用。
  /// 
  /// Throws:
  /// - [ArgumentException] IDが無効な場合
  Future<void> callUnsafe(String id) async {
    // 入力検証
    if (id.isEmpty) {
      throw ArgumentError('メモIDは必須です');
    }

    // 存在確認なしで削除
    await _noteRepository.deleteNote(id);
  }

  /// 全メモを削除する
  /// 
  /// 主にテストやアプリリセット機能で使用。
  /// 
  /// Throws:
  /// - [DeletionException] 削除処理に失敗した場合
  Future<void> deleteAll() async {
    try {
      await _noteRepository.deleteAllNotes();
    } catch (e) {
      throw DeletionException('全メモの削除に失敗しました: $e');
    }
  }

  /// 複数のメモを一括削除する
  /// 
  /// [ids] 削除するメモのIDリスト
  /// 
  /// Returns: 削除に成功したメモのIDリスト
  /// 
  /// 注意: 一部のメモが存在しない場合でも、存在するメモのみ削除されます。
  /// 
  /// Throws:
  /// - [ArgumentException] IDリストが無効な場合
  Future<List<String>> deleteBatch(List<String> ids) async {
    // 入力検証
    if (ids.isEmpty) {
      throw ArgumentError('削除対象のIDリストが空です');
    }

    final successfullyDeleted = <String>[];

    for (final id in ids) {
      if (id.isEmpty) {
        continue; // 空のIDはスキップ
      }

      try {
        final existingNote = await _noteRepository.getNoteById(id);
        if (existingNote != null) {
          await _noteRepository.deleteNote(id);
          successfullyDeleted.add(id);
        }
      } catch (e) {
        // 個別の削除エラーはログに記録し、処理を継続
        // 実際のアプリケーションではログ出力を行う
        continue;
      }
    }

    return successfullyDeleted;
  }
}

/// メモが見つからない例外
class NoteNotFoundException implements Exception {
  final String message;
  NoteNotFoundException(this.message);

  @override
  String toString() => 'NoteNotFoundException: $message';
}

/// 削除処理例外
class DeletionException implements Exception {
  final String message;
  DeletionException(this.message);

  @override
  String toString() => 'DeletionException: $message';
}
