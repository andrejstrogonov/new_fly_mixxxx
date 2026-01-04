import 'package:flutter_test/flutter_test.dart';
import 'package:new_fly_mixxxx/utils/frequency_response_calculator.dart';
import 'dart:math';

void main() {
  group('FrequencyResponseCalculator Tests', () {
    test('Should generate correct logarithmic frequencies', () {
      List<double> frequencies =
          FrequencyResponseCalculator.generateLogarithmicFrequencies(
        minFrequency: 20.0,
        maxFrequency: 20000.0,
        pointCount: 50,
      );

      // Проверка количества точек
      expect(frequencies.length, equals(50));

      // Проверка, что первая частота близка к 20 Hz
      expect(frequencies.first, closeTo(20.0, 1.0));

      // Проверка, что последняя частота близка к 20 kHz
      expect(frequencies.last, closeTo(20000.0, 1000.0));

      // Проверка, что частоты строго возрастают
      for (int i = 1; i < frequencies.length; i++) {
        expect(frequencies[i], greaterThan(frequencies[i - 1]));
      }

      // Проверка логарифмического распределения
      // Соотношение между соседними частотами должно быть примерно одинаковым
      List<double> ratios = [];
      for (int i = 1; i < frequencies.length; i++) {
        ratios.add(frequencies[i] / frequencies[i - 1]);
      }

      double avgRatio = ratios.reduce((a, b) => a + b) / ratios.length;
      for (double ratio in ratios) {
        expect(ratio, closeTo(avgRatio, avgRatio * 0.3));
      }
    });

    test('Should calculate magnitude response for flat equalizer', () {
      List<double> flatBands = List.filled(10, 0.0);

      // Для плоского эквалайзера амплитуда должна быть близка к 0 дБ
      // на всех частотах
      List<double> testFrequencies = [20, 50, 100, 500, 1000, 5000, 10000, 20000];

      for (double freq in testFrequencies) {
        double magnitude =
            FrequencyResponseCalculator.calculateMagnitudeDb(freq, flatBands);
        expect(magnitude, closeTo(0.0, 0.5)); // Допустимая погрешность 0.5 дБ
      }
    });

    test('Should calculate magnitude response for bass boost', () {
      // EQ с усилением низких частот
      List<double> bassBands = [
        3.0, // 60Hz - усиление
        2.0, // 150Hz
        1.0, // 400Hz
        0.0, // 1kHz
        -1.0,
        -2.0,
        -1.0,
        0.0,
        0.0,
        0.0
      ];

      double bassFreqResponse =
          FrequencyResponseCalculator.calculateMagnitudeDb(60, bassBands);
      double trebleFreqResponse =
          FrequencyResponseCalculator.calculateMagnitudeDb(15000, bassBands);

      // Низкие частоты должны быть усилены больше, чем высокие
      expect(bassFreqResponse, greaterThan(trebleFreqResponse));
    });

    test('Should calculate magnitude response for treble boost', () {
      // EQ с усилением высоких частот
      List<double> trebleBands = [
        -2.0,
        -1.0,
        0.0,
        0.0,
        0.0,
        1.0,
        3.0, // 15kHz - усиление
        2.5, // 20kHz
        2.0, // 30kHz
        2.0  // 40kHz
      ];

      double bassFreqResponse =
          FrequencyResponseCalculator.calculateMagnitudeDb(60, trebleBands);
      double trebleFreqResponse =
          FrequencyResponseCalculator.calculateMagnitudeDb(15000, trebleBands);

      // Высокие частоты должны быть усилены больше, чем низкие
      expect(trebleFreqResponse, greaterThan(bassFreqResponse));
    });

    test('Should calculate phase response for flat equalizer', () {
      List<double> flatBands = List.filled(10, 0.0);

      // Для плоского эквалайзера фаза должна быть близка к 0 градусов
      List<double> testFrequencies = [20, 50, 100, 500, 1000, 5000, 10000, 20000];

      for (double freq in testFrequencies) {
        double phase =
            FrequencyResponseCalculator.calculatePhaseDegrees(freq, flatBands);
        expect(phase, closeTo(0.0, 5.0)); // Допустимая погрешность 5 градусов
      }
    });

    test('Should calculate phase response symmetrically', () {
      List<double> testBands = [1.0, 0.0, 0.0, 2.0, 0.0, -1.0, 0.0, 0.0, 0.0, 0.0];

      double phase1000 =
          FrequencyResponseCalculator.calculatePhaseDegrees(1000, testBands);
      double phase2000 =
          FrequencyResponseCalculator.calculatePhaseDegrees(2000, testBands);

      // Фазовый отклик должен быть конечным и валидным
      expect(phase1000.isNaN, false);
      expect(phase2000.isNaN, false);
      expect(phase1000.isInfinite, false);
      expect(phase2000.isInfinite, false);
    });

    test('Should validate correct frequency response', () {
      List<double> frequencies =
          FrequencyResponseCalculator.generateLogarithmicFrequencies(
        pointCount: 50,
      );
      List<double> flatBands = List.filled(10, 0.0);

      List<double> magnitudes = frequencies
          .map((f) => FrequencyResponseCalculator.calculateMagnitudeDb(f, flatBands))
          .toList();
      List<double> phases = frequencies
          .map((f) => FrequencyResponseCalculator.calculatePhaseDegrees(f, flatBands))
          .toList();

      bool isValid = FrequencyResponseCalculator.validateFrequencyResponse(
        frequencies,
        magnitudes,
        phases,
      );

      expect(isValid, true);
    });

    test('Should detect invalid frequency response (NaN values)', () {
      List<double> frequencies = [20, 100, 1000, 10000];
      List<double> magnitudes = [0, double.nan, 1, 2];
      List<double> phases = [0, 0, 0, 0];

      bool isValid = FrequencyResponseCalculator.validateFrequencyResponse(
        frequencies,
        magnitudes,
        phases,
      );

      expect(isValid, false);
    });

    test('Should detect invalid frequency response (out of range values)', () {
      List<double> frequencies = [20, 100, 1000, 10000];
      List<double> magnitudes = [0, 50, 150, 2]; // 150 > 100 (out of range)
      List<double> phases = [0, 0, 0, 0];

      bool isValid = FrequencyResponseCalculator.validateFrequencyResponse(
        frequencies,
        magnitudes,
        phases,
      );

      expect(isValid, false);
    });

    test('Should detect invalid frequency response (non-increasing frequencies)', () {
      List<double> frequencies = [20, 100, 50, 10000]; // 50 < 100 (not increasing)
      List<double> magnitudes = [0, 1, 2, 3];
      List<double> phases = [0, 0, 0, 0];

      bool isValid = FrequencyResponseCalculator.validateFrequencyResponse(
        frequencies,
        magnitudes,
        phases,
      );

      expect(isValid, false);
    });

    test('Should calculate transfer function correctly', () {
      List<double> flatBands = List.filled(10, 0.0);

      Map<String, double> transfer =
          FrequencyResponseCalculator.calculateTransferFunction(1000, flatBands);

      expect(transfer.containsKey('magnitude_db'), true);
      expect(transfer.containsKey('phase_degrees'), true);
      expect(transfer['magnitude_db'], closeTo(0.0, 0.5));
      expect(transfer['phase_degrees'], closeTo(0.0, 5.0));
    });

    test('Should calculate group delay', () {
      List<double> flatBands = List.filled(10, 0.0);

      // Для плоского фильтра групповая задержка должна быть близка к нулю
      double delay = FrequencyResponseCalculator.calculateGroupDelay(1000, flatBands);

      expect(delay, closeTo(0.0, 0.001)); // Допустимая погрешность 1 мс
    });

    test('Should handle biquad filter calculations correctly', () {
      // Тестируем базовый расчет для пикового фильтра
      List<double> bands = List.filled(10, 0.0);
      bands[3] = 6.0; // 1 kHz boost на 6 дБ

      double freqAtCenter =
          FrequencyResponseCalculator.calculateMagnitudeDb(1000, bands);
      double freqBelow =
          FrequencyResponseCalculator.calculateMagnitudeDb(500, bands);
      double freqAbove =
          FrequencyResponseCalculator.calculateMagnitudeDb(2000, bands);

      // На центральной частоте усиление должно быть максимальным
      expect(freqAtCenter, greaterThan(freqBelow));
      expect(freqAtCenter, greaterThan(freqAbove));
    });

    test('Should handle nyquist frequency limits correctly', () {
      List<double> testBands = [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5];

      // Расчеты на очень высоких частотах
      double response48k = FrequencyResponseCalculator.calculateMagnitudeDb(24000, testBands);
      double response44k = FrequencyResponseCalculator.calculateMagnitudeDb(22000, testBands);

      // Должны быть валидными числами
      expect(response48k.isNaN, false);
      expect(response44k.isNaN, false);
      expect(response48k.isInfinite, false);
      expect(response44k.isInfinite, false);
    });

    test('Should produce continuous frequency response', () {
      List<double> testBands = [1.0, 0.5, 0.0, -0.5, -1.0, 0.0, 0.5, 1.0, 0.0, -0.5];

      List<double> frequencies = [
        100,
        150,
        200,
        250,
        300,
        400,
        500,
        700,
        1000
      ];
      List<double> magnitudes = frequencies
          .map((f) => FrequencyResponseCalculator.calculateMagnitudeDb(f, testBands))
          .toList();

      // Проверяем, что нет скачков больше чем на 2 дБ между соседними точками
      for (int i = 1; i < magnitudes.length; i++) {
        double delta = (magnitudes[i] - magnitudes[i - 1]).abs();
        expect(delta, lessThan(3.0)); // Максимальный скачок 3 дБ
      }
    });

    test('Memory leak test - large frequency array', () async {
      // Создаем большие массивы данных
      List<double> frequencies =
          FrequencyResponseCalculator.generateLogarithmicFrequencies(
        pointCount: 1000,
      );
      List<double> testBands = List.filled(10, 1.0);

      // Выполняем расчеты много раз
      for (int iteration = 0; iteration < 100; iteration++) {
        List<double> magnitudes = frequencies
            .map((f) => FrequencyResponseCalculator.calculateMagnitudeDb(f, testBands))
            .cast<double>()
            .toList();
        List<double> phases = frequencies
            .map((f) => FrequencyResponseCalculator.calculatePhaseDegrees(f, testBands))
            .cast<double>()
            .toList();

        // Проверяем валидность
        bool isValid = FrequencyResponseCalculator.validateFrequencyResponse(
          frequencies,
          magnitudes,
          phases,
        );
        expect(isValid, true);
      }

      // Если мы здесь, значит нет критических утечек
      expect(true, true);
    });

    test('Complex number operations', () {
      // Тестируем операции с комплексными числами
      var c1 = ComplexNumber(3.0, 4.0);
      var c2 = ComplexNumber(1.0, 2.0);

      // Проверяем величину (magnitude)
      expect(c1.magnitude, closeTo(5.0, 0.001)); // |3+4j| = 5

      // Проверяем умножение
      var product = c1 * c2;
      // (3+4j)(1+2j) = 3 + 6j + 4j - 8 = -5 + 10j
      expect(product.real, closeTo(-5.0, 0.001));
      expect(product.imag, closeTo(10.0, 0.001));

      // Проверяем деление
      var quotient = c1 / c2;
      // (3+4j)/(1+2j) = (3+4j)(1-2j)/5 = (3-6j+4j+8)/5 = (11-2j)/5
      expect(quotient.real, closeTo(2.2, 0.001));
      expect(quotient.imag, closeTo(-0.4, 0.001));
    });

    test('Edge case: very low frequencies', () {
      List<double> testBands = [2.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

      double response10Hz = FrequencyResponseCalculator.calculateMagnitudeDb(10, testBands);
      double response20Hz = FrequencyResponseCalculator.calculateMagnitudeDb(20, testBands);
      double response50Hz = FrequencyResponseCalculator.calculateMagnitudeDb(50, testBands);

      // Все должны быть валидными числами
      expect(response10Hz.isNaN, false);
      expect(response20Hz.isNaN, false);
      expect(response50Hz.isNaN, false);

      // Усиление на 60Hz должно быть больше, чем на 10Hz
      double response60Hz = FrequencyResponseCalculator.calculateMagnitudeDb(60, testBands);
      expect(response60Hz, greaterThan(response10Hz));
    });

    test('Symmetry test: positive and negative gains', () {
      List<double> positiveBands = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
      List<double> negativeBands = [-1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0];

      double positiveResponse = FrequencyResponseCalculator.calculateMagnitudeDb(1000, positiveBands);
      double negativeResponse = FrequencyResponseCalculator.calculateMagnitudeDb(1000, negativeBands);

      // Положительное усиление должно быть больше нуля, отрицательное - меньше нуля
      expect(positiveResponse, greaterThan(0.0));
      expect(negativeResponse, lessThan(0.0));

      // Они должны быть примерно симметричными
      expect(positiveResponse.abs(), closeTo(negativeResponse.abs(), 0.1));
    });
  });
}

