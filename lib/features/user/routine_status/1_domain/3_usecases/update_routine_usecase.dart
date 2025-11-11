import '../1_entities/routine_entity.dart';
import '../2_repositories/routine_repository.dart';

class UpdateRoutineUseCase {
  const UpdateRoutineUseCase(this._repository);

  final RoutineRepository _repository;

  Future<void> call(RoutineEntity routine) => _repository.upsert(routine);
}
