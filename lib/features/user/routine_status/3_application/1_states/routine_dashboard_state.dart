import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_init_3/features/user/routine_status/1_domain/1_entities/routine_entity.dart';

part 'routine_dashboard_state.freezed.dart';

@freezed
abstract class RoutineDashboardState with _$RoutineDashboardState {
  const RoutineDashboardState._();

  const factory RoutineDashboardState({
    @Default(<RoutineEntity>[]) List<RoutineEntity> routines,
    RoutineThresholdSetting? thresholds,
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    String? errorMessage,
  }) = _RoutineDashboardState;

  bool get hasError => errorMessage != null;

  bool get hasData => routines.isNotEmpty;

  bool get isEmpty => !isLoading && routines.isEmpty && errorMessage == null;
}
