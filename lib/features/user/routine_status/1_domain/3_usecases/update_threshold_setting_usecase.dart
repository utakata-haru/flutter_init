import '../1_entities/routine_entity.dart';
import '../2_repositories/routine_repository.dart';
import '../2_repositories/routine_settings_repository.dart';
import '../exceptions/routine_failure.dart';

class UpdateThresholdSettingUseCase {
  const UpdateThresholdSettingUseCase(
    this._settingsRepository,
    this._routineRepository,
  );

  final RoutineSettingsRepository _settingsRepository;
  final RoutineRepository _routineRepository;

  Future<void> call(RoutineThresholdSetting setting) async {
    if (!setting.isValid) {
      throw const RoutineFailure.invalidThreshold();
    }

    await _settingsRepository.save(setting);

    final routines = await _routineRepository.fetchAll();
    for (final routine in routines) {
      final updated = routine.applyThresholds(setting);
      await _routineRepository.upsert(updated);
    }
  }
}
