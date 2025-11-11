import 'package:drift/drift.dart';

class RoutineSettingsTable extends Table {
  TextColumn get id => text()();

  IntColumn get allowableDelayMinutes => integer()();

  IntColumn get criticalDelayMinutes => integer()();

  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();

  @override
  Set<Column> get primaryKey => {id};
}
