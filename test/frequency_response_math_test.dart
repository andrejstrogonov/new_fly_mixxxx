import 'package:flutter_test/flutter_test.dart';
import 'dart:math';

void main() {
  group('Frequency Response Math Tests', () {
    /// Логарифм по основанию 10
    double log10(double x) => log(x) / log(10);

    /// Степень 10
    double pow10(double x) => pow(10, x).toDouble();

    test('log10 calculation is correct', () {
      expect(log10(10), closeTo(1.0, 0.0001));
      expect(log10(100), closeTo(2.0, 0.0001));
      expect(log10(1000), closeTo(3.0, 0.0001));
      expect(log10(20), closeTo(1.301, 0.001));
    });

    test('pow10 calculation is correct', () {
      expect(pow10(1), closeTo(10.0, 0.0001));
      expect(pow10(2), closeTo(100.0, 0.0001));
      expect(pow10(3), closeTo(1000.0, 0.0001));
    });

    test('Logarithmic frequency generation', () {
      final logMin = log10(20.0);   // log10(20)
      final logMax = log10(20000.0); // log10(20000)
      final points = 50;

      List<double> frequencies = [];

      for (int i = 0; i < points; i++) {
        double logFreq = logMin + (logMax - logMin) * (i / (points - 1));
        double freq = pow10(logFreq);
        frequencies.add(freq);
      }

      expect(frequencies.length, 50);
      expect(frequencies.first, closeTo(20, 1));
      expect(frequencies.last, closeTo(20000, 100));

      // Проверяем логарифмическое расстояние
      expect(frequencies[1] / frequencies[0],
             closeTo(frequencies[25] / frequencies[24], 0.01));
    });

    test('dB to linear conversion', () {
      double dbToLinear(double dbValue) {
        return pow10(dbValue / 20).toDouble();
      }

      expect(dbToLinear(0), closeTo(1.0, 0.0001));
      expect(dbToLinear(6), closeTo(2.0, 0.01)); // 6dB ≈ 2x
      expect(dbToLinear(20), closeTo(10.0, 0.01)); // 20dB = 10x
      expect(dbToLinear(-6), closeTo(0.5, 0.01)); // -6dB = 0.5x
    });

    test('Linear to dB conversion', () {
      double linearToDb(double value) {
        if (value <= 0) return -120.0;
        return 20 * log(value) / log(10);
      }

      expect(linearToDb(1.0), closeTo(0, 0.0001));
      expect(linearToDb(2.0), closeTo(6.02, 0.01));
      expect(linearToDb(10.0), closeTo(20, 0.01));
      expect(linearToDb(0.5), closeTo(-6.02, 0.01));
      expect(linearToDb(0), -120.0);
    });

    test('Bode plot magnitude calculation', () {
      // H(jω) = ωn² / (s² + 2ζωn*s + ωn²)
      // На резонансе (ω = ωn): |H(jωn)| = 1 / (2ζ)

      double omega = 1000; // rad/s
      double omegaN = 1000; // Natural frequency
      double zeta = 0.707; // Damping ratio (critical damping)

      double numerator = omegaN * omegaN;
      double real = numerator - omega * omega;
      double imag = 2 * zeta * omegaN * omega;

      double magnitude = sqrt(real * real + imag * imag);
      double magnitudeDb = 20 * log10(numerator / magnitude);

      expect(magnitudeDb, greaterThan(-40));
      expect(magnitudeDb, lessThan(10));
    });

    test('Bode plot phase calculation', () {
      // Phase = atan2(imaginary, real)

      double omega = 1000;
      double omegaN = 1000;
      double zeta = 0.707;

      double numerator = omegaN * omegaN;
      double real = numerator - omega * omega;
      double imag = 2 * zeta * omegaN * omega;

      double phase = atan2(imag, real) * 180 / pi;

      expect(phase, greaterThan(-180));
      expect(phase, lessThan(180));
    });

    test('Frequency response across audio range', () {
      final frequencies = [20, 100, 500, 1000, 5000, 10000, 20000];

      for (final freq in frequencies) {
        expect(freq, greaterThan(0));
        expect(freq, lessThanOrEqualTo(20000));
      }
    });

    test('Phase wrapping for Bode diagram', () {
      double wrapPhase(double phase) {
        while (phase > 180) phase -= 360;
        while (phase < -180) phase += 360;
        return phase;
      }

      expect(wrapPhase(270), -90);
      expect(wrapPhase(450), 90);
      expect(wrapPhase(-270), 90);
      expect(wrapPhase(0), 0);
    });

    test('Magnitude clipping for display', () {
      double clampMagnitude(double mag) => mag.clamp(-12.0, 12.0);

      expect(clampMagnitude(5), 5);
      expect(clampMagnitude(20), 12.0);
      expect(clampMagnitude(-20), -12.0);
      expect(clampMagnitude(-12), -12);
    });
  });
}

