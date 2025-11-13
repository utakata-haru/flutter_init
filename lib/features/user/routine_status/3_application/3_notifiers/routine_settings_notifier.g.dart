// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RoutineSettingsNotifier)
const routineSettingsProvider = RoutineSettingsNotifierProvider._();

final class RoutineSettingsNotifierProvider
    extends $NotifierProvider<RoutineSettingsNotifier, RoutineSettingsState> {
  const RoutineSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routineSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routineSettingsNotifierHash();

  @$internal
  @override
  RoutineSettingsNotifier create() => RoutineSettingsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoutineSettingsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoutineSettingsState>(value),
    );
  }
}

String _$routineSettingsNotifierHash() =>
    r'04b06b2c9fd24b92d4510110a88e56147a1c4156';

abstract class _$RoutineSettingsNotifier
    extends $Notifier<RoutineSettingsState> {
  RoutineSettingsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<RoutineSettingsState, RoutineSettingsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RoutineSettingsState, RoutineSettingsState>,
              RoutineSettingsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
