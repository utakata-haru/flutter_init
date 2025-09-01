import '../1_entities/note_entity.dart';
import '../2_repositories/note_repository.dart';

/// メモ詳細取得ユースケース
/// 
/// 指定されたIDのメモを取得するビジネスロジックを実装します。
class GetNoteByIdUseCase {
  final NoteRepository _noteRepository;

  GetNoteByIdUseCase(this._noteRepository);

  /// 指定されたIDのメモを取得する
  /// 
  /// [id] 取得したいメモのID
  /// 
  /// Returns: メモエンティティ、存在しない場合はnull
  /// 
  /// Throws:
  /// - [ArgumentException] IDが無効な場合
  Future<NoteEntity?> call(String id) async {
    // 入力検証
    if (id.isEmpty) {
      throw ArgumentError('メモIDは必須です');
    }

    // リポジトリからメモを取得
    return await _noteRepository.getNoteById(id);
  }

  /// 指定されたIDのメモを取得する（存在しない場合は例外をスロー）
  /// 
  /// [id] 取得したいメモのID
  /// 
  /// Returns: メモエンティティ
  /// 
  /// Throws:
  /// - [ArgumentException] IDが無効な場合
  /// - [NoteNotFoundException] メモが見つからない場合
  Future<NoteEntity> callRequired(String id) async {
    final note = await call(id);
    
    if (note == null) {
      throw NoteNotFoundException('ID: $id のメモが見つかりません');
    }

    return note;
  }
}

/// メモが見つからない例外
class NoteNotFoundException implements Exception {
  final String message;
  NoteNotFoundException(this.message);

  @override
  String toString() => 'NoteNotFoundException: $message';
}
