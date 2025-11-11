import '../../1_models/routine_model.dart';

abstract class RoutineLocalDataSource {
  Stream<List<RoutineModel>> watchAll();

  Future<List<RoutineModel>> fetchAll();

  Future<RoutineModel?> findById(String id);

  Future<void> upsert(RoutineModel model);

  Future<void> upsertAll(List<RoutineModel> models);

  Future<void> delete(String id);
}
