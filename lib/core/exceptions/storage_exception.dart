import 'base_exception.dart';

/// Exception for storage-related errors
class StorageException extends BaseException {
  const StorageException({
    required super.message,
    super.code,
    super.stackTrace,
  });

  factory StorageException.permissionDenied() {
    return const StorageException(
      message: 'Storage permission denied',
      code: 'STORAGE_PERMISSION_DENIED',
    );
  }

  factory StorageException.storageFull() {
    return const StorageException(
      message: 'Storage is full',
      code: 'STORAGE_FULL',
    );
  }

  factory StorageException.fileNotFound(String path) {
    return StorageException(
      message: 'File not found: $path',
      code: 'STORAGE_FILE_NOT_FOUND',
    );
  }

  @override
  String toString() {
    if (code != null) {
      return 'StorageException[$code]: $message';
    }
    return 'StorageException: $message';
  }
}
