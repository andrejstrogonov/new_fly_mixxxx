/// Расширения для Duration
extension DurationExtension on Duration {
  /// Преобразует Duration в строку формата "mm:ss" или "hh:mm:ss"
  String toFormattedString() {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  /// Преобразует Duration в процентное значение (0-100)
  double toPercentage(Duration total) {
    if (total.inMilliseconds == 0) return 0;
    return (inMilliseconds / total.inMilliseconds * 100).clamp(0, 100);
  }

  /// Возвращает ближайшую Duration с заданным шагом
  Duration roundToNearest(Duration step) {
    final millis = inMilliseconds;
    final stepMillis = step.inMilliseconds;
    final rounded = ((millis / stepMillis).round() * stepMillis).toInt();
    return Duration(milliseconds: rounded);
  }
}

