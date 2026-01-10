import '../entities/result.dart';

abstract class UseCaseParams {
  const UseCaseParams();
}

class NoParams extends UseCaseParams {
  const NoParams();
}

abstract class UseCase<Type, Params extends UseCaseParams> {
  Future<Result<Type>> call(Params params);
}

abstract class UseCaseNoParams<Type> {
  Future<Result<Type>> call();
}
