// データベースのマイグレーションを表すエンティティ
// クリーンアーキテクチャのDomain層に属し、インフラ実装（sqflite等）には依存しません。

/// 単一バージョンへ適用するマイグレーション
class DatabaseMigration {
  /// マイグレーション適用後のDBバージョン（例: 1, 2, 3 ...）
  final int version;

  /// バージョンを上げるために実行するSQL文の一覧（DDL/DML）
  final List<String> upSql;

  const DatabaseMigration({
    required this.version,
    required this.upSql,
  });
}

/// マイグレーションの計画（バージョン順に並んだリスト）
typedef MigrationPlan = List<DatabaseMigration>;