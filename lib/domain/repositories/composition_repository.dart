import '../entities/composition_entity.dart';
import '../entities/result.dart';

/// Абстрактный репозиторий для работы с генерированными композициями
abstract class CompositionRepository {
  /// Генерирует новую композицию с помощью AI
  Future<Result<CompositionEntity>> generateComposition({
    required String genre,
    required Duration duration,
    String? apiKey,
    String? modelName,
  });

  /// Получает все сохраненные композиции
  Future<Result<List<CompositionEntity>>> getAllCompositions();

  /// Получает композицию по ID
  Future<Result<CompositionEntity>> getCompositionById(String id);

  /// Сохраняет композицию
  Future<Result<void>> saveComposition(CompositionEntity composition);

  /// Удаляет композицию
  Future<Result<void>> deleteComposition(String id);

  /// Получает композиции по жанру
  Future<Result<List<CompositionEntity>>> getCompositionsByGenre(String genre);

  /// Получает историю сгенерированных композиций
  Future<Result<List<CompositionEntity>>> getGenerationHistory({int limit = 50});

  /// Проверяет доступность AI API
  Future<Result<bool>> isAIApiAvailable();
}

