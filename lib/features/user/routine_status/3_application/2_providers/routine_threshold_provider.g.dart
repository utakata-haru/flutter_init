// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_threshold_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routineThresholdStream)
const routineThresholdStreamProvider = RoutineThresholdStreamProvider._();

final class RoutineThresholdStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<RoutineThresholdSetting>,
          RoutineThresholdSetting,
          Stream<RoutineThresholdSetting>
        >
    with
        $FutureModifier<RoutineThresholdSetting>,
        $StreamProvider<RoutineThresholdSetting> {
  const RoutineThresholdStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routineThresholdStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routineThresholdStreamHash();

  @$internal
  @override
  $StreamProviderElement<RoutineThresholdSetting> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<RoutineThresholdSetting> create(Ref ref) {
    return routineThresholdStream(ref);
  }
}

String _$routineThresholdStreamHash() =>
    r'38410ee2e82f870327817384ef4b60986597d279';

@ProviderFor(routineThreshold)
const routineThresholdProvider = RoutineThresholdProvider._();

final class RoutineThresholdProvider
    extends
        $FunctionalProvider<
          AsyncValue<RoutineThresholdSetting>,
          RoutineThresholdSetting,
          FutureOr<RoutineThresholdSetting>
        >
    with
        $FutureModifier<RoutineThresholdSetting>,
        $FutureProvider<RoutineThresholdSetting> {
  const RoutineThresholdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routineThresholdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routineThresholdHash();

  @$internal
  @override
  $FutureProviderElement<RoutineThresholdSetting> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RoutineThresholdSetting> create(Ref ref) {
    return routineThreshold(ref);
  }
}

String _$routineThresholdHash() => r'f47a9f8f0282b2ad2aba7d8832805452fcdf127f';
