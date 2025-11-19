abstract class BaseException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const BaseException(this.message, {this.code, this.originalError});

  @override
  String toString() => 'BaseException(message: $message${code != null ? ', code: ${code!}' : ''})';
}
