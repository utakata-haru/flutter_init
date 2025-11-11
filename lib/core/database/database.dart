import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'table/routine_settings_table.dart';
import 'table/routine_table.dart';

part 'database.g.dart';

LazyDatabase _openConnection() => LazyDatabase(() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File(p.join(directory.path, 'routine_status.sqlite'));
  return NativeDatabase.createInBackground(file);
});

@DriftDatabase(tables: [RoutineTable, RoutineSettingsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase({QueryExecutor? executor}) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < to) {
        await m.createAll();
      }
    },
  );
}
