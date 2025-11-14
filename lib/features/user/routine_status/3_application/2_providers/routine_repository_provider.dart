import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_init_3/core/database/database.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/1_entities/routine_entity.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/2_repositories/routine_repository.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/3_usecases/complete_routine_usecase.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/3_usecases/fetch_routines_usecase.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/3_usecases/reset_all_routine_completions_usecase.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/3_usecases/reset_routine_completion_usecase.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/3_usecases/reorder_routines_usecase.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/3_usecases/update_routine_usecase.dart';
import 'package:flutter_init_3/features/user/routine_status/2_infrastructure/2_data_sources/1_local/routine_local_data_source.dart';
import 'package:flutter_init_3/features/user/routine_status/2_infrastructure/2_data_sources/1_local/routine_local_data_source_impl.dart';
import 'package:flutter_init_3/features/user/routine_status/2_infrastructure/3_repositories/routine_repository_impl.dart';

part 'routine_repository_provider.g.dart';

@Riverpod(keepAlive: true)
AppDatabase routineStatusDatabase(Ref ref) => AppDatabase();

@Riverpod(keepAlive: true)
RoutineLocalDataSource routineLocalDataSource(Ref ref) {
  final database = ref.watch(routineStatusDatabaseProvider);
  return RoutineLocalDataSourceImpl(database);
}

@Riverpod(keepAlive: true)
RoutineRepository routineRepository(Ref ref) {
  final localDataSource = ref.watch(routineLocalDataSourceProvider);
  return RoutineRepositoryImpl(localDataSource);
}

@riverpod
FetchRoutinesUseCase fetchRoutinesUseCase(Ref ref) {
  final repository = ref.watch(routineRepositoryProvider);
  return FetchRoutinesUseCase(repository);
}

@riverpod
CompleteRoutineUseCase completeRoutineUseCase(Ref ref) {
  final repository = ref.watch(routineRepositoryProvider);
  return CompleteRoutineUseCase(repository);
}

@riverpod
ResetRoutineCompletionUseCase resetRoutineCompletionUseCase(Ref ref) {
  final repository = ref.watch(routineRepositoryProvider);
  return ResetRoutineCompletionUseCase(repository);
}

@riverpod
ResetAllRoutineCompletionsUseCase resetAllRoutineCompletionsUseCase(Ref ref) {
  final repository = ref.watch(routineRepositoryProvider);
  return ResetAllRoutineCompletionsUseCase(repository);
}

@riverpod
ReorderRoutinesUseCase reorderRoutinesUseCase(Ref ref) {
  final repository = ref.watch(routineRepositoryProvider);
  return ReorderRoutinesUseCase(repository);
}

@riverpod
UpdateRoutineUseCase updateRoutineUseCase(Ref ref) {
  final repository = ref.watch(routineRepositoryProvider);
  return UpdateRoutineUseCase(repository);
}

@riverpod
Stream<List<RoutineEntity>> routineStream(Ref ref) {
  final useCase = ref.watch(fetchRoutinesUseCaseProvider);
  return useCase.watch();
}

@riverpod
Future<List<RoutineEntity>> routineList(Ref ref) {
  final useCase = ref.watch(fetchRoutinesUseCaseProvider);
  return useCase();
}
