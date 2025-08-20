// sqflite を用いたローカルデータソース
// インフラ層のため、具体的なパッケージに依存してOKです。

import 'package:sqflite/sqflite.dart';

/// データベース接続と基本操作を提供
class DatabaseLocalDataSource {
  Database? _db;

  Database? get db => _db;

  Future<void> open(String path, {int version = 1, OnDatabaseCreateFn? onCreate}) async {
    _db = await openDatabase(
      path,
      version: version,
      onCreate: onCreate,
    );
  }

  Future<int> execute(String sql, [List<Object?> params = const []]) async {
    final database = _db;
    if (database == null) throw StateError('Database is not opened');
    return database.rawInsert(sql, params);
  }

  Future<List<Map<String, Object?>>> query(String sql, [List<Object?> params = const []]) async {
    final database = _db;
    if (database == null) throw StateError('Database is not opened');
    return database.rawQuery(sql, params);
  }
}