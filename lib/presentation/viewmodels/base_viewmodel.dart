import 'package:flutter/foundation.dart';
import 'package:new_fly_mixxxx/core/utils/logger.dart';
import 'package:new_fly_mixxxx/domain/entities/result.dart';

/// Состояния ViewModel
enum ViewModelState {
  idle,
  loading,
  success,
  error,
}

/// Базовый класс для всех ViewModel
abstract class BaseViewModel extends ChangeNotifier {
  ViewModelState _state = ViewModelState.idle;
  String? _errorMessage;
  String? _errorCode;

  // Getters
  ViewModelState get state => _state;
  String? get errorMessage => _errorMessage;
  String? get errorCode => _errorCode;

  bool get isLoading => _state == ViewModelState.loading;
  bool get isError => _state == ViewModelState.error;
  bool get isSuccess => _state == ViewModelState.success;
  bool get isIdle => _state == ViewModelState.idle;

  /// Устанавливает состояние загрузки
  void setLoading() {
    _state = ViewModelState.loading;
    _errorMessage = null;
    _errorCode = null;
    notifyListeners();
  }

  /// Устанавливает состояние успеха
  void setSuccess() {
    _state = ViewModelState.success;
    _errorMessage = null;
    _errorCode = null;
    notifyListeners();
  }

  /// Устанавливает состояние ошибки
  void setError(String message, {String? code}) {
    _state = ViewModelState.error;
    _errorMessage = message;
    _errorCode = code;
    notifyListeners();
  }

  /// Устанавливает состояние ожидания
  void setIdle() {
    _state = ViewModelState.idle;
    _errorMessage = null;
    _errorCode = null;
    notifyListeners();
  }

  /// Обрабатывает Result и устанавливает состояние
  void handleResult<T>(
    Result<T> result, {
    Function(T data)? onSuccess,
    Function(String message, String? code)? onError,
  }) {
    result.fold(
      (failure) {
        setError(failure.message, code: failure.code);
        onError?.call(failure.message, failure.code);
      },
      (data) {
        setSuccess();
        onSuccess?.call(data);
      },
    );
  }

  /// Логирует сообщение
  void log(String message) {
    Logger.info(message, tag: runtimeType.toString());
  }

  /// Логирует ошибку
  void logError(String message, {dynamic error}) {
    Logger.error(message, tag: runtimeType.toString(), error: error);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

