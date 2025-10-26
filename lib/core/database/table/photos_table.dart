import 'package:drift/drift.dart';

/// Photos table for storing photo metadata
class Photos extends Table {
  /// Unique identifier (UUID)
  TextColumn get id => text()();

  /// Spot ID (references Spots table)
  TextColumn get spotId => text()();

  /// Local file path
  TextColumn get path => text()();

  /// File size in bytes
  IntColumn get size => integer()();

  /// Display order (0-based)
  IntColumn get order => integer().withDefault(const Constant(0))();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
