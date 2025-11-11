import '../1_entities/routine_completion_result_entity.dart';
import '../1_entities/routine_entity.dart';
import '../2_repositories/routine_repository.dart';

class CompleteRoutineUseCase {
  CompleteRoutineUseCase(this._repository);

  final RoutineRepository _repository;

  Future<RoutineCompletionResultEntity> call({
    required RoutineEntity routine,
    required DateTime completedAt,
    DateTime? referenceDate,
  }) async {
    final scheduled = routine.targetTime.asDateTime(
      referenceDate ?? completedAt,
    );
    final delayMinutes = _delayMinutes(scheduled, completedAt);
    final status = routine.thresholds.evaluate(Duration(minutes: delayMinutes));

    final result = RoutineCompletionResultEntity(
      routineId: routine.id,
      scheduledDateTime: scheduled,
      completedAt: completedAt,
      status: status,
      delayMinutes: delayMinutes,
    );

    final updatedRoutine = routine.applyResult(result);
    await _repository.applyCompletion(updatedRoutine, result);
    return result;
  }

  int _delayMinutes(DateTime scheduled, DateTime completedAt) {
    if (!completedAt.isAfter(scheduled)) {
      return 0;
    }
    return completedAt.difference(scheduled).inMinutes;
  }
}
