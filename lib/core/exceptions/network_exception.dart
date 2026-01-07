import 'app_exception.dart';

/// Исключения, связанные с сетевыми операциями
class NetworkException extends AppException {
  NetworkException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
  );

  factory NetworkException.connectionTimeout() => NetworkException(
    message: 'Connection timeout',
    code: 'CONNECTION_TIMEOUT',
  );

  factory NetworkException.receiveTimeout() => NetworkException(
    message: 'Receive timeout',
    code: 'RECEIVE_TIMEOUT',
  );

  factory NetworkException.noInternet() => NetworkException(
    message: 'No internet connection',
    code: 'NO_INTERNET',
  );

  factory NetworkException.invalidResponse(int statusCode) => NetworkException(
    message: 'Invalid response from server (status: $statusCode)',
    code: 'INVALID_RESPONSE',
  );

  factory NetworkException.serverError(String? details) => NetworkException(
    message: 'Server error${details != null ? ': $details' : ''}',
    code: 'SERVER_ERROR',
  );

  factory NetworkException.parseError(String details) => NetworkException(
    message: 'Failed to parse response: $details',
    code: 'PARSE_ERROR',
  );
}

