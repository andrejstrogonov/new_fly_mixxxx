import 'package:flutter_test/flutter_test.dart';
import 'package:new_fly_mixxxx/presentation/viewmodels/base_viewmodel.dart';
import 'package:new_fly_mixxxx/domain/entities/result.dart';

// Mock ViewModel для тестирования
class TestViewModel extends BaseViewModel {}

void main() {
  group('BaseViewModel Tests', () {
    late TestViewModel viewModel;

    setUp(() {
      viewModel = TestViewModel();
    });

    tearDown(() {
      viewModel.dispose();
    });

    test('初期状態はidleである', () {
      expect(viewModel.state, ViewModelState.idle);
      expect(viewModel.isIdle, true);
      expect(viewModel.errorMessage, null);
      expect(viewModel.errorCode, null);
    });

    test('setLoading sets loading state correctly', () {
      viewModel.setLoading();
      expect(viewModel.state, ViewModelState.loading);
      expect(viewModel.isLoading, true);
      expect(viewModel.isError, false);
    });

    test('setSuccess sets success state correctly', () {
      viewModel.setSuccess();
      expect(viewModel.state, ViewModelState.success);
      expect(viewModel.isSuccess, true);
      expect(viewModel.errorMessage, null);
    });

    test('setError sets error state with message and code', () {
      const errorMsg = 'Test error';
      const errorCode = 'TEST_CODE';
      viewModel.setError(errorMsg, code: errorCode);

      expect(viewModel.state, ViewModelState.error);
      expect(viewModel.isError, true);
      expect(viewModel.errorMessage, errorMsg);
      expect(viewModel.errorCode, errorCode);
    });

    test('setIdle sets idle state correctly', () {
      viewModel.setLoading();
      viewModel.setIdle();

      expect(viewModel.state, ViewModelState.idle);
      expect(viewModel.isIdle, true);
      expect(viewModel.errorMessage, null);
    });

    test('State transitions work correctly', () {
      // idle -> loading
      viewModel.setLoading();
      expect(viewModel.isLoading, true);

      // loading -> success
      viewModel.setSuccess();
      expect(viewModel.isSuccess, true);

      // success -> idle
      viewModel.setIdle();
      expect(viewModel.isIdle, true);
    });

    test('notifyListeners is called on state change', () {
      var notifyCount = 0;
      viewModel.addListener(() {
        notifyCount++;
      });

      viewModel.setLoading();
      expect(notifyCount, 1);

      viewModel.setSuccess();
      expect(notifyCount, 2);

      viewModel.setError('Error');
      expect(notifyCount, 3);
    });

    group('handleResult tests', () {
      test('handleResult calls onSuccess for success result', () {
        var successCalled = false;
        var errorCalled = false;

        final result = Result<String>.success('Success data');

        viewModel.handleResult(
          result,
          onSuccess: (data) {
            successCalled = true;
            expect(data, 'Success data');
          },
          onError: (message, code) {
            errorCalled = true;
          },
        );

        expect(successCalled, true);
        expect(errorCalled, false);
        expect(viewModel.isSuccess, true);
      });

      test('handleResult calls onError for failure result', () {
        var successCalled = false;
        var errorCalled = false;

        final result = Result<String>.failure(
          Failure(message: 'Test error', code: 'TEST'),
        );

        viewModel.handleResult(
          result,
          onSuccess: (data) {
            successCalled = true;
          },
          onError: (message, code) {
            errorCalled = true;
            expect(message, 'Test error');
            expect(code, 'TEST');
          },
        );

        expect(successCalled, false);
        expect(errorCalled, true);
        expect(viewModel.isError, true);
      });

      test('handleResult works without callbacks', () {
        final result = Result<String>.success('Success data');

        expect(() {
          viewModel.handleResult(result);
        }, returnsNormally);

        expect(viewModel.isSuccess, true);
      });
    });
  });
}

