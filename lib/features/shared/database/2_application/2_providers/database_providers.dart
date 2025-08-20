// RiverpodのProvider定義（インターフェース公開のみ）
// 実装は Notifier 側に集約します。

import 'package:riverpod/riverpod.dart';

import '../../1_domain/2_repositories/database_repository.dart';
import '../../1_domain/3_usecases/initialize_database_usecase.dart';
import '../1_states/database_state.dart';
import '../../1_domain/1_entities/database_migration_entity.dart';
import '../3_notifiers/database_notifier.dart';

// DatabaseRepository の抽象を提供するプロバイダー（実装はインフラ層でoverride）
final databaseRepositoryProvider = Provider<DatabaseRepository>((ref) {
  throw UnimplementedError('DatabaseRepository must be overridden in infrastructure layer');
});

// MigrationPlan（アプリのDBスキーマ更新計画）を提供（インフラ層で定義・override）
final migrationPlanProvider = Provider<MigrationPlan>((ref) {
  throw UnimplementedError('MigrationPlan must be provided by infrastructure layer');
});

// InitializeDatabaseUsecase を提供
final initializeDatabaseUsecaseProvider = Provider<InitializeDatabaseUsecase>((ref) {
  final repo = ref.watch(databaseRepositoryProvider);
  final plan = ref.watch(migrationPlanProvider);
  return InitializeDatabaseUsecase(repository: repo, plan: plan);
});

// DB状態を提供するためのStateProvider（初期はInitial）
final databaseStateProvider = StateProvider<DatabaseState>((ref) => const DatabaseInitial());

// DatabaseNotifier を公開するプロバイダー
final databaseNotifierProvider =
    StateNotifierProvider<DatabaseNotifier, DatabaseState>((ref) => DatabaseNotifier(ref));