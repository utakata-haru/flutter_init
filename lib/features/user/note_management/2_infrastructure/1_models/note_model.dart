import 'package:json_annotation/json_annotation.dart';
import '../../1_domain/1_entities/note_entity.dart';

part 'note_model.g.dart';

/// メモデータモデル
/// 
/// 外部データソース（SQLite、API等）とNoteEntityの間の変換を担当します。
/// JSON⇔Model、SQLite⇔Model、Model⇔Entityの変換機能を提供します。
@JsonSerializable()
class NoteModel {
  final String id;
  final String title;
  final String content;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  /// JSONからNoteModelを作成
  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  /// NoteModelをJSONに変換
  Map<String, dynamic> toJson() => _$NoteModelToJson(this);

  /// SQLiteマップからNoteModelを作成
  factory NoteModel.fromSQLiteMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  /// NoteModelをSQLiteマップに変換
  Map<String, dynamic> toSQLiteMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// NoteEntityからNoteModelを作成
  factory NoteModel.fromEntity(NoteEntity entity) {
    return NoteModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// NoteModelをNoteEntityに変換
  NoteEntity toEntity() {
    return NoteEntity(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// APIレスポンス用のファクトリーコンストラクター（将来の拡張用）
  factory NoteModel.fromApiResponse(Map<String, dynamic> response) {
    return NoteModel(
      id: response['id'] as String,
      title: response['title'] as String,
      content: response['content'] as String,
      createdAt: DateTime.parse(response['created_at'] as String),
      updatedAt: DateTime.parse(response['updated_at'] as String),
    );
  }

  /// API送信用のマップ形式変換（将来の拡張用）
  Map<String, dynamic> toApiRequest() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// バッチインポート用のCSV形式対応（将来の拡張用）
  factory NoteModel.fromCsvRow(List<String> csvRow) {
    if (csvRow.length < 5) {
      throw ArgumentError('CSV行の形式が不正です。5列必要です。');
    }

    return NoteModel(
      id: csvRow[0],
      title: csvRow[1],
      content: csvRow[2],
      createdAt: DateTime.parse(csvRow[3]),
      updatedAt: DateTime.parse(csvRow[4]),
    );
  }

  /// CSV形式での出力（バックアップ機能等で使用）
  List<String> toCsvRow() {
    return [
      id,
      title,
      content,
      createdAt.toIso8601String(),
      updatedAt.toIso8601String(),
    ];
  }

  /// デバッグ用文字列表現
  @override
  String toString() {
    return 'NoteModel(id: $id, title: $title, content: ${content.length} chars, '
        'createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  /// 等価性比較
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NoteModel &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  /// ハッシュコード
  @override
  int get hashCode {
    return Object.hash(id, title, content, createdAt, updatedAt);
  }

  /// モデルのコピーを作成（更新処理で使用）
  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
