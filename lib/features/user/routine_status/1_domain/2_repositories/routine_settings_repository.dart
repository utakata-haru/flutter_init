import '../1_entities/routine_entity.dart';

abstract class RoutineSettingsRepository {
  Stream<RoutineThresholdSetting> watch();

  Future<RoutineThresholdSetting> fetch();

  Future<void> save(RoutineThresholdSetting setting);
}
