import 'app_exception.dart';

/// Исключения валидации
class ValidationException extends AppException {
  ValidationException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
  );

  factory ValidationException.invalidInput(String fieldName, String reason) => ValidationException(
    message: 'Invalid $fieldName: $reason',
    code: 'INVALID_INPUT',
  );

  factory ValidationException.requiredFieldEmpty(String fieldName) => ValidationException(
    message: '$fieldName is required',
    code: 'REQUIRED_FIELD_EMPTY',
  );

  factory ValidationException.invalidRange(String fieldName, dynamic min, dynamic max) =>
    ValidationException(
      message: '$fieldName must be between $min and $max',
      code: 'INVALID_RANGE',
    );

  factory ValidationException.invalidFormat(String fieldName, String expectedFormat) =>
    ValidationException(
      message: '$fieldName has invalid format. Expected: $expectedFormat',
      code: 'INVALID_FORMAT',
    );
}

