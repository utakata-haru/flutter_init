import '../1_entities/routine_entity.dart';
import '../2_repositories/routine_repository.dart';

class ResetAllRoutineCompletionsUseCase {
  const ResetAllRoutineCompletionsUseCase(this._repository);

  final RoutineRepository _repository;

  Future<void> call() async {
  final List<RoutineEntity> routines = await _repository.fetchAll();
    for (final routine in routines) {
      if (routine.lastResult == null) {
        continue;
      }
      await _repository.upsert(routine.copyWith(lastResult: null));
    }
  }
}
