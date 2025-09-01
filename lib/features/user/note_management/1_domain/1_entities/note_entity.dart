import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_entity.freezed.dart';
part 'note_entity.g.dart';

@freezed
class NoteEntity with _$NoteEntity {
  const NoteEntity._(); // private constructor for methods

  const factory NoteEntity({
    required String id,
    required String title,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _NoteEntity;

  // JSONシリアライズが必要な場合のみ追加
  factory NoteEntity.fromJson(Map<String, dynamic> json) =>
      _$NoteEntityFromJson(json);

  // ビジネスロジック：タイトルのバリデーション
  bool get hasValidTitle => title.isNotEmpty && title.length <= 50;

  // ビジネスロジック：本文のバリデーション
  bool get hasValidContent => content.length <= 1000;

  // ビジネスロジック：メモの検索マッチング
  bool matchesSearchQuery(String query) {
    if (query.isEmpty) return true;
    final lowerQuery = query.toLowerCase();
    return title.toLowerCase().contains(lowerQuery) ||
        content.toLowerCase().contains(lowerQuery);
  }

  // ビジネスロジック：メモが新規作成後の状態かどうか
  bool get isNewlyCreated {
    final now = DateTime.now();
    final diff = now.difference(createdAt);
    return diff.inMinutes < 5; // 5分以内は新規作成とみなす
  }

  // ビジネスロジック：メモのプレビューテキスト生成
  String get previewText {
    if (content.isEmpty) return '';
    const maxLength = 100;
    if (content.length <= maxLength) return content;
    return '${content.substring(0, maxLength)}...';
  }

  // バリデーションメソッド
  List<String> validate() {
    final errors = <String>[];

    if (title.isEmpty) {
      errors.add('タイトルは必須です');
    }

    if (title.length > 50) {
      errors.add('タイトルは50文字以内で入力してください');
    }

    if (content.length > 1000) {
      errors.add('本文は1000文字以内で入力してください');
    }

    return errors;
  }

  bool get isValid => validate().isEmpty;

  // 新規メモ作成用のファクトリーコンストラクター
  factory NoteEntity.create({
    required String title,
    required String content,
  }) {
    final now = DateTime.now();
    return NoteEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      createdAt: now,
      updatedAt: now,
    );
  }

  // メモ更新用のcopyWithメソッド（更新日時も更新）
  NoteEntity updateNote({
    String? title,
    String? content,
  }) {
    return copyWith(
      title: title ?? this.title,
      content: content ?? this.content,
      updatedAt: DateTime.now(),
    );
  }
}
