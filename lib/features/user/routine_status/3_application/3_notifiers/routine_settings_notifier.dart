import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_init_3/core/exceptions/base_exception.dart';
import 'package:flutter_init_3/core/exceptions/storage_exception.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/1_entities/routine_entity.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/exceptions/routine_failure.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/1_states/routine_settings_state.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/2_providers/routine_settings_repository_provider.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/2_providers/routine_threshold_provider.dart';

part 'routine_settings_notifier.g.dart';

@riverpod
class RoutineSettingsNotifier extends _$RoutineSettingsNotifier {
  @override
  RoutineSettingsState build() {
    _listenSettings();
    return const RoutineSettingsState(isLoading: true);
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final setting = await ref.read(routineThresholdProvider.future);
      state = state.copyWith(
        setting: setting,
        isLoading: false,
        errorMessage: null,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _formatError(error),
      );
    }
  }

  Future<void> save(RoutineThresholdSetting setting) async {
    state = state.copyWith(
      isSaving: true,
      errorMessage: null,
      saveSucceeded: null,
    );
    final useCase = ref.read(updateThresholdSettingUseCaseProvider);
    try {
      await useCase(setting);
      state = state.copyWith(
        isSaving: false,
        saveSucceeded: true,
        errorMessage: null,
      );
    } on RoutineFailure catch (error) {
      state = state.copyWith(
        isSaving: false,
        saveSucceeded: false,
        errorMessage: error.message,
      );
    } catch (error) {
      state = state.copyWith(
        isSaving: false,
        saveSucceeded: false,
        errorMessage: _formatError(error),
      );
    }
  }

  void clearSaveResult() {
    if (state.saveSucceeded != null) {
      state = state.copyWith(saveSucceeded: null);
    }
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(errorMessage: null);
    }
  }

  void _listenSettings() {
    ref.listen<AsyncValue<RoutineThresholdSetting>>(
      routineThresholdStreamProvider,
      (_, next) {
        next.when(
          data: (threshold) {
            state = state.copyWith(
              setting: threshold,
              isLoading: false,
              errorMessage: null,
            );
          },
          error: (error, stackTrace) {
            state = state.copyWith(
              isLoading: false,
              errorMessage: _formatError(error),
            );
          },
          loading: () {
            state = state.copyWith(isLoading: true);
          },
        );
      },
    );
  }

  String _formatError(Object error) {
    if (error is RoutineFailure) {
      return error.message;
    }
    if (error is StorageException) {
      return error.message;
    }
    if (error is BaseException) {
      return error.message;
    }
    return error.toString();
  }
}
