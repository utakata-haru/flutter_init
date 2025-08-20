// アプリのSQLiteスキーマ定義（シンプル版）
// 実プロダクトではテーブルを増やしていきます。

class DatabaseSchemaV1 {
  static const createMetaTable = '''
    CREATE TABLE IF NOT EXISTS app_meta (
      key TEXT PRIMARY KEY,
      value TEXT
    );
  ''';

  static const createSessionsTable = '''
    CREATE TABLE IF NOT EXISTS sessions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT NOT NULL,
      spot TEXT,
      waveSize TEXT,
      notes TEXT
    );
  ''';

  static const initialInserts = <String>[
    "INSERT OR REPLACE INTO app_meta(key, value) VALUES('db_version', '1');",
  ];
}