import '../entities/track_entity.dart';
import '../entities/result.dart';

/// Абстрактный репозиторий для работы с треками
abstract class TrackRepository {
  /// Загружает трек из файла
  Future<Result<TrackEntity>> loadTrackFromFile(String filePath);

  /// Получает все загруженные треки
  Future<Result<List<TrackEntity>>> getAllTracks();

  /// Сохраняет трек в локальное хранилище
  Future<Result<void>> saveTrack(TrackEntity track);

  /// Удаляет трек
  Future<Result<void>> deleteTrack(String trackId);

  /// Получает трек по ID
  Future<Result<TrackEntity>> getTrackById(String trackId);

  /// Поиск треков по названию
  Future<Result<List<TrackEntity>>> searchTracks(String query);

  /// Получает недавно добавленные треки
  Future<Result<List<TrackEntity>>> getRecentTracks({int limit = 10});
}

