enum LogLevel {
  debug('DEBUG'),
  info('INFO'),
  warning('WARNING'),
  error('ERROR');

  final String label;
  const LogLevel(this.label);
}

/// Сервис логирования с разными уровнями
class Logger {
  static const String _tag = 'DJ_MIXER';
  static LogLevel _currentLevel = LogLevel.info;
  static bool _enableFileLogging = false;

  /// Устанавливает минимальный уровень логирования
  static void setLogLevel(LogLevel level) {
    _currentLevel = level;
  }

  /// Включает/отключает логирование в файл
  static void setFileLogging(bool enable) {
    _enableFileLogging = enable;
  }

  /// DEBUG сообщение (для разработки)
  static void debug(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.debug, message, tag, error, stackTrace);
  }

  /// INFO сообщение (информационное)
  static void info(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.info, message, tag, error, stackTrace);
  }

  /// WARNING сообщение (предупреждение)
  static void warning(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.warning, message, tag, error, stackTrace);
  }

  /// ERROR сообщение (ошибка)
  static void error(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.error, message, tag, error, stackTrace);
  }

  static void _log(
    LogLevel level,
    String message,
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  ) {
    if (level.index < _currentLevel.index) return;

    final logTag = tag ?? _tag;
    final timestamp = DateTime.now().toIso8601String();
    final logMessage = '[$timestamp] ${level.label} [$logTag] $message';

    // Console output
    print(logMessage);

    if (error != null) {
      print('Error: $error');
    }

    if (stackTrace != null) {
      print('StackTrace: $stackTrace');
    }

    // TODO: Реализовать логирование в файл при необходимости
    if (_enableFileLogging) {
      // File logging implementation
    }
  }
}

