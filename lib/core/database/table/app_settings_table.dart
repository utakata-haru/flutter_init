import 'package:drift/drift.dart';

/// App settings table for storing application settings
class AppSettings extends Table {
  /// Setting key (unique identifier)
  TextColumn get key => text()();

  /// Setting value (JSON string)
  TextColumn get value => text()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {key};
}

/// Predefined setting keys
class AppSettingKey {
  static const String locale = 'locale';
  static const String mapViewPreferences = 'map_view_preferences';
  static const String aiApiKey = 'ai_api_key';
  static const String mapsApiKey = 'maps_api_key';
  static const String realtimeLocationEnabled = 'realtime_location_enabled';
  static const String onboardingCompleted = 'onboarding_completed';
}
