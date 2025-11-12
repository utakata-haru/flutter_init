// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_settings_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routineSettingsLocalDataSource)
const routineSettingsLocalDataSourceProvider =
    RoutineSettingsLocalDataSourceProvider._();

final class RoutineSettingsLocalDataSourceProvider
    extends
        $FunctionalProvider<
          RoutineSettingsLocalDataSource,
          RoutineSettingsLocalDataSource,
          RoutineSettingsLocalDataSource
        >
    with $Provider<RoutineSettingsLocalDataSource> {
  const RoutineSettingsLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routineSettingsLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routineSettingsLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<RoutineSettingsLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RoutineSettingsLocalDataSource create(Ref ref) {
    return routineSettingsLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoutineSettingsLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoutineSettingsLocalDataSource>(
        value,
      ),
    );
  }
}

String _$routineSettingsLocalDataSourceHash() =>
    r'd063c04576694b080fe58c187cefdf165f52f157';

@ProviderFor(routineSettingsRepository)
const routineSettingsRepositoryProvider = RoutineSettingsRepositoryProvider._();

final class RoutineSettingsRepositoryProvider
    extends
        $FunctionalProvider<
          RoutineSettingsRepository,
          RoutineSettingsRepository,
          RoutineSettingsRepository
        >
    with $Provider<RoutineSettingsRepository> {
  const RoutineSettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routineSettingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routineSettingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<RoutineSettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RoutineSettingsRepository create(Ref ref) {
    return routineSettingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoutineSettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoutineSettingsRepository>(value),
    );
  }
}

String _$routineSettingsRepositoryHash() =>
    r'c08d4659c8da8010c0c64411fb2f75418b2cf745';

@ProviderFor(updateThresholdSettingUseCase)
const updateThresholdSettingUseCaseProvider =
    UpdateThresholdSettingUseCaseProvider._();

final class UpdateThresholdSettingUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateThresholdSettingUseCase,
          UpdateThresholdSettingUseCase,
          UpdateThresholdSettingUseCase
        >
    with $Provider<UpdateThresholdSettingUseCase> {
  const UpdateThresholdSettingUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateThresholdSettingUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateThresholdSettingUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateThresholdSettingUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateThresholdSettingUseCase create(Ref ref) {
    return updateThresholdSettingUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateThresholdSettingUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateThresholdSettingUseCase>(
        value,
      ),
    );
  }
}

String _$updateThresholdSettingUseCaseHash() =>
    r'295b4b573a4c2b7262e87f20e26eccab62b967a4';
