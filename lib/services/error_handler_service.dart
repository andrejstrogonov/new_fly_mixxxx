import '../core/exceptions/app_exception.dart';
import '../core/utils/logger.dart';
import '../domain/entities/result.dart';

/// Сервис для обработки ошибок
class ErrorHandlerService {
  static const String _tag = 'ErrorHandler';

  /// Обрабатывает исключение и преобразует его в Failure
  static Failure handleException(dynamic exception, {String? context}) {
    Logger.error(
      'Exception occurred${context != null ? ' in $context' : ''}',
      tag: _tag,
      error: exception,
    );

    if (exception is AppException) {
      return Failure(
        message: exception.message,
        code: exception.code,
        originalException: exception.originalException,
      );
    }

    if (exception is FormatException) {
      return Failure(
        message: 'Invalid format: ${exception.message}',
        code: 'FORMAT_ERROR',
        originalException: exception,
      );
    }

    if (exception is TimeoutException) {
      return Failure(
        message: 'Operation timed out',
        code: 'TIMEOUT',
        originalException: exception,
      );
    }

    // Общее исключение
    return Failure(
      message: exception.toString(),
      code: 'UNKNOWN_ERROR',
      originalException: exception,
    );
  }

  /// Показывает пользовательское сообщение об ошибке
  static String getUserFriendlyMessage(Failure failure) {
    switch (failure.code) {
      case 'TIMEOUT':
        return 'Operation took too long. Please try again.';
      case 'NO_INTERNET':
        return 'No internet connection. Please check your network.';
      case 'SERVER_ERROR':
        return 'Server error. Please try again later.';
      case 'FILE_NOT_FOUND':
        return 'File not found. Please check the file path.';
      case 'INVALID_PLAYER':
        return 'Invalid audio player.';
      case 'QUEUE_FULL':
        return 'Queue is full. Maximum 4 tracks allowed.';
      default:
        return failure.message;
    }
  }

  /// Логирует ошибку для аналитики
  static void logErrorForAnalytics(Failure failure, {String? stackTrace}) {
    Logger.error(
      '${failure.code}: ${failure.message}',
      tag: _tag,
    );
    if (stackTrace != null) {
      Logger.error('StackTrace: $stackTrace', tag: _tag);
    }
  }
}

