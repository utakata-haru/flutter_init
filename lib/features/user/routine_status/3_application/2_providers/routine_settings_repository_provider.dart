import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_init_3/features/user/routine_status/1_domain/2_repositories/routine_settings_repository.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/3_usecases/update_threshold_setting_usecase.dart';
import 'package:flutter_init_3/features/user/routine_status/2_infrastructure/2_data_sources/1_local/routine_settings_local_data_source.dart';
import 'package:flutter_init_3/features/user/routine_status/2_infrastructure/2_data_sources/1_local/routine_settings_local_data_source_impl.dart';
import 'package:flutter_init_3/features/user/routine_status/2_infrastructure/3_repositories/routine_settings_repository_impl.dart';

import 'routine_repository_provider.dart';

part 'routine_settings_repository_provider.g.dart';

@Riverpod(keepAlive: true)
RoutineSettingsLocalDataSource routineSettingsLocalDataSource(Ref ref) {
  final database = ref.watch(routineStatusDatabaseProvider);
  return RoutineSettingsLocalDataSourceImpl(database);
}

@Riverpod(keepAlive: true)
RoutineSettingsRepository routineSettingsRepository(Ref ref) {
  final localDataSource = ref.watch(routineSettingsLocalDataSourceProvider);
  return RoutineSettingsRepositoryImpl(localDataSource);
}

@riverpod
UpdateThresholdSettingUseCase updateThresholdSettingUseCase(Ref ref) {
  final settingsRepository = ref.watch(routineSettingsRepositoryProvider);
  final routineRepository = ref.watch(routineRepositoryProvider);
  return UpdateThresholdSettingUseCase(settingsRepository, routineRepository);
}
