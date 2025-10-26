/// Base exception for all app exceptions
abstract class BaseException implements Exception {
  const BaseException({
    required this.message,
    this.code,
    this.stackTrace,
  });

  final String message;
  final String? code;
  final StackTrace? stackTrace;

  @override
  String toString() {
    if (code != null) {
      return 'BaseException[$code]: $message';
    }
    return 'BaseException: $message';
  }
}
