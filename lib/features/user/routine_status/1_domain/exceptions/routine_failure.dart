class RoutineFailure implements Exception {
  const RoutineFailure._(this.message);

  const RoutineFailure.invalidThreshold()
    : this._('Invalid threshold configuration');

  const RoutineFailure.notFound() : this._('Routine not found');

  final String message;

  @override
  String toString() => 'RoutineFailure: $message';
}
