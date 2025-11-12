import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_init_3/features/user/routine_status/1_domain/1_entities/routine_entity.dart';

part 'routine_settings_state.freezed.dart';

@freezed
abstract class RoutineSettingsState with _$RoutineSettingsState {
  const RoutineSettingsState._();

  const factory RoutineSettingsState({
    RoutineThresholdSetting? setting,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    String? errorMessage,
    bool? saveSucceeded,
  }) = _RoutineSettingsState;

  bool get hasError => errorMessage != null;

  bool get hasData => setting != null;
}
