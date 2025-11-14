import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_init_3/features/user/routine_status/1_domain/1_entities/routine_entity.dart';

part 'routine_settings_state.freezed.dart';

@freezed
abstract class RoutineSettingsState with _$RoutineSettingsState {
  const RoutineSettingsState._();

  const factory RoutineSettingsState({
    RoutineThresholdSetting? setting,
    @Default(<RoutineEntity>[]) List<RoutineEntity> routines,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isRoutineLoading,
    @Default(false) bool isReordering,
    String? errorMessage,
    bool? saveSucceeded,
  }) = _RoutineSettingsState;

  bool get hasError => errorMessage != null;

  bool get hasData => setting != null || routines.isNotEmpty;

  bool get isEmpty => !isLoading && routines.isEmpty && setting == null;
}
