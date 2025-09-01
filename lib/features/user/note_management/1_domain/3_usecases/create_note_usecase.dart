import '../1_entities/note_entity.dart';
import '../2_repositories/note_repository.dart';

/// メモ作成ユースケース
/// 
/// 新しいメモを作成するビジネスロジックを実装します。
/// バリデーション、ビジネスルールの適用、永続化を行います。
class CreateNoteUseCase {
  final NoteRepository _noteRepository;

  CreateNoteUseCase(this._noteRepository);

  /// メモを作成する
  /// 
  /// [title] メモのタイトル
  /// [content] メモの本文
  /// 
  /// Returns: 作成されたメモエンティティ
  /// 
  /// Throws:
  /// - [ArgumentException] タイトルまたは本文が無効な場合
  /// - [ValidationException] バリデーションエラーの場合
  Future<NoteEntity> call({
    required String title,
    required String content,
  }) async {
    // 入力検証
    if (title.isEmpty) {
      throw ArgumentError('タイトルは必須です');
    }

    if (title.length > 50) {
      throw ArgumentError('タイトルは50文字以内で入力してください');
    }

    if (content.length > 1000) {
      throw ArgumentError('本文は1000文字以内で入力してください');
    }

    // メモエンティティの作成
    final note = NoteEntity.create(
      title: title.trim(),
      content: content.trim(),
    );

    // エンティティレベルでのバリデーション
    final validationErrors = note.validate();
    if (validationErrors.isNotEmpty) {
      throw ValidationException(validationErrors.join(', '));
    }

    // リポジトリを通じてメモを永続化
    return await _noteRepository.createNote(note);
  }
}

/// バリデーション例外
class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}
