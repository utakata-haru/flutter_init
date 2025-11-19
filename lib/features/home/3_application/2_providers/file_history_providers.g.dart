// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_history_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fileHistoryRepository)
const fileHistoryRepositoryProvider = FileHistoryRepositoryProvider._();

final class FileHistoryRepositoryProvider
    extends
        $FunctionalProvider<
          FileHistoryRepository,
          FileHistoryRepository,
          FileHistoryRepository
        >
    with $Provider<FileHistoryRepository> {
  const FileHistoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fileHistoryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fileHistoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<FileHistoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FileHistoryRepository create(Ref ref) {
    return fileHistoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FileHistoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FileHistoryRepository>(value),
    );
  }
}

String _$fileHistoryRepositoryHash() =>
    r'de2a3ea7e299a902d44b2020294d744a7ac647fa';
