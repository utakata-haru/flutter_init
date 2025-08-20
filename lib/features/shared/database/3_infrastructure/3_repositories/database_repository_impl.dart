// DatabaseRepository の sqflite 実装

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../1_data_sources/1_local/database_local_data_source.dart';
import '../../1_domain/1_entities/database_migration_entity.dart';
import '../../1_domain/2_repositories/database_repository.dart';
import '../2_models/database_schema.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final DatabaseLocalDataSource _ds;

  DatabaseRepositoryImpl(this._ds);

  @override
  Future<void> initialize() async {
    // DBファイルのオープン。初期作成時にスキーマを作成
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'namilog.db');

    await _ds.open(path, version: 1, onCreate: (db, version) async {
      // v1のスキーマ作成
      await db.execute(DatabaseSchemaV1.createMetaTable);
      await db.execute(DatabaseSchemaV1.createSessionsTable);
      for (final sql in DatabaseSchemaV1.initialInserts) {
        await db.execute(sql);
      }
    });
  }

  @override
  Future<int> getCurrentVersion() async {
    // app_metaテーブルからバージョンを取得（なければ0）
    try {
      final rows = await rawQuery("SELECT value FROM app_meta WHERE key='db_version' LIMIT 1");
      if (rows.isEmpty) return 0;
      return int.tryParse(rows.first['value']?.toString() ?? '') ?? 0;
    } catch (_) {
      // テーブル未作成などの場合は0とみなす
      return 0;
    }
  }

  @override
  Future<void> setCurrentVersion(int version) async {
    await rawExecute(
      "INSERT OR REPLACE INTO app_meta(key, value) VALUES('db_version', ?)",
      [version.toString()],
    );
  }

  @override
  Future<void> runMigrations(MigrationPlan migrations) async {
    for (final m in migrations) {
      for (final sql in m.upSql) {
        await rawExecute(sql);
      }
    }
  }

  @override
  Future<int> rawExecute(String sql, [List<Object?> params = const []]) async {
    final db = _ds.db;
    if (db == null) throw StateError('Database is not opened');
    await db.execute(sql, params);
    return 0; // executeは戻り値を返さないため0を返す
  }

  @override
  Future<List<Map<String, Object?>>> rawQuery(String sql, [List<Object?> params = const []]) async {
    final db = _ds.db;
    if (db == null) throw StateError('Database is not opened');
    return db.rawQuery(sql, params);
  }
}