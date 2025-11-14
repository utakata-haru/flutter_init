import '../1_entities/routine_completion_result_entity.dart';
import '../1_entities/routine_entity.dart';

abstract class RoutineRepository {
  Stream<List<RoutineEntity>> watchAll();

  Future<List<RoutineEntity>> fetchAll();

  Future<RoutineEntity?> findById(String id);

  Future<void> upsert(RoutineEntity routine);

  Future<void> upsertAll(List<RoutineEntity> routines);

  Future<void> delete(String id);

  Future<void> applyCompletion(
    RoutineEntity routine,
    RoutineCompletionResultEntity result,
  );
}
