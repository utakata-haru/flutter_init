import 'package:drift/drift.dart';

/// Spots table for storing travel spot data
class Spots extends Table {
  /// Unique identifier (UUID)
  TextColumn get id => text()();

  /// Spot name/title (1-100 characters)
  TextColumn get title => text().withLength(min: 1, max: 100)();

  /// Address (1-500 characters)
  TextColumn get address => text().withLength(min: 1, max: 500)();

  /// Latitude
  RealColumn get lat => real()();

  /// Longitude
  RealColumn get lng => real()();

  /// Visited date and time
  DateTimeColumn get visitedAt => dateTime()();

  /// Total photo size in bytes
  IntColumn get totalPhotoSize => integer().withDefault(const Constant(0))();

  /// Review text
  TextColumn get reviewText => text().withDefault(const Constant(''))();

  /// Review generated flag (true=AI generated, false=manual)
  BoolColumn get reviewGeneratedFlag => boolean().withDefault(const Constant(false))();

  /// Persona ID (nullable, references Personas table)
  TextColumn get personaId => text().nullable()();

  /// Share token (nullable)
  TextColumn get shareToken => text().nullable()();

  /// Share link expiration date (nullable)
  DateTimeColumn get shareExpiresAt => dateTime().nullable()();

  /// Sync status ('local', 'synced', 'failed')
  TextColumn get syncStatus => text().withDefault(const Constant('local'))();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
