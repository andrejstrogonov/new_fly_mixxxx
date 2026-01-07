import 'app_exception.dart';

/// Исключения, связанные с файлами
class FileException extends AppException {
  FileException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
  );

  factory FileException.fileNotFound(String fileName) => FileException(
    message: 'File not found: $fileName',
    code: 'FILE_NOT_FOUND',
  );

  factory FileException.permissionDenied(String fileName) => FileException(
    message: 'Permission denied for: $fileName',
    code: 'PERMISSION_DENIED',
  );

  factory FileException.readError(String fileName) => FileException(
    message: 'Failed to read file: $fileName',
    code: 'READ_ERROR',
  );

  factory FileException.writeError(String fileName) => FileException(
    message: 'Failed to write file: $fileName',
    code: 'WRITE_ERROR',
  );

  factory FileException.invalidPath(String path) => FileException(
    message: 'Invalid file path: $path',
    code: 'INVALID_PATH',
  );
}

