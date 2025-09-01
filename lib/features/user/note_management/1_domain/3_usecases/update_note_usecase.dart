import '../1_entities/note_entity.dart';
import '../2_repositories/note_repository.dart';

/// メモ更新ユースケース
/// 
/// 既存のメモを更新するビジネスロジックを実装します。
/// バリデーション、存在確認、更新処理を行います。
class UpdateNoteUseCase {
  final NoteRepository _noteRepository;

  UpdateNoteUseCase(this._noteRepository);

  /// メモを更新する
  /// 
  /// [id] 更新するメモのID
  /// [title] 新しいタイトル（nullの場合は変更しない）
  /// [content] 新しい本文（nullの場合は変更しない）
  /// 
  /// Returns: 更新されたメモエンティティ
  /// 
  /// Throws:
  /// - [ArgumentException] パラメータが無効な場合
  /// - [NoteNotFoundException] メモが見つからない場合
  /// - [ValidationException] バリデーションエラーの場合
  Future<NoteEntity> call({
    required String id,
    String? title,
    String? content,
  }) async {
    // 入力検証
    if (id.isEmpty) {
      throw ArgumentError('メモIDは必須です');
    }

    // 現在のメモを取得
    final currentNote = await _noteRepository.getNoteById(id);
    if (currentNote == null) {
      throw NoteNotFoundException('ID: $id のメモが見つかりません');
    }

    // 更新内容の準備
    final newTitle = title ?? currentNote.title;
    final newContent = content ?? currentNote.content;

    // バリデーション
    if (newTitle.isEmpty) {
      throw ArgumentError('タイトルは必須です');
    }

    if (newTitle.length > 50) {
      throw ArgumentError('タイトルは50文字以内で入力してください');
    }

    if (newContent.length > 1000) {
      throw ArgumentError('本文は1000文字以内で入力してください');
    }

    // メモの更新
    final updatedNote = currentNote.updateNote(
      title: newTitle.trim(),
      content: newContent.trim(),
    );

    // エンティティレベルでのバリデーション
    final validationErrors = updatedNote.validate();
    if (validationErrors.isNotEmpty) {
      throw ValidationException(validationErrors.join(', '));
    }

    // リポジトリを通じてメモを更新
    return await _noteRepository.updateNote(updatedNote);
  }

  /// メモ全体を置き換える
  /// 
  /// [noteEntity] 更新するメモエンティティ
  /// 
  /// Returns: 更新されたメモエンティティ
  /// 
  /// Throws:
  /// - [ArgumentException] エンティティが無効な場合
  /// - [NoteNotFoundException] メモが見つからない場合
  /// - [ValidationException] バリデーションエラーの場合
  Future<NoteEntity> updateWithEntity(NoteEntity noteEntity) async {
    // 現在のメモが存在するかチェック
    final currentNote = await _noteRepository.getNoteById(noteEntity.id);
    if (currentNote == null) {
      throw NoteNotFoundException('ID: ${noteEntity.id} のメモが見つかりません');
    }

    // エンティティレベルでのバリデーション
    final validationErrors = noteEntity.validate();
    if (validationErrors.isNotEmpty) {
      throw ValidationException(validationErrors.join(', '));
    }

    // リポジトリを通じてメモを更新
    return await _noteRepository.updateNote(noteEntity);
  }
}

/// メモが見つからない例外
class NoteNotFoundException implements Exception {
  final String message;
  NoteNotFoundException(this.message);

  @override
  String toString() => 'NoteNotFoundException: $message';
}

/// バリデーション例外
class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}
