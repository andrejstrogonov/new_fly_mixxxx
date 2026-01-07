import 'dart:math' as math;

/// Расширения для double
extension DoubleExtension on double {
  /// Округляет double до указанного количества знаков после запятой
  double roundToDecimal(int decimals) {
    final factor = math.pow(10.0, decimals);
    return (this * factor).round() / factor;
  }

  /// Преобразует децибелы в линейный коэффициент громкости (0-1)
  double dbToLinear() {
    return math.pow(10.0, this / 20.0) as double;
  }

  /// Преобразует линейный коэффициент громкости (0-1) в децибелы
  double linearToDb() {
    if (this <= 0) return -80.0; // Минимальное значение в dB
    return 20.0 * math.log(this) / math.log(10);
  }

  /// Преобразует frequency ratio в octaves
  double frequencyRatioToOctaves(double baseFrequency) {
    if (baseFrequency <= 0 || this <= 0) return 0;
    return math.log(this / baseFrequency) / math.log(2.0);
  }

  /// Проверяет, находится ли значение в диапазоне [min, max]
  bool isInRange(double min, double max) {
    return this >= min && this <= max;
  }

  /// Интерполирует между двумя значениями с коэффициентом t (0-1)
  double lerp(double end, double t) {
    return this + (end - this) * t;
  }

  /// Преобразует значение из одного диапазона в другой
  double remap(
    double inMin,
    double inMax,
    double outMin,
    double outMax,
  ) {
    if (inMax == inMin) return outMin;
    return outMin + (this - inMin) * (outMax - outMin) / (inMax - inMin);
  }

  /// Преобразует процент (0-100) в коэффициент (0-1)
  double percentToRatio() => this / 100;

  /// Преобразует коэффициент (0-1) в процент (0-100)
  double ratioToPercent() => this * 100;
}

