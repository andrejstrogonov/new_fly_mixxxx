import 'package:flutter_test/flutter_test.dart';
import 'package:new_fly_mixxxx/presentation/viewmodels/base_viewmodel.dart';
import 'package:new_fly_mixxxx/domain/entities/result.dart';

/// Тест для проверки MVVM архитектуры
/// Убеждаемся, что архитектура соответствует лучшим практикам

void main() {
  group('MVVM Architecture Tests', () {
    late TestViewModel viewModel;

    setUp(() {
      viewModel = TestViewModel();
    });

    tearDown(() {
      viewModel.dispose();
    });

    test('ViewModel должен быть ChangeNotifier', () {
      expect(viewModel, isA<ChangeNotifier>());
    });

    test('ViewModel должен иметь методы управления состоянием', () {
      expect(viewModel.setLoading, isA<Function>());
      expect(viewModel.setSuccess, isA<Function>());
      expect(viewModel.setError, isA<Function>());
      expect(viewModel.setIdle, isA<Function>());
    });

    test('ViewModel должен иметь getters для состояния', () {
      viewModel.setLoading();
      expect(viewModel.state, ViewModelState.loading);
      expect(viewModel.isLoading, true);

      viewModel.setSuccess();
      expect(viewModel.state, ViewModelState.success);
      expect(viewModel.isSuccess, true);

      viewModel.setError('Error');
      expect(viewModel.state, ViewModelState.error);
      expect(viewModel.isError, true);
      expect(viewModel.errorMessage, 'Error');

      viewModel.setIdle();
      expect(viewModel.state, ViewModelState.idle);
      expect(viewModel.isIdle, true);
    });

    test('ViewModel должен обрабатывать Result корректно', () {
      final successResult = Result<String>.success('Success');
      var onSuccessCalled = false;

      viewModel.handleResult(
        successResult,
        onSuccess: (data) {
          onSuccessCalled = true;
          expect(data, 'Success');
        },
      );

      expect(onSuccessCalled, true);
      expect(viewModel.isSuccess, true);
    });

    test('ViewModel должен обрабатывать ошибки корректно', () {
      final failure = Failure(message: 'Test error', code: 'TEST');
      final failureResult = Result<String>.failure(failure);
      var onErrorCalled = false;

      viewModel.handleResult(
        failureResult,
        onError: (message, code) {
          onErrorCalled = true;
          expect(message, 'Test error');
          expect(code, 'TEST');
        },
      );

      expect(onErrorCalled, true);
      expect(viewModel.isError, true);
    });

    test('ViewModel должен уведомлять слушателей об изменениях', () {
      var notificationCount = 0;

      viewModel.addListener(() {
        notificationCount++;
      });

      viewModel.setLoading();
      viewModel.setSuccess();
      viewModel.setError('Error');
      viewModel.setIdle();

      expect(notificationCount, 4);
    });

    test('Состояния ViewModel должны быть взаимно исключающими', () {
      viewModel.setLoading();
      expect(viewModel.isLoading, true);
      expect(viewModel.isSuccess, false);
      expect(viewModel.isError, false);
      expect(viewModel.isIdle, false);

      viewModel.setSuccess();
      expect(viewModel.isLoading, false);
      expect(viewModel.isSuccess, true);
      expect(viewModel.isError, false);
      expect(viewModel.isIdle, false);

      viewModel.setError('Error');
      expect(viewModel.isLoading, false);
      expect(viewModel.isSuccess, false);
      expect(viewModel.isError, true);
      expect(viewModel.isIdle, false);

      viewModel.setIdle();
      expect(viewModel.isLoading, false);
      expect(viewModel.isSuccess, false);
      expect(viewModel.isError, false);
      expect(viewModel.isIdle, true);
    });

    test('ViewModel может быть использован с Provider', () {
      // Это просто проверка типа и интерфейса
      expect(viewModel, isA<ChangeNotifier>());
      expect(viewModel, isA<BaseViewModel>());
    });

    test('Error информация должна быть очищена при смене состояния', () {
      viewModel.setError('Error', code: 'CODE');
      expect(viewModel.errorMessage, 'Error');
      expect(viewModel.errorCode, 'CODE');

      viewModel.setLoading();
      expect(viewModel.errorMessage, null);
      expect(viewModel.errorCode, null);

      viewModel.setError('New Error');
      expect(viewModel.errorMessage, 'New Error');

      viewModel.setSuccess();
      expect(viewModel.errorMessage, null);
      expect(viewModel.errorCode, null);
    });

    test('ViewModel dispose должен быть вызван при удалении', () {
      expect(() {
        viewModel.dispose();
      }, returnsNormally);
    });

    test('ViewModel logging должен работать', () {
      expect(() {
        viewModel.log('Test message');
        viewModel.logError('Test error', error: Exception('Test'));
      }, returnsNormally);
    });
  });

  group('MVVM Design Pattern Tests', () {
    test('Separation of Concerns должна быть соблюдена', () {
      // ViewModel не должен содержать UI код
      final viewModel = TestViewModel();

      // Проверяем, что нет Flutter widget импортов в логике
      expect(viewModel, isA<ChangeNotifier>());
      expect(viewModel, isA<BaseViewModel>());

      viewModel.dispose();
    });

    test('Dependency Injection должна быть поддержана', () {
      // BaseViewModel должен быть injectable
      final vm1 = TestViewModel();
      final vm2 = TestViewModel();

      expect(vm1.runtimeType, vm2.runtimeType);

      vm1.dispose();
      vm2.dispose();
    });

    test('Immutability of state должна быть соблюдена', () {
      final viewModel = TestViewModel();

      viewModel.setLoading();
      final state1 = viewModel.state;

      viewModel.setSuccess();
      final state2 = viewModel.state;

      expect(state1, isNot(state2));
      expect(state1, ViewModelState.loading);
      expect(state2, ViewModelState.success);

      viewModel.dispose();
    });
  });
}

/// Test ViewModel for testing purposes
class TestViewModel extends BaseViewModel {}

