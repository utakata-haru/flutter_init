import 'package:drift/drift.dart';

class RoutineTable extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  IntColumn get targetHour => integer()();

  IntColumn get targetMinute => integer()();

  IntColumn get allowableDelayMinutes =>
      integer().withDefault(const Constant(5))();

  IntColumn get criticalDelayMinutes =>
      integer().withDefault(const Constant(15))();

  IntColumn get sortIndex => integer().withDefault(const Constant(0))();

  DateTimeColumn get lastScheduledAt => dateTime().nullable()();

  DateTimeColumn get lastCompletedAt => dateTime().nullable()();

  IntColumn get lastDelayMinutes => integer().nullable()();

  TextColumn get lastStatus => text().nullable()();

  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();

  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();

  @override
  Set<Column> get primaryKey => {id};
}
