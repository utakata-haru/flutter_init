import 'base_exception.dart';

/// Exception for database-related errors
class DatabaseException extends BaseException {
  const DatabaseException({
    required super.message,
    super.code,
    super.stackTrace,
  });

  factory DatabaseException.notFound(String entity) {
    return DatabaseException(
      message: '$entity not found',
      code: 'DATABASE_NOT_FOUND',
    );
  }

  factory DatabaseException.insertFailed(String entity) {
    return DatabaseException(
      message: 'Failed to insert $entity',
      code: 'DATABASE_INSERT_FAILED',
    );
  }

  factory DatabaseException.updateFailed(String entity) {
    return DatabaseException(
      message: 'Failed to update $entity',
      code: 'DATABASE_UPDATE_FAILED',
    );
  }

  factory DatabaseException.deleteFailed(String entity) {
    return DatabaseException(
      message: 'Failed to delete $entity',
      code: 'DATABASE_DELETE_FAILED',
    );
  }

  @override
  String toString() {
    if (code != null) {
      return 'DatabaseException[$code]: $message';
    }
    return 'DatabaseException: $message';
  }
}
