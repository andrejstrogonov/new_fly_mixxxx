/// Расширения для String
extension StringExtension on String {
  /// Проверяет, является ли строка пустой или содержит только пробелы
  bool get isNullOrEmpty => isEmpty || trim().isEmpty;

  /// Капитализирует первую букву
  String get capitalize => isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : this;

  /// Укорачивает строку до указанной длины с многоточием
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }

  /// Удаляет лишние пробелы в начале и конце, а также заменяет множественные пробелы на один
  String normalizeWhitespace() => trim().replaceAll(RegExp(r'\s+'), ' ');

  /// Проверяет, является ли строка действительным путем к аудиофайлу
  bool get isAudioFile {
    final ext = toLowerCase();
    return ext.endsWith('.mp3') ||
        ext.endsWith('.wav') ||
        ext.endsWith('.flac') ||
        ext.endsWith('.aac') ||
        ext.endsWith('.m4a');
  }

  /// Получает расширение файла
  String get fileExtension {
    if (!contains('.')) return '';
    return split('.').last.toLowerCase();
  }

  /// Получает имя файла без расширения
  String get fileNameWithoutExtension {
    if (contains('.')) {
      return substring(0, lastIndexOf('.'));
    }
    return this;
  }
}

