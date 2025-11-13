import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_init_3/core/exceptions/base_exception.dart';
import 'package:flutter_init_3/core/exceptions/storage_exception.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/1_entities/routine_entity.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/exceptions/routine_failure.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/1_states/routine_dashboard_state.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/2_providers/routine_repository_provider.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/2_providers/routine_threshold_provider.dart';

part 'routine_dashboard_notifier.g.dart';

@riverpod
class RoutineDashboardNotifier extends _$RoutineDashboardNotifier {
  @override
  RoutineDashboardState build() {
    _listenRoutines();
    _listenThresholds();
    ref.listen<AsyncValue<List<RoutineEntity>>>(
      routineListProvider,
      (_, __) {},
      fireImmediately: false,
    );
    return const RoutineDashboardState(isLoading: true);
  }

  Future<void> refresh() async {
    state = state.copyWith(isRefreshing: true, errorMessage: null);
    final useCase = ref.read(fetchRoutinesUseCaseProvider);
    try {
      final routines = await useCase();
      state = state.copyWith(
        routines: routines,
        isRefreshing: false,
        isLoading: false,
        errorMessage: null,
      );
    } catch (error) {
      state = state.copyWith(
        isRefreshing: false,
        isLoading: false,
        errorMessage: _formatError(error),
      );
    }
  }

  Future<bool> saveRoutine(RoutineEntity routine) async {
    final useCase = ref.read(updateRoutineUseCaseProvider);
    try {
      await useCase(routine);
      return true;
    } catch (error) {
      state = state.copyWith(errorMessage: _formatError(error));
      return false;
    }
  }

  Future<void> deleteRoutine(String id) async {
    final repository = ref.read(routineRepositoryProvider);
    try {
      await repository.delete(id);
    } catch (error) {
      state = state.copyWith(errorMessage: _formatError(error));
    }
  }

  Future<void> completeRoutine(
    RoutineEntity routine, {
    DateTime? completedAt,
  }) async {
    final useCase = ref.read(completeRoutineUseCaseProvider);
    try {
      await useCase(
        routine: routine,
        completedAt: completedAt ?? DateTime.now(),
      );
    } catch (error) {
      state = state.copyWith(errorMessage: _formatError(error));
    }
  }

  Future<void> undoCompletion(RoutineEntity routine) async {
    final useCase = ref.read(resetRoutineCompletionUseCaseProvider);
    try {
      await useCase(routine);
    } catch (error) {
      state = state.copyWith(errorMessage: _formatError(error));
    }
  }

  Future<bool> resetAllCompletions() async {
    final useCase = ref.read(resetAllRoutineCompletionsUseCaseProvider);
    try {
      await useCase();
      return true;
    } catch (error) {
      state = state.copyWith(errorMessage: _formatError(error));
      return false;
    }
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(errorMessage: null);
    }
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
            isLoading: false,
            isRefreshing: false,
            errorMessage: null,
          );
        },
        error: (error, stackTrace) {
          state = state.copyWith(
            isLoading: false,
            isRefreshing: false,
            errorMessage: _formatError(error),
          );
        },
        loading: () {
          state = state.copyWith(isLoading: true);
        },
      );
    });
  }

  void _listenThresholds() {
    ref.listen<AsyncValue<RoutineThresholdSetting>>(
      routineThresholdStreamProvider,
      (_, next) {
        next.when(
          data: (threshold) {
            state = state.copyWith(thresholds: threshold);
          },
          error: (error, stackTrace) {
            state = state.copyWith(errorMessage: _formatError(error));
          },
          loading: () {},
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
