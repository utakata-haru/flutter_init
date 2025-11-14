import 'package:drift/drift.dart';
import 'package:sqlite3/sqlite3.dart';

import 'package:flutter_init_3/core/database/database.dart';
import '../../1_models/routine_model.dart';
import 'exceptions/routine_local_exception.dart';
import 'routine_local_data_source.dart';

class RoutineLocalDataSourceImpl implements RoutineLocalDataSource {
  RoutineLocalDataSourceImpl(this._database);

  final AppDatabase _database;

  static const _routineTableName = 'routine_table';

  @override
  Stream<List<RoutineModel>> watchAll() {
    final query = (_database.select(_database.routineTable)
      ..orderBy([
        (tbl) => OrderingTerm.asc(tbl.sortIndex),
        (tbl) => OrderingTerm.asc(tbl.targetHour),
        (tbl) => OrderingTerm.asc(tbl.targetMinute),
        (tbl) => OrderingTerm.asc(tbl.name),
      ]));

    return query.watch().map(
      (rows) => rows.map(RoutineModel.fromData).toList(growable: false),
    );
  }

  @override
  Future<List<RoutineModel>> fetchAll() async {
    try {
      final rows =
          await (_database.select(_database.routineTable)..orderBy([
                (tbl) => OrderingTerm.asc(tbl.sortIndex),
                (tbl) => OrderingTerm.asc(tbl.targetHour),
                (tbl) => OrderingTerm.asc(tbl.targetMinute),
                (tbl) => OrderingTerm.asc(tbl.name),
              ]))
              .get();
      return rows.map(RoutineModel.fromData).toList(growable: false);
    } on SqliteException catch (error, stackTrace) {
      throw RoutineLocalException.database(
        operation: 'fetchAll',
        tableName: _routineTableName,
        originalError: error,
        stackTrace: stackTrace,
      );
    } catch (error, stackTrace) {
      throw RoutineLocalException.unknown(
        operation: 'fetchAll',
        tableName: _routineTableName,
        originalError: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<RoutineModel?> findById(String id) async {
    try {
      final row =
          await (_database.select(_database.routineTable)
                ..where((tbl) => tbl.id.equals(id))
                ..limit(1))
              .getSingleOrNull();
      return row == null ? null : RoutineModel.fromData(row);
    } on SqliteException catch (error, stackTrace) {
      throw RoutineLocalException.database(
        operation: 'findById',
        tableName: _routineTableName,
        reference: {'id': id},
        originalError: error,
        stackTrace: stackTrace,
      );
    } catch (error, stackTrace) {
      throw RoutineLocalException.unknown(
        operation: 'findById',
        tableName: _routineTableName,
        reference: {'id': id},
        originalError: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> upsert(RoutineModel model) async {
    try {
      final companion = model.toCompanion(now: DateTime.now());
      await _database
          .into(_database.routineTable)
          .insertOnConflictUpdate(companion);
    } on SqliteException catch (error, stackTrace) {
      throw RoutineLocalException.database(
        operation: 'upsert',
        tableName: _routineTableName,
        reference: {'id': model.id},
        originalError: error,
        stackTrace: stackTrace,
      );
    } catch (error, stackTrace) {
      throw RoutineLocalException.unknown(
        operation: 'upsert',
        tableName: _routineTableName,
        reference: {'id': model.id},
        originalError: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> upsertAll(List<RoutineModel> models) async {
    if (models.isEmpty) {
      return;
    }

    try {
      final now = DateTime.now();
      await _database.batch((batch) {
        for (final model in models) {
          batch.insert(
            _database.routineTable,
            model.toCompanion(now: now),
            mode: InsertMode.insertOrReplace,
          );
        }
      });
    } on SqliteException catch (error, stackTrace) {
      throw RoutineLocalException.database(
        operation: 'upsertAll',
        tableName: _routineTableName,
        originalError: error,
        stackTrace: stackTrace,
      );
    } catch (error, stackTrace) {
      throw RoutineLocalException.unknown(
        operation: 'upsertAll',
        tableName: _routineTableName,
        originalError: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      final deleted = await (_database.delete(
        _database.routineTable,
      )..where((tbl) => tbl.id.equals(id))).go();
      if (deleted == 0) {
        throw RoutineLocalException.notFound(
          tableName: _routineTableName,
          reference: {'id': id},
        );
      }
    } on RoutineLocalException {
      rethrow;
    } on SqliteException catch (error, stackTrace) {
      throw RoutineLocalException.database(
        operation: 'delete',
        tableName: _routineTableName,
        reference: {'id': id},
        originalError: error,
        stackTrace: stackTrace,
      );
    } catch (error, stackTrace) {
      throw RoutineLocalException.unknown(
        operation: 'delete',
        tableName: _routineTableName,
        reference: {'id': id},
        originalError: error,
        stackTrace: stackTrace,
      );
    }
  }
}
