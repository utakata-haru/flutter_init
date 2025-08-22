// ドメイン層: ボイスメモのエンティティ（MVP仕様に準拠）
// 端末内完結の前提で、音声ファイルパスやテキスト情報を保持します。

import 'tag_entity.dart';
import 'transcription_status_entity.dart';

class VoiceMemo {
  final String id; // UUIDを想定
  final String title;
  final List<Tag> tags; // 複数タグ
  final bool isStarred; // スター（お気に入り）
  final String? note; // 任意メモ
  final int durationMs; // 再生時間（ミリ秒）
  final String audioPath; // 端末内の音声ファイルパス
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isTrashed; // ゴミ箱状態
  final String? transcriptionText; // 文字起こし結果（任意）
  final TranscriptionStatus transcriptionStatus; // 文字起こし状態

  const VoiceMemo({
    required this.id,
    required this.title,
    required this.tags,
    required this.isStarred,
    required this.note,
    required this.durationMs,
    required this.audioPath,
    required this.createdAt,
    required this.updatedAt,
    required this.isTrashed,
    required this.transcriptionText,
    required this.transcriptionStatus,
  });

  // 部分更新用のコピー
  VoiceMemo copyWith({
    String? id,
    String? title,
    List<Tag>? tags,
    bool? isStarred,
    String? note,
    int? durationMs,
    String? audioPath,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isTrashed,
    String? transcriptionText,
    TranscriptionStatus? transcriptionStatus,
  }) {
    return VoiceMemo(
      id: id ?? this.id,
      title: title ?? this.title,
      tags: tags ?? List<Tag>.unmodifiable(this.tags),
      isStarred: isStarred ?? this.isStarred,
      note: note ?? this.note,
      durationMs: durationMs ?? this.durationMs,
      audioPath: audioPath ?? this.audioPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isTrashed: isTrashed ?? this.isTrashed,
      transcriptionText: transcriptionText ?? this.transcriptionText,
      transcriptionStatus: transcriptionStatus ?? this.transcriptionStatus,
    );
  }

  @override
  String toString() => 'VoiceMemo(id: $id, title: $title, tags: $tags, isStarred: $isStarred, durationMs: $durationMs, audioPath: $audioPath, createdAt: ${createdAt.toIso8601String()}, updatedAt: ${updatedAt.toIso8601String()}, isTrashed: $isTrashed, transcriptionStatus: $transcriptionStatus)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VoiceMemo &&
        other.id == id &&
        other.title == title &&
        _listEquals(other.tags, tags) &&
        other.isStarred == isStarred &&
        other.note == note &&
        other.durationMs == durationMs &&
        other.audioPath == audioPath &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.isTrashed == isTrashed &&
        other.transcriptionText == transcriptionText &&
        other.transcriptionStatus == transcriptionStatus;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ _listHash(tags) ^ isStarred.hashCode ^ (note?.hashCode ?? 0) ^ durationMs.hashCode ^ audioPath.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode ^ isTrashed.hashCode ^ (transcriptionText?.hashCode ?? 0) ^ transcriptionStatus.hashCode;
}

// リストの浅い等価比較（順序考慮）
bool _listEquals<T>(List<T> a, List<T> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

int _listHash<T>(List<T> list) {
  int hash = 0;
  for (final e in list) {
    hash = 0x1fffffff & (hash + e.hashCode);
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    hash ^= (hash >> 6);
  }
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash ^= (hash >> 11);
  hash = 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  return hash;
}