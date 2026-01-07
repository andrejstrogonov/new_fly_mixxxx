import '../entities/track_entity.dart';
import '../entities/result.dart';

/// Абстрактный репозиторий для работы с аудиоплеером
abstract class AudioRepository {
  /// Загружает трек в плеер
  Future<Result<void>> loadTrack(TrackEntity track, {required int playerNumber});

  /// Начинает воспроизведение
  Future<Result<void>> play({required int playerNumber});

  /// Ставит на паузу
  Future<Result<void>> pause({required int playerNumber});

  /// Останавливает плеер
  Future<Result<void>> stop({required int playerNumber});

  /// Ищет позицию в треке
  Future<Result<void>> seek(Duration position, {required int playerNumber});

  /// Получает текущую позицию
  Future<Result<Duration>> getCurrentPosition({required int playerNumber});

  /// Получает длительность трека
  Future<Result<Duration>> getDuration({required int playerNumber});

  /// Проверяет, играет ли трек
  Future<Result<bool>> isPlaying({required int playerNumber});

  /// Устанавливает громкость
  Future<Result<void>> setVolume(double volume, {required int playerNumber});

  /// Получает громкость
  Future<Result<double>> getVolume({required int playerNumber});

  /// Устанавливает мастер громкость
  Future<Result<void>> setMasterVolume(double volume);

  /// Инициализирует плеер
  Future<Result<void>> initialize();

  /// Освобождает ресурсы плеера
  Future<Result<void>> dispose();
}

