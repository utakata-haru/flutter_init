import '../../1_models/routine_settings_model.dart';

abstract class RoutineSettingsLocalDataSource {
  Stream<RoutineSettingsModel?> watch(String id);

  Future<RoutineSettingsModel?> fetch(String id);

  Future<void> save(RoutineSettingsModel model);
}
