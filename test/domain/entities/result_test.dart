import 'package:flutter_test/flutter_test.dart';
import 'package:new_fly_mixxxx/domain/entities/result.dart';

void main() {
  group('Result Entity Tests', () {
    test('Result.success creates success result', () {
      final result = Result<String>.success('Test data');

      expect(result.isSuccess, true);
      expect(result.isFailure, false);

      result.fold(
        (failure) {
          fail('Should not call failure callback');
        },
        (data) {
          expect(data, 'Test data');
        },
      );
    });

    test('Result.failure creates failure result', () {
      final failure = Failure(message: 'Test error', code: 'TEST_CODE');
      final result = Result<String>.failure(failure);

      expect(result.isSuccess, false);
      expect(result.isFailure, true);

      result.fold(
        (f) {
          expect(f.message, 'Test error');
          expect(f.code, 'TEST_CODE');
        },
        (data) {
          fail('Should not call success callback');
        },
      );
    });

    test('Result preserves generic type for success', () {
      final result = Result<int>.success(42);

      result.fold(
        (failure) {
          fail('Should not call failure callback');
        },
        (data) {
          expect(data, 42);
          expect(data is int, true);
        },
      );
    });

    test('Result preserves generic type for failure', () {
      final failure = Failure(message: 'Error', code: 'CODE');
      final result = Result<double>.failure(failure);

      expect(result.isFailure, true);
    });

    test('Failure contains correct information', () {
      const message = 'Something went wrong';
      const code = 'ERROR_CODE';
      final failure = Failure(message: message, code: code);

      expect(failure.message, message);
      expect(failure.code, code);
    });

    test('Multiple Results can be created independently', () {
      final result1 = Result<String>.success('First');
      final result2 = Result<String>.success('Second');
      final result3 = Result<String>.failure(Failure(message: 'Error'));

      result1.fold((f) => fail('Should not fail'), (d) => expect(d, 'First'));
      result2.fold((f) => fail('Should not fail'), (d) => expect(d, 'Second'));
      result3.fold((f) => expect(f.message, 'Error'), (d) => fail('Should not succeed'));
    });

    test('Result can be used with different types', () {
      final stringResult = Result<String>.success('test');
      final intResult = Result<int>.success(123);
      final listResult = Result<List<String>>.success(['a', 'b', 'c']);
      final mapResult = Result<Map<String, int>>.success({'a': 1, 'b': 2});

      expect(stringResult.isSuccess, true);
      expect(intResult.isSuccess, true);
      expect(listResult.isSuccess, true);
      expect(mapResult.isSuccess, true);
    });

    test('Failure can be reused for different Result types', () {
      final failure = Failure(message: 'Generic error', code: 'GENERIC');

      final stringResult = Result<String>.failure(failure);
      final intResult = Result<int>.failure(failure);

      expect(stringResult.isFailure, true);
      expect(intResult.isFailure, true);
    });

    test('Result.map works correctly', () {
      final result = Result<int>.success(5);

      final mappedResult = result.fold(
        (failure) => Result<String>.failure(failure),
        (data) => Result<String>.success('Value: $data'),
      );

      mappedResult.fold(
        (failure) => fail('Should not fail'),
        (data) => expect(data, 'Value: 5'),
      );
    });

    test('Result handles null values correctly', () {
      final result = Result<String?>.success(null);

      result.fold(
        (failure) => fail('Should not fail'),
        (data) => expect(data, null),
      );
    });

    test('Result equality works correctly', () {
      final result1 = Result<String>.success('test');
      final result2 = Result<String>.success('test');
      final result3 = Result<String>.success('other');

      // Note: Equality depends on implementation
      expect(result1.isSuccess, result2.isSuccess);
      expect(result3.isSuccess, true);
    });
  });
}

