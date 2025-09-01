// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseHash() => r'81048dc31465e2805503a2d455e6c0385e0d5d85';

/// SQLiteデータベースの依存性注入
///
/// Copied from [database].
@ProviderFor(database)
final databaseProvider = FutureProvider<Database>.internal(
  database,
  name: r'databaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$databaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DatabaseRef = FutureProviderRef<Database>;
String _$noteLocalDataSourceHash() =>
    r'a9c4c91550f3095a9cddf18ffdaba7ba2706c4fc';

/// NoteLocalDataSourceの依存性注入
///
/// Copied from [noteLocalDataSource].
@ProviderFor(noteLocalDataSource)
final noteLocalDataSourceProvider =
    AutoDisposeFutureProvider<NoteLocalDataSource>.internal(
      noteLocalDataSource,
      name: r'noteLocalDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$noteLocalDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NoteLocalDataSourceRef =
    AutoDisposeFutureProviderRef<NoteLocalDataSource>;
String _$noteRepositoryHash() => r'560d01d7039456e9d9bed60b4e6a94d340191815';

/// NoteRepositoryの依存性注入
///
/// Copied from [noteRepository].
@ProviderFor(noteRepository)
final noteRepositoryProvider =
    AutoDisposeFutureProvider<NoteRepository>.internal(
      noteRepository,
      name: r'noteRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$noteRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NoteRepositoryRef = AutoDisposeFutureProviderRef<NoteRepository>;
String _$createNoteUseCaseHash() => r'0456c35fa86455ffd8836dbc377fc1873f2564b5';

/// CreateNoteUseCaseの依存性注入
///
/// Copied from [createNoteUseCase].
@ProviderFor(createNoteUseCase)
final createNoteUseCaseProvider =
    AutoDisposeFutureProvider<CreateNoteUseCase>.internal(
      createNoteUseCase,
      name: r'createNoteUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$createNoteUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CreateNoteUseCaseRef = AutoDisposeFutureProviderRef<CreateNoteUseCase>;
String _$getNotesUseCaseHash() => r'a6ff09e99a7f8d3c3d7a44c0befdcf2ab668e1ba';

/// GetNotesUseCaseの依存性注入
///
/// Copied from [getNotesUseCase].
@ProviderFor(getNotesUseCase)
final getNotesUseCaseProvider =
    AutoDisposeFutureProvider<GetNotesUseCase>.internal(
      getNotesUseCase,
      name: r'getNotesUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getNotesUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetNotesUseCaseRef = AutoDisposeFutureProviderRef<GetNotesUseCase>;
String _$getNoteByIdUseCaseHash() =>
    r'f8caf2aa4dd979e3e0d9dc6a919666a77e914078';

/// GetNoteByIdUseCaseの依存性注入
///
/// Copied from [getNoteByIdUseCase].
@ProviderFor(getNoteByIdUseCase)
final getNoteByIdUseCaseProvider =
    AutoDisposeFutureProvider<GetNoteByIdUseCase>.internal(
      getNoteByIdUseCase,
      name: r'getNoteByIdUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getNoteByIdUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetNoteByIdUseCaseRef =
    AutoDisposeFutureProviderRef<GetNoteByIdUseCase>;
String _$updateNoteUseCaseHash() => r'b2c067df9232ad78da836f8d9864d4e8fb045296';

/// UpdateNoteUseCaseの依存性注入
///
/// Copied from [updateNoteUseCase].
@ProviderFor(updateNoteUseCase)
final updateNoteUseCaseProvider =
    AutoDisposeFutureProvider<UpdateNoteUseCase>.internal(
      updateNoteUseCase,
      name: r'updateNoteUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$updateNoteUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpdateNoteUseCaseRef = AutoDisposeFutureProviderRef<UpdateNoteUseCase>;
String _$deleteNoteUseCaseHash() => r'199f3c3fdc244ae7a13e35647cd97a135cebacff';

/// DeleteNoteUseCaseの依存性注入
///
/// Copied from [deleteNoteUseCase].
@ProviderFor(deleteNoteUseCase)
final deleteNoteUseCaseProvider =
    AutoDisposeFutureProvider<DeleteNoteUseCase>.internal(
      deleteNoteUseCase,
      name: r'deleteNoteUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$deleteNoteUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeleteNoteUseCaseRef = AutoDisposeFutureProviderRef<DeleteNoteUseCase>;
String _$searchNotesUseCaseHash() =>
    r'74b7402a36b5b578bbd97e7270f829efc027f6b3';

/// SearchNotesUseCaseの依存性注入
///
/// Copied from [searchNotesUseCase].
@ProviderFor(searchNotesUseCase)
final searchNotesUseCaseProvider =
    AutoDisposeFutureProvider<SearchNotesUseCase>.internal(
      searchNotesUseCase,
      name: r'searchNotesUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$searchNotesUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SearchNotesUseCaseRef =
    AutoDisposeFutureProviderRef<SearchNotesUseCase>;
String _$noteAppConfigHash() => r'd870b8666f30b8fa55a937a584a1b4ade4935b56';

/// アプリケーション設定プロバイダー
///
/// Copied from [noteAppConfig].
@ProviderFor(noteAppConfig)
final noteAppConfigProvider = Provider<NoteAppConfig>.internal(
  noteAppConfig,
  name: r'noteAppConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$noteAppConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NoteAppConfigRef = ProviderRef<NoteAppConfig>;
String _$databaseConfigHash() => r'4ed276a97feffde260d72ff6d46e9928b06c8756';

/// データベース設定プロバイダー
///
/// Copied from [databaseConfig].
@ProviderFor(databaseConfig)
final databaseConfigProvider = Provider<DatabaseConfig>.internal(
  databaseConfig,
  name: r'databaseConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$databaseConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DatabaseConfigRef = ProviderRef<DatabaseConfig>;
String _$databaseHealthCheckHash() =>
    r'72d92d9d1ca488fdf47fc921ad0555397b85cf1f';

/// データベースの健全性チェックプロバイダー
///
/// Copied from [databaseHealthCheck].
@ProviderFor(databaseHealthCheck)
final databaseHealthCheckProvider = AutoDisposeFutureProvider<bool>.internal(
  databaseHealthCheck,
  name: r'databaseHealthCheckProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$databaseHealthCheckHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DatabaseHealthCheckRef = AutoDisposeFutureProviderRef<bool>;
String _$storageStatsHash() => r'5e3aac082901ff8b5cc53ad7a3ae97f9571d368b';

/// ストレージ統計情報プロバイダー
///
/// Copied from [storageStats].
@ProviderFor(storageStats)
final storageStatsProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
      storageStats,
      name: r'storageStatsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$storageStatsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StorageStatsRef = AutoDisposeFutureProviderRef<Map<String, dynamic>>;
String _$optimizeDatabaseHash() => r'b19c710c981a593e401d3bf27681613b53277e90';

/// データベース最適化プロバイダー（手動実行用）
///
/// Copied from [optimizeDatabase].
@ProviderFor(optimizeDatabase)
final optimizeDatabaseProvider = AutoDisposeFutureProvider<void>.internal(
  optimizeDatabase,
  name: r'optimizeDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$optimizeDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OptimizeDatabaseRef = AutoDisposeFutureProviderRef<void>;
String _$testDatabaseHash() => r'89f1c3c340ec9127222c760947e75ef1e50f6f7f';

/// テスト用のインメモリデータベースプロバイダー
///
/// Copied from [testDatabase].
@ProviderFor(testDatabase)
final testDatabaseProvider = AutoDisposeFutureProvider<Database>.internal(
  testDatabase,
  name: r'testDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestDatabaseRef = AutoDisposeFutureProviderRef<Database>;
String _$testNoteRepositoryHash() =>
    r'e1f3eab00504eeaf3bec573d870cbe15dbc5c4fa';

/// テスト用のNoteRepositoryプロバイダー
///
/// Copied from [testNoteRepository].
@ProviderFor(testNoteRepository)
final testNoteRepositoryProvider = AutoDisposeProvider<NoteRepository>.internal(
  testNoteRepository,
  name: r'testNoteRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testNoteRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestNoteRepositoryRef = AutoDisposeProviderRef<NoteRepository>;
String _$errorHandlerHash() => r'c2fe4c4be4951011b10659aa11e0062b6d355fcb';

/// グローバルエラーハンドラープロバイダー
///
/// Copied from [errorHandler].
@ProviderFor(errorHandler)
final errorHandlerProvider = Provider<void>.internal(
  errorHandler,
  name: r'errorHandlerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$errorHandlerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ErrorHandlerRef = ProviderRef<void>;
String _$isOnlineHash() => r'05f6b03eddcb8a1e6d3eb0fe6e1279e2e818304f';

/// ネットワーク状態プロバイダー（将来の拡張用）
///
/// Copied from [isOnline].
@ProviderFor(isOnline)
final isOnlineProvider = Provider<bool>.internal(
  isOnline,
  name: r'isOnlineProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isOnlineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsOnlineRef = ProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
