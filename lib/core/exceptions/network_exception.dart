import 'base_exception.dart';

/// Exception for network-related errors
class NetworkException extends BaseException {
  const NetworkException({
    required super.message,
    super.code,
    super.stackTrace,
  });

  factory NetworkException.noConnection() {
    return const NetworkException(
      message: 'No internet connection',
      code: 'NETWORK_NO_CONNECTION',
    );
  }

  factory NetworkException.timeout() {
    return const NetworkException(
      message: 'Request timeout',
      code: 'NETWORK_TIMEOUT',
    );
  }

  factory NetworkException.serverError() {
    return const NetworkException(
      message: 'Server error',
      code: 'NETWORK_SERVER_ERROR',
    );
  }

  @override
  String toString() {
    if (code != null) {
      return 'NetworkException[$code]: $message';
    }
    return 'NetworkException: $message';
  }
}
