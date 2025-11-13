import '../1_entities/routine_entity.dart';
import '../2_repositories/routine_repository.dart';

class ResetRoutineCompletionUseCase {
  const ResetRoutineCompletionUseCase(this._repository);

  final RoutineRepository _repository;

  Future<void> call(RoutineEntity routine) async {
    final cleared = routine.copyWith(lastResult: null);
    await _repository.upsert(cleared);
  }
}
