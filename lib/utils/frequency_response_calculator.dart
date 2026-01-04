import 'dart:math';

/// Класс для представления комплексного числа
class ComplexNumber {
  final double real;
  final double imag;

  ComplexNumber(this.real, this.imag);

  /// Модуль комплексного числа |z|
  double get magnitude => sqrt(real * real + imag * imag);

  /// Фаза комплексного числа arg(z) в радианах
  double get phase => atan2(imag, real);

  /// Фаза в градусах
  double get phaseDegrees => phase * 180.0 / pi;

  /// Усиление в децибелах: 20*log10(|z|)
  double get gainDb => 20.0 * log10(magnitude);

  ComplexNumber operator +(ComplexNumber other) =>
      ComplexNumber(real + other.real, imag + other.imag);

  ComplexNumber operator *(ComplexNumber other) =>
      ComplexNumber(
        real * other.real - imag * other.imag,
        real * other.imag + imag * other.real,
      );

  ComplexNumber operator /(ComplexNumber other) {
    double denominator = other.real * other.real + other.imag * other.imag;
    return ComplexNumber(
      (real * other.real + imag * other.imag) / denominator,
      (imag * other.real - real * other.imag) / denominator,
    );
  }
}

/// Расширение для удобного логарифма по основанию 10
double log10(double x) {
  return log(x) / log(10.0);
}

/// Класс для расчета правильных ЛАЧХ и ЛФЧХ (диаграмм Боде)
class FrequencyResponseCalculator {
  /// Расчет амплитудно-частотной характеристики (АЧХ) в дБ
  static double calculateMagnitudeDb(
    double frequency,
    List<double> eqBands,
  ) {
    ComplexNumber totalTransfer = ComplexNumber(1.0, 0.0);

    const bandFrequencies = [
      60.0, 150.0, 400.0, 1000.0, 2400.0,
      6000.0, 15000.0, 20000.0, 30000.0, 40000.0
    ];

    for (int i = 0; i < eqBands.length && i < bandFrequencies.length; i++) {
      if (eqBands[i] != 0.0) {
        ComplexNumber filter = _peakFilterComplex(
          frequency,
          bandFrequencies[i],
          eqBands[i],
          _getQFactor(i),
        );
        totalTransfer = totalTransfer * filter;
      }
    }

    return totalTransfer.gainDb;
  }

  /// Расчет фазо-частотной характеристики (ФЧХ) в градусах
  static double calculatePhaseDegrees(
    double frequency,
    List<double> eqBands,
  ) {
    ComplexNumber totalTransfer = ComplexNumber(1.0, 0.0);

    const bandFrequencies = [
      60.0, 150.0, 400.0, 1000.0, 2400.0,
      6000.0, 15000.0, 20000.0, 30000.0, 40000.0
    ];

    for (int i = 0; i < eqBands.length && i < bandFrequencies.length; i++) {
      if (eqBands[i] != 0.0) {
        ComplexNumber filter = _peakFilterComplex(
          frequency,
          bandFrequencies[i],
          eqBands[i],
          _getQFactor(i),
        );
        totalTransfer = totalTransfer * filter;
      }
    }

    double phase = totalTransfer.phaseDegrees;
    while (phase > 180.0) phase -= 360.0;
    while (phase < -180.0) phase += 360.0;
    return phase;
  }

  /// Комплексная передаточная функция пикового фильтра
  static ComplexNumber _peakFilterComplex(
    double frequency,
    double centerFrequency,
    double gainDb,
    double Q,
  ) {
    double w = 2.0 * pi * frequency;
    double w0 = 2.0 * pi * centerFrequency;
    double alpha = sin(w0) / (2.0 * Q);
    double A = pow(10.0, gainDb / 40.0).toDouble();

    double b0 = 1.0 + alpha * A;
    double b1 = -2.0 * cos(w0);
    double b2 = 1.0 - alpha * A;
    double a0 = 1.0 + alpha / A;
    double a1 = -2.0 * cos(w0);
    double a2 = 1.0 - alpha / A;

    ComplexNumber numerator = ComplexNumber(b0, 0.0)
        + ComplexNumber(b1 * cos(w), -b1 * sin(w))
        + ComplexNumber(b2 * cos(2.0 * w), -b2 * sin(2.0 * w));

    ComplexNumber denominator = ComplexNumber(a0, 0.0)
        + ComplexNumber(a1 * cos(w), -a1 * sin(w))
        + ComplexNumber(a2 * cos(2.0 * w), -a2 * sin(2.0 * w));

    return numerator / denominator;
  }

  static double _getQFactor(int bandIndex) {
    const qFactors = [0.5, 0.7, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 3.5, 3.5];
    return qFactors[bandIndex.clamp(0, qFactors.length - 1)];
  }

  static List<double> generateLogarithmicFrequencies({
    double minFrequency = 20.0,
    double maxFrequency = 20000.0,
    int pointCount = 100,
  }) {
    List<double> frequencies = [];
    double logMin = log(minFrequency) / log(10.0);
    double logMax = log(maxFrequency) / log(10.0);

    for (int i = 0; i < pointCount; i++) {
      double logFreq = logMin + (logMax - logMin) * (i / (pointCount - 1));
      double freq = exp(logFreq * log(10.0));
      frequencies.add(freq);
    }
    return frequencies;
  }

  static Map<String, double> calculateTransferFunction(
    double frequency,
    List<double> eqBands,
  ) {
    return {
      'magnitude_db': calculateMagnitudeDb(frequency, eqBands),
      'phase_degrees': calculatePhaseDegrees(frequency, eqBands),
    };
  }

  static bool validateFrequencyResponse(
    List<double> frequencies,
    List<double> magnitudes,
    List<double> phases,
  ) {
    if (frequencies.length != magnitudes.length || frequencies.length != phases.length) {
      return false;
    }

    for (int i = 1; i < frequencies.length; i++) {
      if (frequencies[i] <= frequencies[i - 1]) return false;
    }

    for (double mag in magnitudes) {
      if (mag.isNaN || mag.isInfinite || mag.abs() > 100) return false;
    }

    for (double phase in phases) {
      if (phase.isNaN || phase.isInfinite || phase.abs() > 360) return false;
    }

    return true;
  }

  static double calculateGroupDelay(
    double frequency,
    List<double> eqBands, [
    double deltaFrequency = 0.1,
  ]) {
    double phase1 = calculatePhaseDegrees(frequency - deltaFrequency, eqBands);
    double phase2 = calculatePhaseDegrees(frequency + deltaFrequency, eqBands);
    double dPhase = (phase2 - phase1) * pi / 180.0;
    double omega = 2.0 * pi * frequency;
    double dOmega = 2.0 * pi * (2.0 * deltaFrequency);
    return -dPhase / dOmega;
  }
}

