import 'base_exception.dart';

/// Exception for API-related errors
class ApiException extends BaseException {
  const ApiException({
    required super.message,
    super.code,
    super.stackTrace,
  });

  factory ApiException.invalidApiKey() {
    return const ApiException(
      message: 'Invalid API key',
      code: 'API_KEY_INVALID',
    );
  }

  factory ApiException.quotaExceeded() {
    return const ApiException(
      message: 'API quota exceeded',
      code: 'API_QUOTA_EXCEEDED',
    );
  }

  factory ApiException.timeout() {
    return const ApiException(
      message: 'API request timeout',
      code: 'API_TIMEOUT',
    );
  }

  factory ApiException.contentFiltered() {
    return const ApiException(
      message: 'Content filtered by policy',
      code: 'API_CONTENT_FILTERED',
    );
  }

  @override
  String toString() {
    if (code != null) {
      return 'ApiException[$code]: $message';
    }
    return 'ApiException: $message';
  }
}
