import 'dart:developer' as developer;

/// Simple logger utility
class Logger {
  static const String _tag = 'AITravelPersonaMap';

  /// Log debug message
  static void debug(String message, {String? tag}) {
    developer.log(
      message,
      name: tag ?? _tag,
      level: 500,
    );
  }

  /// Log info message
  static void info(String message, {String? tag}) {
    developer.log(
      message,
      name: tag ?? _tag,
      level: 800,
    );
  }

  /// Log warning message
  static void warning(String message, {String? tag}) {
    developer.log(
      message,
      name: tag ?? _tag,
      level: 900,
    );
  }

  /// Log error message
  static void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: tag ?? _tag,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
