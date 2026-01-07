import '../entities/audio_device_entity.dart';
import '../entities/frequency_response_entity.dart';
import '../entities/result.dart';

/// Абстрактный репозиторий для анализа аудиооборудования
abstract class DeviceAnalyzerRepository {
  /// Получает список всех активных аудиоустройств
  Future<Result<List<AudioDeviceEntity>>> getActiveDevices();

  /// Получает информацию о выходном устройстве
  Future<Result<AudioDeviceEntity>> getOutputDevice();

  /// Получает информацию о входном устройстве
  Future<Result<AudioDeviceEntity>> getInputDevice();

  /// Анализирует частотную характеристику устройства
  Future<Result<FrequencyResponseEntity>> analyzeDeviceFrequencyResponse();

  /// Получает уровень входного сигнала
  Future<Result<double>> getInputLevel();

  /// Получает уровень выходного сигнала
  Future<Result<double>> getOutputLevel();

  /// Проверяет, поддерживает ли устройство 5.1 сурround
  Future<Result<bool>> supportsSurroundSound();

  /// Получает информацию об устройстве
  Future<Result<Map<String, dynamic>>> getDeviceInfo();

  /// Начинает мониторинг уровней сигнала
  Future<Result<void>> startLevelMonitoring();

  /// Останавливает мониторинг уровней сигнала
  Future<Result<void>> stopLevelMonitoring();
}

