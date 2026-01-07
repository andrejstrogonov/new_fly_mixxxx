import 'package:equatable/equatable.dart';

/// Результат выполнения операции
abstract class Result<T> extends Equatable {
  const Result();

  /// Выполняет функцию в зависимости от типа результата
  R fold<R>(R Function(Failure) onFailure, R Function(T) onSuccess);
}

/// Успешный результат
class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);

  @override
  List<Object?> get props => [data];

  @override
  R fold<R>(R Function(Failure) onFailure, R Function(T) onSuccess) {
    return onSuccess(data);
  }
}

/// Неудачный результат
class Failure extends Result<Never> {
  final String message;
  final String? code;
  final dynamic originalException;

  const Failure({
    required this.message,
    this.code,
    this.originalException,
  });

  @override
  List<Object?> get props => [message, code];

  @override
  R fold<R>(R Function(Failure) onFailure, R Function(Never) onSuccess) {
    return onFailure(this);
  }

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

