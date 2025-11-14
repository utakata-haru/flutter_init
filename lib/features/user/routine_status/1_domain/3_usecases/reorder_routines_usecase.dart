import '../1_entities/routine_entity.dart';
import '../2_repositories/routine_repository.dart';

class ReorderRoutinesUseCase {
  const ReorderRoutinesUseCase(this._repository);

  final RoutineRepository _repository;

  Future<void> call(List<RoutineEntity> routines) =>
      _repository.upsertAll(routines);
}
