import 'package:sqlite3/sqlite3.dart';

class RoutineLocalException implements Exception {
  const RoutineLocalException._(
    this.message, {
    this.code,
    this.operation,
    this.tableName,
    this.reference,
    this.originalError,
    this.stackTrace,
  });

  final String message;
  final String? code;
  final String? operation;
  final String? tableName;
  final Map<String, dynamic>? reference;
  final Object? originalError;
  final StackTrace? stackTrace;

  factory RoutineLocalException.database({
    required String operation,
    required String tableName,
    Map<String, dynamic>? reference,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    final errorCode = _extractSqliteCode(originalError) ?? 'DATABASE_ERROR';

    return RoutineLocalException._(
      'ローカルDB操作に失敗しました（operation: $operation, table: $tableName）',
      code: errorCode,
      operation: operation,
      tableName: tableName,
      reference: reference,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  factory RoutineLocalException.notFound({
    required String tableName,
    Map<String, dynamic>? reference,
  }) => RoutineLocalException._(
    '対象データが見つかりません（table: $tableName, reference: ${reference ?? {}}）',
    code: 'RECORD_NOT_FOUND',
    operation: 'query',
    tableName: tableName,
    reference: reference,
  );

  factory RoutineLocalException.unknown({
    required String operation,
    required String tableName,
    Map<String, dynamic>? reference,
    Object? originalError,
    StackTrace? stackTrace,
  }) => RoutineLocalException._(
    'ローカルデータソースで予期しないエラーが発生しました（operation: $operation, table: $tableName）',
    code: 'UNKNOWN_LOCAL_ERROR',
    operation: operation,
    tableName: tableName,
    reference: reference,
    originalError: originalError,
    stackTrace: stackTrace,
  );

  @override
  String toString() {
    final buffer = StringBuffer('RoutineLocalException(message: $message');
    if (code != null) {
      buffer.write(', code: $code');
    }
    if (operation != null) {
      buffer.write(', operation: $operation');
    }
    if (tableName != null) {
      buffer.write(', table: $tableName');
    }
    if (reference != null && reference!.isNotEmpty) {
      buffer.write(', reference: $reference');
    }
    if (originalError != null) {
      buffer.write(', originalError: $originalError');
    }
    buffer.write(')');
    return buffer.toString();
  }
}

String? _extractSqliteCode(Object? error) {
  if (error is SqliteException) {
    return 'SQLITE_${error.extendedResultCode}';
  }
  return null;
}
