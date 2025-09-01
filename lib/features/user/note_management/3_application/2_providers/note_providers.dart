import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// ドメイン層
import '../../1_domain/2_repositories/note_repository.dart';
import '../../1_domain/3_usecases/create_note_usecase.dart';
import '../../1_domain/3_usecases/get_notes_usecase.dart';
import '../../1_domain/3_usecases/get_note_by_id_usecase.dart';
import '../../1_domain/3_usecases/update_note_usecase.dart';
import '../../1_domain/3_usecases/delete_note_usecase.dart';
import '../../1_domain/3_usecases/search_notes_usecase.dart';

// インフラ層
import '../../2_infrastructure/3_repositories/note_repository_impl.dart';
import '../../2_infrastructure/2_data_sources/1_local/note_local_data_source.dart';

part 'note_providers.g.dart';

/// SQLiteデータベースの依存性注入
@Riverpod(keepAlive: true)
Future<Database> database(Ref ref) async {
  // データベースパスを取得
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, 'notes.db');

  // データベースを開く
  return await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      // テーブル作成
      await NoteLocalDataSourceImpl.createTable(db, version);
    },
    onUpgrade: (Database db, int oldVersion, int newVersion) async {
      // 将来のマイグレーション処理をここに記述
      if (oldVersion < 2) {
        // バージョン2へのマイグレーション例
        // await db.execute('ALTER TABLE notes ADD COLUMN new_column TEXT');
      }
    },
  );
}

/// NoteLocalDataSourceの依存性注入
@riverpod
NoteLocalDataSource noteLocalDataSource(Ref ref) {
  final database = ref.watch(databaseProvider);
  return database.when(
    data: (db) => NoteLocalDataSourceImpl(db),
    loading: () => throw StateError('Database is still loading'),
    error: (error, stackTrace) => throw StateError('Database error: $error'),
  );
}

/// NoteRepositoryの依存性注入
@riverpod
NoteRepository noteRepository(Ref ref) {
  final localDataSource = ref.watch(noteLocalDataSourceProvider);
  return NoteRepositoryImpl(localDataSource);
}

// === Use Cases ===

/// CreateNoteUseCaseの依存性注入
@riverpod
CreateNoteUseCase createNoteUseCase(Ref ref) {
  final repository = ref.watch(noteRepositoryProvider);
  return CreateNoteUseCase(repository);
}

/// GetNotesUseCaseの依存性注入
@riverpod
GetNotesUseCase getNotesUseCase(Ref ref) {
  final repository = ref.watch(noteRepositoryProvider);
  return GetNotesUseCase(repository);
}

/// GetNoteByIdUseCaseの依存性注入
@riverpod
GetNoteByIdUseCase getNoteByIdUseCase(Ref ref) {
  final repository = ref.watch(noteRepositoryProvider);
  return GetNoteByIdUseCase(repository);
}

/// UpdateNoteUseCaseの依存性注入
@riverpod
UpdateNoteUseCase updateNoteUseCase(Ref ref) {
  final repository = ref.watch(noteRepositoryProvider);
  return UpdateNoteUseCase(repository);
}

/// DeleteNoteUseCaseの依存性注入
@riverpod
DeleteNoteUseCase deleteNoteUseCase(Ref ref) {
  final repository = ref.watch(noteRepositoryProvider);
  return DeleteNoteUseCase(repository);
}

/// SearchNotesUseCaseの依存性注入
@riverpod
SearchNotesUseCase searchNotesUseCase(Ref ref) {
  final repository = ref.watch(noteRepositoryProvider);
  return SearchNotesUseCase(repository);
}

// === Configuration Providers ===

/// アプリケーション設定プロバイダー
@Riverpod(keepAlive: true)
NoteAppConfig noteAppConfig(Ref ref) {
  return const NoteAppConfig(
    maxNotesPerPage: 20,
    maxTitleLength: 50,
    maxContentLength: 1000,
    searchDebounceMs: 300,
    autoSaveIntervalMs: 5000,
  );
}

/// データベース設定プロバイダー
@Riverpod(keepAlive: true)
DatabaseConfig databaseConfig(Ref ref) {
  return const DatabaseConfig(
    databaseName: 'notes.db',
    version: 1,
    enableWAL: true,
    pageSize: 4096,
    cacheSize: 2000,
  );
}

// === Helper Providers ===

/// データベースの健全性チェックプロバイダー
@riverpod
Future<bool> databaseHealthCheck(Ref ref) async {
  final repository = ref.watch(noteRepositoryProvider);
  if (repository is NoteRepositoryImpl) {
    return await repository.checkDatabaseHealth();
  }
  return true;
}

/// ストレージ統計情報プロバイダー
@riverpod
Future<Map<String, dynamic>> storageStats(Ref ref) async {
  final repository = ref.watch(noteRepositoryProvider);
  if (repository is NoteRepositoryImpl) {
    return await repository.getStorageStats();
  }
  return {'totalNotes': 0, 'databaseSize': 0};
}

/// データベース最適化プロバイダー（手動実行用）
@riverpod
Future<void> optimizeDatabase(Ref ref) async {
  final repository = ref.watch(noteRepositoryProvider);
  if (repository is NoteRepositoryImpl) {
    await repository.optimizeDatabase();
  }
}

// === Configuration Classes ===

/// メモアプリケーション設定クラス
class NoteAppConfig {
  const NoteAppConfig({
    required this.maxNotesPerPage,
    required this.maxTitleLength,
    required this.maxContentLength,
    required this.searchDebounceMs,
    required this.autoSaveIntervalMs,
  });

  final int maxNotesPerPage;
  final int maxTitleLength;
  final int maxContentLength;
  final int searchDebounceMs;
  final int autoSaveIntervalMs;
}

/// データベース設定クラス
class DatabaseConfig {
  const DatabaseConfig({
    required this.databaseName,
    required this.version,
    required this.enableWAL,
    required this.pageSize,
    required this.cacheSize,
  });

  final String databaseName;
  final int version;
  final bool enableWAL;
  final int pageSize;
  final int cacheSize;
}

// === Test Support Providers ===

/// テスト用のインメモリデータベースプロバイダー
@riverpod
Future<Database> testDatabase(Ref ref) async {
  return await openDatabase(
    ':memory:',
    version: 1,
    onCreate: (Database db, int version) async {
      await NoteLocalDataSourceImpl.createTable(db, version);
    },
  );
}

/// テスト用のNoteRepositoryプロバイダー
@riverpod
NoteRepository testNoteRepository(Ref ref) {
  final database = ref.watch(testDatabaseProvider);
  return database.when(
    data: (db) => NoteRepositoryImpl(NoteLocalDataSourceImpl(db)),
    loading: () => throw StateError('Test database is still loading'),
    error: (error, stackTrace) => throw StateError('Test database error: $error'),
  );
}

// === Error Handling Providers ===

/// グローバルエラーハンドラープロバイダー
@Riverpod(keepAlive: true)
void errorHandler(Ref ref) {
  // グローバルなエラーハンドリングの設定
  // 実際のアプリケーションでは、Crashlyticsやログ送信などを行う
}

/// ネットワーク状態プロバイダー（将来の拡張用）
@Riverpod(keepAlive: true)
bool isOnline(Ref ref) {
  // 将来的にネットワーク状態を監視する場合に使用
  return true;
}
