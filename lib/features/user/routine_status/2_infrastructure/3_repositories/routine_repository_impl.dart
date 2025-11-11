import 'package:flutter_init_3/core/exceptions/storage_exception.dart';

import '../1_models/routine_model.dart';
import '../2_data_sources/1_local/exceptions/routine_local_exception.dart';
import '../2_data_sources/1_local/routine_local_data_source.dart';
import '../../1_domain/1_entities/routine_completion_result_entity.dart';
import '../../1_domain/1_entities/routine_entity.dart';
import '../../1_domain/2_repositories/routine_repository.dart';
import '../../1_domain/exceptions/routine_failure.dart';

class RoutineRepositoryImpl implements RoutineRepository {
  RoutineRepositoryImpl(this._localDataSource);

  final RoutineLocalDataSource _localDataSource;

  @override
  Stream<List<RoutineEntity>> watchAll() => _localDataSource.watchAll().map(
    (models) => models.map((model) => model.toEntity()).toList(growable: false),
  );

  @override
  Future<List<RoutineEntity>> fetchAll() async {
    try {
      final models = await _localDataSource.fetchAll();
      return models.map((model) => model.toEntity()).toList(growable: false);
    } on RoutineLocalException catch (error) {
      throw _mapToStorageException(error);
    }
  }

  @override
  Future<RoutineEntity?> findById(String id) async {
    try {
      final model = await _localDataSource.findById(id);
      return model?.toEntity();
    } on RoutineLocalException catch (error) {
      throw _mapToStorageException(error);
    }
  }

  @override
  Future<void> upsert(RoutineEntity routine) async {
    final model = RoutineModel.fromEntity(routine);
    try {
      await _localDataSource.upsert(model);
    } on RoutineLocalException catch (error) {
      throw _mapToStorageException(error);
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _localDataSource.delete(id);
    } on RoutineLocalException catch (error) {
      if (error.code == 'RECORD_NOT_FOUND') {
        throw const RoutineFailure.notFound();
      }
      throw _mapToStorageException(error);
    }
  }

  @override
  Future<void> applyCompletion(
    RoutineEntity routine,
    RoutineCompletionResultEntity result,
  ) async {
    final entityWithResult = routine.applyResult(result);
    final model = RoutineModel.fromEntity(entityWithResult);
    try {
      await _localDataSource.upsert(model);
    } on RoutineLocalException catch (error) {
      throw _mapToStorageException(error);
    }
  }

  StorageException _mapToStorageException(RoutineLocalException error) =>
      StorageException(error.message, originalError: error, code: error.code);
}
