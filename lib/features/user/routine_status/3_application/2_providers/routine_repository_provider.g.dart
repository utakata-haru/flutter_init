// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routineStatusDatabase)
const routineStatusDatabaseProvider = RoutineStatusDatabaseProvider._();

final class RoutineStatusDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  const RoutineStatusDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routineStatusDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routineStatusDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return routineStatusDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$routineStatusDatabaseHash() =>
    r'86748a5b969869ddf014d9a5c83e6bf1f30dd346';

@ProviderFor(routineLocalDataSource)
const routineLocalDataSourceProvider = RoutineLocalDataSourceProvider._();

final class RoutineLocalDataSourceProvider
    extends
        $FunctionalProvider<
          RoutineLocalDataSource,
          RoutineLocalDataSource,
          RoutineLocalDataSource
        >
    with $Provider<RoutineLocalDataSource> {
  const RoutineLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routineLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routineLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<RoutineLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RoutineLocalDataSource create(Ref ref) {
    return routineLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoutineLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoutineLocalDataSource>(value),
    );
  }
}

String _$routineLocalDataSourceHash() =>
    r'da3926a3763be8fc57a00688d60791a2166d3aa8';

@ProviderFor(routineRepository)
const routineRepositoryProvider = RoutineRepositoryProvider._();

final class RoutineRepositoryProvider
    extends
        $FunctionalProvider<
          RoutineRepository,
          RoutineRepository,
          RoutineRepository
        >
    with $Provider<RoutineRepository> {
  const RoutineRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routineRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routineRepositoryHash();

  @$internal
  @override
  $ProviderElement<RoutineRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RoutineRepository create(Ref ref) {
    return routineRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoutineRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoutineRepository>(value),
    );
  }
}

String _$routineRepositoryHash() => r'b0d5e887a1e9b00050a1856d7e094ccc15256293';

@ProviderFor(fetchRoutinesUseCase)
const fetchRoutinesUseCaseProvider = FetchRoutinesUseCaseProvider._();

final class FetchRoutinesUseCaseProvider
    extends
        $FunctionalProvider<
          FetchRoutinesUseCase,
          FetchRoutinesUseCase,
          FetchRoutinesUseCase
        >
    with $Provider<FetchRoutinesUseCase> {
  const FetchRoutinesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchRoutinesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchRoutinesUseCaseHash();

  @$internal
  @override
  $ProviderElement<FetchRoutinesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FetchRoutinesUseCase create(Ref ref) {
    return fetchRoutinesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FetchRoutinesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FetchRoutinesUseCase>(value),
    );
  }
}

String _$fetchRoutinesUseCaseHash() =>
    r'b4ff2e6e8b2925eb0a77e1d95a606e0c32427fc5';

@ProviderFor(completeRoutineUseCase)
const completeRoutineUseCaseProvider = CompleteRoutineUseCaseProvider._();

final class CompleteRoutineUseCaseProvider
    extends
        $FunctionalProvider<
          CompleteRoutineUseCase,
          CompleteRoutineUseCase,
          CompleteRoutineUseCase
        >
    with $Provider<CompleteRoutineUseCase> {
  const CompleteRoutineUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'completeRoutineUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$completeRoutineUseCaseHash();

  @$internal
  @override
  $ProviderElement<CompleteRoutineUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CompleteRoutineUseCase create(Ref ref) {
    return completeRoutineUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompleteRoutineUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompleteRoutineUseCase>(value),
    );
  }
}

String _$completeRoutineUseCaseHash() =>
    r'1a10e2d194a028c8bc9813378907391a8d4037cf';

@ProviderFor(resetRoutineCompletionUseCase)
const resetRoutineCompletionUseCaseProvider =
    ResetRoutineCompletionUseCaseProvider._();

final class ResetRoutineCompletionUseCaseProvider
    extends
        $FunctionalProvider<
          ResetRoutineCompletionUseCase,
          ResetRoutineCompletionUseCase,
          ResetRoutineCompletionUseCase
        >
    with $Provider<ResetRoutineCompletionUseCase> {
  const ResetRoutineCompletionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetRoutineCompletionUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resetRoutineCompletionUseCaseHash();

  @$internal
  @override
  $ProviderElement<ResetRoutineCompletionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ResetRoutineCompletionUseCase create(Ref ref) {
    return resetRoutineCompletionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResetRoutineCompletionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResetRoutineCompletionUseCase>(
        value,
      ),
    );
  }
}

String _$resetRoutineCompletionUseCaseHash() =>
    r'f2ea43592f8bcf30fe58495b23a0f2b67418ccbc';

@ProviderFor(resetAllRoutineCompletionsUseCase)
const resetAllRoutineCompletionsUseCaseProvider =
    ResetAllRoutineCompletionsUseCaseProvider._();

final class ResetAllRoutineCompletionsUseCaseProvider
    extends
        $FunctionalProvider<
          ResetAllRoutineCompletionsUseCase,
          ResetAllRoutineCompletionsUseCase,
          ResetAllRoutineCompletionsUseCase
        >
    with $Provider<ResetAllRoutineCompletionsUseCase> {
  const ResetAllRoutineCompletionsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetAllRoutineCompletionsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$resetAllRoutineCompletionsUseCaseHash();

  @$internal
  @override
  $ProviderElement<ResetAllRoutineCompletionsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ResetAllRoutineCompletionsUseCase create(Ref ref) {
    return resetAllRoutineCompletionsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResetAllRoutineCompletionsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResetAllRoutineCompletionsUseCase>(
        value,
      ),
    );
  }
}

String _$resetAllRoutineCompletionsUseCaseHash() =>
    r'a3d691c7e4d00ee41eb9b62d1e3a7a24925b986e';

@ProviderFor(updateRoutineUseCase)
const updateRoutineUseCaseProvider = UpdateRoutineUseCaseProvider._();

final class UpdateRoutineUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateRoutineUseCase,
          UpdateRoutineUseCase,
          UpdateRoutineUseCase
        >
    with $Provider<UpdateRoutineUseCase> {
  const UpdateRoutineUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateRoutineUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateRoutineUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateRoutineUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateRoutineUseCase create(Ref ref) {
    return updateRoutineUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateRoutineUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateRoutineUseCase>(value),
    );
  }
}

String _$updateRoutineUseCaseHash() =>
    r'c7bb1ecdd8824eb78f49111771c1fa8d2dc5ca25';

@ProviderFor(routineStream)
const routineStreamProvider = RoutineStreamProvider._();

final class RoutineStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RoutineEntity>>,
          List<RoutineEntity>,
          Stream<List<RoutineEntity>>
        >
    with
        $FutureModifier<List<RoutineEntity>>,
        $StreamProvider<List<RoutineEntity>> {
  const RoutineStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routineStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routineStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<RoutineEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<RoutineEntity>> create(Ref ref) {
    return routineStream(ref);
  }
}

String _$routineStreamHash() => r'89e35faecec8a19edbdca60952610a60ac634063';

@ProviderFor(routineList)
const routineListProvider = RoutineListProvider._();

final class RoutineListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RoutineEntity>>,
          List<RoutineEntity>,
          FutureOr<List<RoutineEntity>>
        >
    with
        $FutureModifier<List<RoutineEntity>>,
        $FutureProvider<List<RoutineEntity>> {
  const RoutineListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routineListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routineListHash();

  @$internal
  @override
  $FutureProviderElement<List<RoutineEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RoutineEntity>> create(Ref ref) {
    return routineList(ref);
  }
}

String _$routineListHash() => r'4d7224e9f3a71ae6aca99ebc5db5804ee08ea1eb';
