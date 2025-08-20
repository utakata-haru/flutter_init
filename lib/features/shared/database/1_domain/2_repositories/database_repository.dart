// データベース操作の抽象リポジトリ
// Domain層のため、具象実装やパッケージ型（Databaseなど）には依存しません。

import '../1_entities/database_migration_entity.dart';

/// データベース初期化とマイグレーションのためのリポジトリインターフェース
abstract class DatabaseRepository {
  /// データベース接続（またはハンドル）の初期化処理
  Future<void> initialize();

  /// 現在のデータベースバージョンを取得
  Future<int> getCurrentVersion();

  /// データベースバージョンを更新
  Future<void> setCurrentVersion(int version);

  /// 指定されたマイグレーション群を順に実行
  Future<void> runMigrations(MigrationPlan migrations);

  /// 任意SQLの実行（副作用系）
  Future<int> rawExecute(String sql, [List<Object?> params = const []]);

  /// 任意SQLの問い合わせ（読み取り系）
  Future<List<Map<String, Object?>>> rawQuery(String sql, [List<Object?> params = const []]);
}