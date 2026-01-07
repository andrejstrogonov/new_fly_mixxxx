import '../entities/eq_preset_entity.dart';
import '../entities/frequency_response_entity.dart';
import '../entities/result.dart';

/// Абстрактный репозиторий для работы с эквалайзером
abstract class EqualizerRepository {
  /// Получает все доступные пресеты
  Future<Result<List<EQPresetEntity>>> getAllPresets();

  /// Получает пресет по названию
  Future<Result<EQPresetEntity>> getPresetByName(String name);

  /// Сохраняет новый пресет
  Future<Result<void>> saveCustomPreset(EQPresetEntity preset);

  /// Удаляет пресет (только кастомные)
  Future<Result<void>> deleteCustomPreset(String presetName);

  /// Применяет пресет
  Future<Result<void>> applyPreset(EQPresetEntity preset);

  /// Регулирует конкретную полосу EQ
  Future<Result<void>> adjustBand(int bandIndex, double gain);

  /// Получает текущие значения EQ
  Future<Result<List<double>>> getCurrentEQValues();

  /// Вычисляет частотную характеристику на основе текущих значений EQ
  Future<Result<FrequencyResponseEntity>> calculateFrequencyResponse();

  /// Сбрасывает EQ на плоский (Flat)
  Future<Result<void>> resetToFlat();
}

