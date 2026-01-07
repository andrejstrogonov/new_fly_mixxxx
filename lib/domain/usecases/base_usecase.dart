import '../entities/result.dart';

/// Параметры для UseCase (если нужны)
abstract class UseCaseParams {
  const UseCaseParams();
}

/// Параметры "нет параметров"
class NoParams extends UseCaseParams {
  const NoParams();
}

/// Базовый класс для всех UseCase
abstract class UseCase<Type, Params> {
  /// Выполняет бизнес-логику UseCase
  /// Возвращает Result<Type> для правильной обработки ошибок
  Future<Result<Type>> call(Params params);
}

/// UseCase без параметров
abstract class UseCaseNoParams<Type> extends UseCase<Type, NoParams> {
  @override
  Future<Result<Type>> call(NoParams params);
}

