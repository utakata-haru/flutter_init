import 'package:sqflite/sqflite.dart';
import '../../1_models/note_model.dart';

/// メモローカルデータソース抽象クラス
/// 
/// SQLiteデータベースへのCRUD操作を定義します。
abstract class NoteLocalDataSource {
  /// 指定されたIDのメモを取得
  Future<NoteModel?> getNoteById(String id);

  /// 全メモを取得
  Future<List<NoteModel>> getAllNotes({int? limit, int? offset});

  /// メモを検索
  Future<List<NoteModel>> searchNotes(String query, {int? limit, int? offset});

  /// メモを保存
  Future<void> saveNote(NoteModel note);

  /// 複数のメモを一括保存
  Future<void> saveNotes(List<NoteModel> notes);

  /// メモを更新
  Future<void> updateNote(NoteModel note);

  /// メモを削除
  Future<void> deleteNote(String id);

  /// 全メモを削除
  Future<void> deleteAllNotes();

  /// メモの存在確認
  Future<bool> noteExists(String id);

  /// メモ数を取得
  Future<int> getNotesCount();

  /// 最近更新されたメモを取得
  Future<List<NoteModel>> getRecentlyUpdatedNotes({int limit = 10});

  /// 最近作成されたメモを取得
  Future<List<NoteModel>> getRecentlyCreatedNotes({int daysAgo = 7});
}

/// メモローカルデータソース実装クラス
/// 
/// SQLiteを使用してメモデータの永続化を実現します。
class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final Database _database;

  // テーブル名と列名の定義
  static const String _tableName = 'notes';
  static const String _columnId = 'id';
  static const String _columnTitle = 'title';
  static const String _columnContent = 'content';
  static const String _columnCreatedAt = 'created_at';
  static const String _columnUpdatedAt = 'updated_at';

  NoteLocalDataSourceImpl(this._database);

  /// データベーステーブルの作成
  static Future<void> createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        $_columnId TEXT PRIMARY KEY,
        $_columnTitle TEXT NOT NULL,
        $_columnContent TEXT NOT NULL,
        $_columnCreatedAt TEXT NOT NULL,
        $_columnUpdatedAt TEXT NOT NULL
      )
    ''');

    // 検索性能向上のためのインデックス作成
    await db.execute('''
      CREATE INDEX idx_notes_title ON $_tableName($_columnTitle)
    ''');

    await db.execute('''
      CREATE INDEX idx_notes_created_at ON $_tableName($_columnCreatedAt)
    ''');

    await db.execute('''
      CREATE INDEX idx_notes_updated_at ON $_tableName($_columnUpdatedAt)
    ''');
  }

  @override
  Future<NoteModel?> getNoteById(String id) async {
    try {
      final List<Map<String, dynamic>> maps = await _database.query(
        _tableName,
        where: '$_columnId = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (maps.isNotEmpty) {
        return NoteModel.fromSQLiteMap(maps.first);
      }
      return null;
    } catch (e) {
      throw LocalDataSourceException('メモの取得に失敗しました: $e');
    }
  }

  @override
  Future<List<NoteModel>> getAllNotes({int? limit, int? offset}) async {
    try {
      final List<Map<String, dynamic>> maps = await _database.query(
        _tableName,
        orderBy: '$_columnCreatedAt DESC',
        limit: limit,
        offset: offset,
      );

      return maps.map((map) => NoteModel.fromSQLiteMap(map)).toList();
    } catch (e) {
      throw LocalDataSourceException('メモ一覧の取得に失敗しました: $e');
    }
  }

  @override
  Future<List<NoteModel>> searchNotes(
    String query, {
    int? limit,
    int? offset,
  }) async {
    try {
      if (query.trim().isEmpty) {
        return getAllNotes(limit: limit, offset: offset);
      }

      final searchPattern = '%${query.trim()}%';
      final List<Map<String, dynamic>> maps = await _database.query(
        _tableName,
        where: '$_columnTitle LIKE ? OR $_columnContent LIKE ?',
        whereArgs: [searchPattern, searchPattern],
        orderBy: '$_columnUpdatedAt DESC',
        limit: limit,
        offset: offset,
      );

      return maps.map((map) => NoteModel.fromSQLiteMap(map)).toList();
    } catch (e) {
      throw LocalDataSourceException('メモ検索に失敗しました: $e');
    }
  }

  @override
  Future<void> saveNote(NoteModel note) async {
    try {
      await _database.insert(
        _tableName,
        note.toSQLiteMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw LocalDataSourceException('メモの保存に失敗しました: $e');
    }
  }

  @override
  Future<void> saveNotes(List<NoteModel> notes) async {
    final batch = _database.batch();
    try {
      for (final note in notes) {
        batch.insert(
          _tableName,
          note.toSQLiteMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    } catch (e) {
      throw LocalDataSourceException('メモの一括保存に失敗しました: $e');
    }
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    try {
      final count = await _database.update(
        _tableName,
        note.toSQLiteMap(),
        where: '$_columnId = ?',
        whereArgs: [note.id],
      );

      if (count == 0) {
        throw LocalDataSourceException('更新対象のメモが見つかりません: ${note.id}');
      }
    } catch (e) {
      throw LocalDataSourceException('メモの更新に失敗しました: $e');
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    try {
      final count = await _database.delete(
        _tableName,
        where: '$_columnId = ?',
        whereArgs: [id],
      );

      if (count == 0) {
        throw LocalDataSourceException('削除対象のメモが見つかりません: $id');
      }
    } catch (e) {
      throw LocalDataSourceException('メモの削除に失敗しました: $e');
    }
  }

  @override
  Future<void> deleteAllNotes() async {
    try {
      await _database.delete(_tableName);
    } catch (e) {
      throw LocalDataSourceException('全メモの削除に失敗しました: $e');
    }
  }

  @override
  Future<bool> noteExists(String id) async {
    try {
      final List<Map<String, dynamic>> maps = await _database.query(
        _tableName,
        columns: [_columnId],
        where: '$_columnId = ?',
        whereArgs: [id],
        limit: 1,
      );

      return maps.isNotEmpty;
    } catch (e) {
      throw LocalDataSourceException('メモの存在確認に失敗しました: $e');
    }
  }

  @override
  Future<int> getNotesCount() async {
    try {
      final result = await _database.rawQuery('SELECT COUNT(*) FROM $_tableName');
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      throw LocalDataSourceException('メモ数の取得に失敗しました: $e');
    }
  }

  @override
  Future<List<NoteModel>> getRecentlyUpdatedNotes({int limit = 10}) async {
    try {
      final List<Map<String, dynamic>> maps = await _database.query(
        _tableName,
        orderBy: '$_columnUpdatedAt DESC',
        limit: limit,
      );

      return maps.map((map) => NoteModel.fromSQLiteMap(map)).toList();
    } catch (e) {
      throw LocalDataSourceException('最近更新されたメモの取得に失敗しました: $e');
    }
  }

  @override
  Future<List<NoteModel>> getRecentlyCreatedNotes({int daysAgo = 7}) async {
    try {
      final cutoffDate = DateTime.now().subtract(Duration(days: daysAgo));
      final cutoffDateString = cutoffDate.toIso8601String();

      final List<Map<String, dynamic>> maps = await _database.query(
        _tableName,
        where: '$_columnCreatedAt >= ?',
        whereArgs: [cutoffDateString],
        orderBy: '$_columnCreatedAt DESC',
      );

      return maps.map((map) => NoteModel.fromSQLiteMap(map)).toList();
    } catch (e) {
      throw LocalDataSourceException('最近作成されたメモの取得に失敗しました: $e');
    }
  }

  /// データベースの健全性チェック
  Future<bool> checkDatabaseIntegrity() async {
    try {
      final result = await _database.rawQuery('PRAGMA integrity_check');
      return result.isNotEmpty && result.first.values.first == 'ok';
    } catch (e) {
      return false;
    }
  }

  /// データベースの最適化
  Future<void> optimizeDatabase() async {
    try {
      await _database.execute('VACUUM');
      await _database.execute('ANALYZE');
    } catch (e) {
      throw LocalDataSourceException('データベースの最適化に失敗しました: $e');
    }
  }

  /// テーブルの統計情報を取得
  Future<Map<String, dynamic>> getTableStats() async {
    try {
      final countResult = await _database.rawQuery('SELECT COUNT(*) as count FROM $_tableName');
      final sizeResult = await _database.rawQuery(
        "SELECT page_count * page_size as size FROM pragma_page_count(), pragma_page_size()",
      );

      return {
        'totalNotes': Sqflite.firstIntValue(countResult) ?? 0,
        'databaseSize': Sqflite.firstIntValue(sizeResult) ?? 0,
      };
    } catch (e) {
      throw LocalDataSourceException('統計情報の取得に失敗しました: $e');
    }
  }
}

/// ローカルデータソース例外
class LocalDataSourceException implements Exception {
  final String message;
  LocalDataSourceException(this.message);

  @override
  String toString() => 'LocalDataSourceException: $message';
}
