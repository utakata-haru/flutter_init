// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_dashboard_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RoutineDashboardNotifier)
const routineDashboardProvider = RoutineDashboardNotifierProvider._();

final class RoutineDashboardNotifierProvider
    extends $NotifierProvider<RoutineDashboardNotifier, RoutineDashboardState> {
  const RoutineDashboardNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routineDashboardProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routineDashboardNotifierHash();

  @$internal
  @override
  RoutineDashboardNotifier create() => RoutineDashboardNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoutineDashboardState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoutineDashboardState>(value),
    );
  }
}

String _$routineDashboardNotifierHash() =>
    r'b8e77b970f2d53a1d3083c79fc837288d14afe01';

abstract class _$RoutineDashboardNotifier
    extends $Notifier<RoutineDashboardState> {
  RoutineDashboardState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<RoutineDashboardState, RoutineDashboardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RoutineDashboardState, RoutineDashboardState>,
              RoutineDashboardState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
