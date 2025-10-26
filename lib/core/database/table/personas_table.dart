import 'package:drift/drift.dart';

/// Personas table for storing AI persona data
class Personas extends Table {
  /// Unique identifier (UUID)
  TextColumn get id => text()();

  /// Persona name (1-50 characters)
  TextColumn get name => text().withLength(min: 1, max: 50)();

  /// Tone and style of the persona (free text)
  TextColumn get toneStyle => text().withDefault(const Constant(''))();

  /// Prompt text and conversation log (1-10,000 characters)
  TextColumn get promptText => text().withLength(min: 1, max: 10000)();

  /// Default persona flag
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
