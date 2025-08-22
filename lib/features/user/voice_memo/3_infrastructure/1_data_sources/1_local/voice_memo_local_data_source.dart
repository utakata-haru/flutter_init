// インフラ層: ローカルデータソース（sqflite）
// 役割: 端末内DBに VoiceMemo/Tag を保存・取得する
// 注意: MVP段階では簡易検索と単純な正規化構造（voice_memos / tags / voice_memo_tags）を採用

import 'dart:async';
import 'dart:math';

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../../../1_domain/1_entities/tag_entity.dart';
import '../../../1_domain/1_entities/transcription_status_entity.dart';
import '../../../1_domain/1_entities/voice_memo_entity.dart';

class VoiceMemoLocalDataSource {
  Database? _db;

  // DB初期化（必要時に自動オープン）
  Future<Database> _openDb() async {
    if (_db != null) return _db!;
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'voice_memos.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // voice_memos テーブル
        await db.execute('''
          CREATE TABLE voice_memos (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            is_starred INTEGER NOT NULL,
            note TEXT,
            duration_ms INTEGER NOT NULL,
            audio_path TEXT NOT NULL,
            created_at TEXT NOT NULL,
            updated_at TEXT NOT NULL,
            is_trashed INTEGER NOT NULL,
            transcription_text TEXT,
            transcription_status TEXT NOT NULL
          );
        ''');
        // tags テーブル
        await db.execute('''
          CREATE TABLE tags (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL UNIQUE
          );
        ''');
        // 中間テーブル（多対多）
        await db.execute('''
          CREATE TABLE voice_memo_tags (
            memo_id TEXT NOT NULL,
            tag_id TEXT NOT NULL,
            PRIMARY KEY (memo_id, tag_id)
          );
        ''');
      },
    );
    return _db!;
  }

  // ユーティリティ: ID生成（UUID代替の簡易一意ID）
  String _generateId() {
    final rand = Random();
    final ts = DateTime.now().microsecondsSinceEpoch;
    return 'm_${ts}_${rand.nextInt(1 << 32)}';
  }

  String _statusToDb(TranscriptionStatus s) => s.name; // TEXT で保存
  TranscriptionStatus _statusFromDb(String s) => TranscriptionStatus.values.firstWhere(
        (e) => e.name == s,
        orElse: () => TranscriptionStatus.none,
      );

  // Map -> Entity 変換（タグは別取得）
  VoiceMemo _mapRowToEntity(Map<String, Object?> row, List<Tag> tags) {
    return VoiceMemo(
      id: row['id'] as String,
      title: row['title'] as String,
      tags: List<Tag>.unmodifiable(tags),
      isStarred: (row['is_starred'] as int) == 1,
      note: row['note'] as String?,
      durationMs: row['duration_ms'] as int,
      audioPath: row['audio_path'] as String,
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: DateTime.parse(row['updated_at'] as String),
      isTrashed: (row['is_trashed'] as int) == 1,
      transcriptionText: row['transcription_text'] as String?,
      transcriptionStatus: _statusFromDb(row['transcription_status'] as String),
    );
  }

  Future<List<Tag>> _getTagsByMemoId(Database db, String memoId) async {
    // JOINを含むクエリは Database.query ではなく rawQuery を使用する
    final rows = await db.rawQuery(
      'SELECT t.id, t.name FROM voice_memo_tags vmt JOIN tags t ON vmt.tag_id = t.id WHERE vmt.memo_id = ?',
      [memoId],
    );
    return rows
        .map((r) => Tag(id: r['id'] as String, name: r['name'] as String))
        .toList(growable: false);
  }

  Future<void> _upsertTags(Database db, List<Tag> tags) async {
    for (final tag in tags) {
      await db.insert(
        'tags',
        {'id': tag.id, 'name': tag.name},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  Future<void> _replaceMemoTags(Database db, String memoId, List<Tag> tags) async {
    await db.delete('voice_memo_tags', where: 'memo_id = ?', whereArgs: [memoId]);
    for (final tag in tags) {
      await db.insert(
        'voice_memo_tags',
        {'memo_id': memoId, 'tag_id': tag.id},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  // 作成
  Future<VoiceMemo> create({
    required String title,
    required List<Tag> tags,
    bool isStarred = false,
    String? note,
    required int durationMs,
    required String audioPath,
    required DateTime createdAt,
  }) async {
    final db = await _openDb();
    final id = _generateId();
    final nowIso = createdAt.toIso8601String();
    await db.insert('voice_memos', {
      'id': id,
      'title': title,
      'is_starred': isStarred ? 1 : 0,
      'note': note,
      'duration_ms': durationMs,
      'audio_path': audioPath,
      'created_at': nowIso,
      'updated_at': nowIso,
      'is_trashed': 0,
      'transcription_text': null,
      'transcription_status': _statusToDb(TranscriptionStatus.none),
    });
    await _upsertTags(db, tags);
    await _replaceMemoTags(db, id, tags);

    return _mapRowToEntity(
      {
        'id': id,
        'title': title,
        'is_starred': isStarred ? 1 : 0,
        'note': note,
        'duration_ms': durationMs,
        'audio_path': audioPath,
        'created_at': nowIso,
        'updated_at': nowIso,
        'is_trashed': 0,
        'transcription_text': null,
        'transcription_status': _statusToDb(TranscriptionStatus.none),
      },
      tags,
    );
  }

  // メタ情報更新（部分更新）
  Future<VoiceMemo> updateMeta({
    required String id,
    String? title,
    List<Tag>? tags,
    bool? isStarred,
    String? note,
  }) async {
    final db = await _openDb();
    final current = await getById(id);
    if (current == null) {
      throw StateError('VoiceMemo not found: $id');
    }

    final newTitle = title ?? current.title;
    final newStar = isStarred ?? current.isStarred;
    final newNote = note ?? current.note;
    final nowIso = DateTime.now().toIso8601String();

    await db.update(
      'voice_memos',
      {
        'title': newTitle,
        'is_starred': newStar ? 1 : 0,
        'note': newNote,
        'updated_at': nowIso,
      },
      where: 'id = ?',
      whereArgs: [id],
    );

    final newTags = tags ?? current.tags;
    await _upsertTags(db, newTags);
    await _replaceMemoTags(db, id, newTags);

    return (await getById(id))!;
  }

  Future<void> moveToTrash(String id) async {
    final db = await _openDb();
    await db.update(
      'voice_memos',
      {
        'is_trashed': 1,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> restoreFromTrash(String id) async {
    final db = await _openDb();
    await db.update(
      'voice_memos',
      {
        'is_trashed': 0,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> hardDelete(String id) async {
    final db = await _openDb();
    await db.delete('voice_memo_tags', where: 'memo_id = ?', whereArgs: [id]);
    await db.delete('voice_memos', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<VoiceMemo>> list({bool includeTrashed = false}) async {
    final db = await _openDb();
    final rows = await db.query(
      'voice_memos',
      where: includeTrashed ? null : 'is_trashed = 0',
      orderBy: 'updated_at DESC',
    );
    final result = <VoiceMemo>[];
    for (final row in rows) {
      final tags = await _getTagsByMemoId(db, row['id'] as String);
      result.add(_mapRowToEntity(row, tags));
    }
    return result;
  }

  Future<VoiceMemo?> getById(String id) async {
    final db = await _openDb();
    final rows = await db.query('voice_memos', where: 'id = ?', whereArgs: [id], limit: 1);
    if (rows.isEmpty) return null;
    final tags = await _getTagsByMemoId(db, id);
    return _mapRowToEntity(rows.first, tags);
  }

  Future<List<VoiceMemo>> search({
    String? query,
    List<Tag>? tags,
    DateTime? from,
    DateTime? to,
    bool? starredOnly,
  }) async {
    final db = await _openDb();

    final where = <String>[];
    final args = <Object?>[];

    if (query != null && query.isNotEmpty) {
      where.add('(title LIKE ? OR note LIKE ? OR transcription_text LIKE ?)');
      final pattern = '%${query.replaceAll('%', '\\%')}%';
      args.addAll([pattern, pattern, pattern]);
    }
    if (from != null) {
      where.add('created_at >= ?');
      args.add(from.toIso8601String());
    }
    if (to != null) {
      where.add('created_at <= ?');
      args.add(to.toIso8601String());
    }
    if (starredOnly == true) {
      where.add('is_starred = 1');
    }

    final rows = await db.query(
      'voice_memos',
      where: where.isEmpty ? null : where.join(' AND '),
      whereArgs: args,
      orderBy: 'updated_at DESC',
    );

    // タグによる絞り込みはメモ取得後にフィルタ（MVP簡易実装）
    final candidates = <VoiceMemo>[];
    for (final row in rows) {
      final memoTags = await _getTagsByMemoId(db, row['id'] as String);
      final memo = _mapRowToEntity(row, memoTags);
      candidates.add(memo);
    }

    if (tags == null || tags.isEmpty) return candidates;

    final tagIds = tags.map((t) => t.id).toSet();
    return candidates.where((m) {
      final memoTagIds = m.tags.map((t) => t.id).toSet();
      return tagIds.every(memoTagIds.contains);
    }).toList(growable: false);
  }

  Future<VoiceMemo> requestTranscription({required String id}) async {
    final db = await _openDb();
    await db.update(
      'voice_memos',
      {
        'transcription_status': _statusToDb(TranscriptionStatus.pending),
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    final updated = await getById(id);
    if (updated == null) {
      throw StateError('VoiceMemo not found: $id');
    }
    return updated;
  }
}