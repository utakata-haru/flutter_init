import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_init_3/core/exceptions/base_exception.dart';
import 'package:flutter_init_3/core/exceptions/storage_exception.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/1_entities/routine_entity.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/exceptions/routine_failure.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/1_states/routine_settings_state.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/2_providers/routine_repository_provider.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/2_providers/routine_settings_repository_provider.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/2_providers/routine_threshold_provider.dart';

part 'routine_settings_notifier.g.dart';

@riverpod
class RoutineSettingsNotifier extends _$RoutineSettingsNotifier {
  @override
  RoutineSettingsState build() {
    _listenSettings();
    _listenRoutines();
    return const RoutineSettingsState(
      isLoading: true,
      isRoutineLoading: true,
    );
  }

  Future<void> refresh() async {
    state = state.copyWith(
      isLoading: true,
      isRoutineLoading: true,
      isReordering: false,
      errorMessage: null,
    );
    try {
      final settingFuture = ref.read(routineThresholdProvider.future);
      final routinesFuture = ref.read(routineListProvider.future);

      final results = await Future.wait([
        settingFuture,
        routinesFuture,
      ]);

      final thresholdSetting = results[0] as RoutineThresholdSetting;
      final routines = results[1] as List<RoutineEntity>;

      state = state.copyWith(
        setting: thresholdSetting,
        routines: routines,
        isLoading: false,
        isRoutineLoading: false,
        isReordering: false,
        errorMessage: null,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        isRoutineLoading: false,
        isReordering: false,
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

  Future<bool> saveRoutine(RoutineEntity routine) async {
    final useCase = ref.read(updateRoutineUseCaseProvider);
    final existingIndex =
        state.routines.indexWhere((element) => element.id == routine.id);
    final isNew = existingIndex == -1;
    final nextSortIndex = isNew
        ? _nextSortIndex()
        : state.routines[existingIndex].sortIndex;
    final routineWithOrder = routine.copyWith(sortIndex: nextSortIndex);
    try {
      await useCase(routineWithOrder);
      return true;
    } catch (error) {
      state = state.copyWith(errorMessage: _formatError(error));
      return false;
    }
  }

  Future<bool> deleteRoutine(String id) async {
    final repository = ref.read(routineRepositoryProvider);
    try {
      await repository.delete(id);
      await _normalizeOrder(excludingId: id);
      return true;
    } catch (error) {
      state = state.copyWith(errorMessage: _formatError(error));
      return false;
    }
  }

  Future<void> moveRoutineTo(String routineId, int newIndex) async {
    final routines = state.routines;
    final oldIndex = routines.indexWhere((element) => element.id == routineId);
    if (oldIndex == -1 || newIndex < 0 || newIndex >= routines.length) {
      return;
    }
    await _applyReorder(oldIndex, newIndex);
  }

  Future<void> moveRoutineByDelta(String routineId, int delta) async {
    if (delta == 0) {
      return;
    }
    final routines = state.routines;
    final oldIndex = routines.indexWhere((element) => element.id == routineId);
    if (oldIndex == -1) {
      return;
    }
    final newIndex = (oldIndex + delta)
        .clamp(0, routines.length - 1)
        .toInt();
    if (oldIndex == newIndex) {
      return;
    }
    await _applyReorder(oldIndex, newIndex);
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
              isReordering: false,
              errorMessage: null,
            );
          },
          error: (error, stackTrace) {
            state = state.copyWith(
              isLoading: false,
              isReordering: false,
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

  void _listenRoutines() {
    ref.listen<AsyncValue<List<RoutineEntity>>>(routineStreamProvider, (
      _,
      next,
    ) {
      next.when(
        data: (routines) {
          state = state.copyWith(
            routines: routines,
            isRoutineLoading: false,
            isReordering: false,
            errorMessage: null,
          );
        },
        error: (error, stackTrace) {
          state = state.copyWith(
            isRoutineLoading: false,
            isReordering: false,
            errorMessage: _formatError(error),
          );
        },
        loading: () {
          state = state.copyWith(isRoutineLoading: true);
        },
      );
    });
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

  Future<void> _applyReorder(int oldIndex, int newIndex) async {
    final current = state.routines;
    if (oldIndex < 0 || oldIndex >= current.length) {
      return;
    }
    final adjustedNewIndex = newIndex.clamp(0, current.length - 1).toInt();
    if (oldIndex == adjustedNewIndex) {
      return;
    }

    final updated = List<RoutineEntity>.from(current);
    final item = updated.removeAt(oldIndex);
    updated.insert(adjustedNewIndex, item);
    await _persistOrder(updated);
  }

  Future<void> _normalizeOrder({String? excludingId}) async {
    final filtered = excludingId == null
        ? state.routines
        : state.routines.where((routine) => routine.id != excludingId).toList();
    if (filtered.isEmpty) {
      state = state.copyWith(routines: filtered, isReordering: false);
      return;
    }
    await _persistOrder(filtered);
  }

  Future<void> _persistOrder(List<RoutineEntity> ordered) async {
    final previous = state.routines;
    final reindexed = [
      for (var i = 0; i < ordered.length; i++)
        ordered[i].copyWith(sortIndex: i),
    ];

    state = state.copyWith(
      routines: reindexed,
      isReordering: true,
      errorMessage: null,
    );

    final useCase = ref.read(reorderRoutinesUseCaseProvider);
    try {
      await useCase(reindexed);
      state = state.copyWith(isReordering: false);
    } catch (error) {
      state = state.copyWith(
        routines: previous,
        isReordering: false,
        errorMessage: _formatError(error),
      );
    }
  }

  int _nextSortIndex() {
    if (state.routines.isEmpty) {
      return 0;
    }
    final maxValue = state.routines.map((r) => r.sortIndex).fold<int>(
          0,
          (previous, element) => element > previous ? element : previous,
        );
    return maxValue + 1;
  }
}
