import 'package:sqlite3/sqlite3.dart';

import 'package:flutter_init_3/core/database/database.dart';
import '../../1_models/routine_settings_model.dart';
import 'exceptions/routine_local_exception.dart';
import 'routine_settings_local_data_source.dart';

class RoutineSettingsLocalDataSourceImpl
    implements RoutineSettingsLocalDataSource {
  RoutineSettingsLocalDataSourceImpl(this._database);

  final AppDatabase _database;

  static const _settingsTableName = 'routine_settings_table';

  @override
  Stream<RoutineSettingsModel?> watch(String id) {
    final query =
        (_database.select(_database.routineSettingsTable)
              ..where((tbl) => tbl.id.equals(id))
              ..limit(1))
            .watchSingleOrNull();

    return query.map(
      (row) => row == null ? null : RoutineSettingsModel.fromData(row),
    );
  }

  @override
  Future<RoutineSettingsModel?> fetch(String id) async {
    try {
      final row =
          await (_database.select(_database.routineSettingsTable)
                ..where((tbl) => tbl.id.equals(id))
                ..limit(1))
              .getSingleOrNull();
      return row == null ? null : RoutineSettingsModel.fromData(row);
    } on SqliteException catch (error, stackTrace) {
      throw RoutineLocalException.database(
        operation: 'fetchSettings',
        tableName: _settingsTableName,
        reference: {'id': id},
        originalError: error,
        stackTrace: stackTrace,
      );
    } catch (error, stackTrace) {
      throw RoutineLocalException.unknown(
        operation: 'fetchSettings',
        tableName: _settingsTableName,
        reference: {'id': id},
        originalError: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> save(RoutineSettingsModel model) async {
    try {
      final now = DateTime.now();
      final companion = model.toCompanion(now: now);
      await _database
          .into(_database.routineSettingsTable)
          .insertOnConflictUpdate(companion);
    } on SqliteException catch (error, stackTrace) {
      throw RoutineLocalException.database(
        operation: 'saveSettings',
        tableName: _settingsTableName,
        reference: {'id': model.id},
        originalError: error,
        stackTrace: stackTrace,
      );
    } catch (error, stackTrace) {
      throw RoutineLocalException.unknown(
        operation: 'saveSettings',
        tableName: _settingsTableName,
        reference: {'id': model.id},
        originalError: error,
        stackTrace: stackTrace,
      );
    }
  }
}
