import 'package:flutter_init_3/core/exceptions/storage_exception.dart';

import '../1_models/routine_settings_model.dart';
import '../2_data_sources/1_local/exceptions/routine_local_exception.dart';
import '../2_data_sources/1_local/routine_settings_local_data_source.dart';
import '../../1_domain/1_entities/routine_entity.dart';
import '../../1_domain/2_repositories/routine_settings_repository.dart';

class RoutineSettingsRepositoryImpl implements RoutineSettingsRepository {
  RoutineSettingsRepositoryImpl(this._localDataSource);

  final RoutineSettingsLocalDataSource _localDataSource;

  static const _settingsId = 'default_routine_settings';

  @override
  Stream<RoutineThresholdSetting> watch() => _localDataSource
      .watch(_settingsId)
      .map((model) => model?.toEntity() ?? const RoutineThresholdSetting());

  @override
  Future<RoutineThresholdSetting> fetch() async {
    try {
      final model = await _localDataSource.fetch(_settingsId);
      if (model != null) {
        return model.toEntity();
      }

      final defaults = const RoutineThresholdSetting();
      await _localDataSource.save(
        RoutineSettingsModel.fromEntity(
          defaults,
          id: _settingsId,
          updatedAt: DateTime.now(),
        ),
      );
      return defaults;
    } on RoutineLocalException catch (error) {
      throw _mapToStorageException(error);
    }
  }

  @override
  Future<void> save(RoutineThresholdSetting setting) async {
    final model = RoutineSettingsModel.fromEntity(
      setting,
      id: _settingsId,
      updatedAt: DateTime.now(),
    );

    try {
      await _localDataSource.save(model);
    } on RoutineLocalException catch (error) {
      throw _mapToStorageException(error);
    }
  }

  StorageException _mapToStorageException(RoutineLocalException error) =>
      StorageException(error.message, originalError: error, code: error.code);
}
