// DB初期化ユースケース
// Repositoryの抽象にのみ依存し、インフラ詳細は持ち込みません。

import 'dart:async';

import '../1_entities/database_migration_entity.dart';
import '../2_repositories/database_repository.dart';

/// アプリ起動時などにDBを初期化し、未適用のマイグレーションを順に適用します。
class InitializeDatabaseUsecase {
  final DatabaseRepository _repository;
  final MigrationPlan _plan;

  InitializeDatabaseUsecase({
    required DatabaseRepository repository,
    required MigrationPlan plan,
  })  : _repository = repository,
        _plan = plan;

  /// 実行
  Future<void> call() async {
    // まず接続や作成処理などを初期化
    await _repository.initialize();

    // 現在バージョンを取得
    final current = await _repository.getCurrentVersion();

    // 未適用マイグレーションのみ抽出し、version昇順で実行
    final pending = _plan
        .where((m) => m.version > current)
        .toList()
      ..sort((a, b) => a.version.compareTo(b.version));

    if (pending.isNotEmpty) {
      await _repository.runMigrations(pending);
      // 最後に到達したバージョンを記録
      await _repository.setCurrentVersion(pending.last.version);
    }
  }
}