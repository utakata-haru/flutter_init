// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_history_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FileHistoryNotifier)
const fileHistoryProvider = FileHistoryNotifierProvider._();

final class FileHistoryNotifierProvider
    extends $AsyncNotifierProvider<FileHistoryNotifier, List<FileHistory>> {
  const FileHistoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fileHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fileHistoryNotifierHash();

  @$internal
  @override
  FileHistoryNotifier create() => FileHistoryNotifier();
}

String _$fileHistoryNotifierHash() =>
    r'b8d5f32ac089f779eed78dbba5681aaaf7fc1e8e';

abstract class _$FileHistoryNotifier extends $AsyncNotifier<List<FileHistory>> {
  FutureOr<List<FileHistory>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<FileHistory>>, List<FileHistory>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FileHistory>>, List<FileHistory>>,
              AsyncValue<List<FileHistory>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
