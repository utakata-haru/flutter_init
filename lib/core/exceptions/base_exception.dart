abstract class BaseException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const BaseException(this.message, {this.code, this.originalError});

  @override
  String toString() {
    final buffer = StringBuffer('BaseException(message: $message');
    if (code != null) {
      buffer.write(', code: $code');
    }
    buffer.write(')');
    return buffer.toString();
  }
}
