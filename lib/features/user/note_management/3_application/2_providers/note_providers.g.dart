// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseHash() => r'02b8405a459dbe70b8c3fb5066ce30566efa1a0c';

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
    r'02c09786a458aec9ecf44ad2d605cec848fe4154';

/// NoteLocalDataSourceの依存性注入
///
/// Copied from [noteLocalDataSource].
@ProviderFor(noteLocalDataSource)
final noteLocalDataSourceProvider =
    AutoDisposeProvider<NoteLocalDataSource>.internal(
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
typedef NoteLocalDataSourceRef = AutoDisposeProviderRef<NoteLocalDataSource>;
String _$noteRepositoryHash() => r'5e4428d6fe93989d8fe9d061e9180bfa2d69998d';

/// NoteRepositoryの依存性注入
///
/// Copied from [noteRepository].
@ProviderFor(noteRepository)
final noteRepositoryProvider = AutoDisposeProvider<NoteRepository>.internal(
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
typedef NoteRepositoryRef = AutoDisposeProviderRef<NoteRepository>;
String _$createNoteUseCaseHash() => r'47e7ac43b21b8740d4c19d113ff9eaf96a9397f1';

/// CreateNoteUseCaseの依存性注入
///
/// Copied from [createNoteUseCase].
@ProviderFor(createNoteUseCase)
final createNoteUseCaseProvider =
    AutoDisposeProvider<CreateNoteUseCase>.internal(
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
typedef CreateNoteUseCaseRef = AutoDisposeProviderRef<CreateNoteUseCase>;
String _$getNotesUseCaseHash() => r'401969ad6ff1c3f1b8216edfefd5a591e57fec23';

/// GetNotesUseCaseの依存性注入
///
/// Copied from [getNotesUseCase].
@ProviderFor(getNotesUseCase)
final getNotesUseCaseProvider = AutoDisposeProvider<GetNotesUseCase>.internal(
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
typedef GetNotesUseCaseRef = AutoDisposeProviderRef<GetNotesUseCase>;
String _$getNoteByIdUseCaseHash() =>
    r'0a9be8fbbe2c7a5b4520b183b6932a283c75e798';

/// GetNoteByIdUseCaseの依存性注入
///
/// Copied from [getNoteByIdUseCase].
@ProviderFor(getNoteByIdUseCase)
final getNoteByIdUseCaseProvider =
    AutoDisposeProvider<GetNoteByIdUseCase>.internal(
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
typedef GetNoteByIdUseCaseRef = AutoDisposeProviderRef<GetNoteByIdUseCase>;
String _$updateNoteUseCaseHash() => r'c51179e3d1b6b6f3931b1a1427b88c9bc8ef2194';

/// UpdateNoteUseCaseの依存性注入
///
/// Copied from [updateNoteUseCase].
@ProviderFor(updateNoteUseCase)
final updateNoteUseCaseProvider =
    AutoDisposeProvider<UpdateNoteUseCase>.internal(
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
typedef UpdateNoteUseCaseRef = AutoDisposeProviderRef<UpdateNoteUseCase>;
String _$deleteNoteUseCaseHash() => r'336c0f9143288a03d674f03760a6dc1411a7f1ac';

/// DeleteNoteUseCaseの依存性注入
///
/// Copied from [deleteNoteUseCase].
@ProviderFor(deleteNoteUseCase)
final deleteNoteUseCaseProvider =
    AutoDisposeProvider<DeleteNoteUseCase>.internal(
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
typedef DeleteNoteUseCaseRef = AutoDisposeProviderRef<DeleteNoteUseCase>;
String _$searchNotesUseCaseHash() =>
    r'181603b665da9f7b9abd4fa878148c852018717b';

/// SearchNotesUseCaseの依存性注入
///
/// Copied from [searchNotesUseCase].
@ProviderFor(searchNotesUseCase)
final searchNotesUseCaseProvider =
    AutoDisposeProvider<SearchNotesUseCase>.internal(
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
typedef SearchNotesUseCaseRef = AutoDisposeProviderRef<SearchNotesUseCase>;
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
    r'468955cad758edc54059e3286de3b9c21d51582b';

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
String _$storageStatsHash() => r'7ff2b5d61e640dac44057801f8bdf016c8ca24ba';

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
String _$optimizeDatabaseHash() => r'aa0bb1997f5ce1fb1cc464820a960fceb5f34b43';

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
