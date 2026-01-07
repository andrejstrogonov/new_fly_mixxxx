import '../entities/frequency_response_entity.dart';
import '../entities/result.dart';

/// Абстрактный репозиторий для расчета частотной характеристики
abstract class FrequencyResponseRepository {
  /// Вычисляет АЧХ (Амплитудно-Частотная Характеристика)
  Future<Result<FrequencyResponseEntity>> calculateMagnitudeResponse({
    required List<double> eqBands,
    int points = 100,
  });

  /// Вычисляет ФЧХ (Фазо-Частотную Характеристику)
  Future<Result<FrequencyResponseEntity>> calculatePhaseResponse({
    required List<double> eqBands,
    int points = 100,
  });

  /// Вычисляет диаграмму Боде (АЧХ + ФЧХ)
  Future<Result<FrequencyResponseEntity>> calculateBodeResponse({
    required List<double> eqBands,
    int points = 100,
  });

  /// Анализирует частотный спектр входящего сигнала
  Future<Result<FrequencyResponseEntity>> analyzeInputSpectrum({
    int sampleCount = 1024,
  });

  /// Экспортирует данные в CSV формат
  Future<Result<String>> exportToCSV(FrequencyResponseEntity response);

  /// Получает информацию о пиках в частотной характеристике
  Future<Result<List<Map<String, dynamic>>>> getPeakInfo(FrequencyResponseEntity response);
}

