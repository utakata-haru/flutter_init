// インフラ層: 永続化/復元用のモデル（sqfliteのRowと相互変換）
// 役割: ここでは主に補助的に使用（LocalDataSource内で直接Mapを扱っているため最小化）

import '../../1_domain/1_entities/transcription_status_entity.dart';
import '../../1_domain/1_entities/voice_memo_entity.dart';
import '../../1_domain/1_entities/tag_entity.dart';

class VoiceMemoModel {
  final String id;
  final String title;
  final List<Tag> tags;
  final bool isStarred;
  final String? note;
  final int durationMs;
  final String audioPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isTrashed;
  final String? transcriptionText;
  final TranscriptionStatus transcriptionStatus;

  const VoiceMemoModel({
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

  VoiceMemo toEntity() => VoiceMemo(
        id: id,
        title: title,
        tags: tags,
        isStarred: isStarred,
        note: note,
        durationMs: durationMs,
        audioPath: audioPath,
        createdAt: createdAt,
        updatedAt: updatedAt,
        isTrashed: isTrashed,
        transcriptionText: transcriptionText,
        transcriptionStatus: transcriptionStatus,
      );
}