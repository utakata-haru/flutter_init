import '../1_entities/routine_entity.dart';
import '../2_repositories/routine_repository.dart';

class FetchRoutinesUseCase {
  const FetchRoutinesUseCase(this._repository);

  final RoutineRepository _repository;

  Stream<List<RoutineEntity>> watch() => _repository.watchAll();

  Future<List<RoutineEntity>> call() => _repository.fetchAll();
}
