import 'app_exception.dart';

/// Исключения, связанные с аудиообработкой
class AudioException extends AppException {
  AudioException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
  );

  factory AudioException.playerNotInitialized() => AudioException(
    message: 'Audio player not initialized',
    code: 'PLAYER_NOT_INITIALIZED',
  );

  factory AudioException.trackLoadFailed(String trackName) => AudioException(
    message: 'Failed to load track: $trackName',
    code: 'TRACK_LOAD_FAILED',
  );

  factory AudioException.playbackFailed(String details) => AudioException(
    message: 'Playback failed: $details',
    code: 'PLAYBACK_FAILED',
  );

  factory AudioException.invalidFormat(String format) => AudioException(
    message: 'Invalid audio format: $format',
    code: 'INVALID_FORMAT',
  );

  factory AudioException.fileSizeTooLarge(int sizeMB, int maxSizeMB) => AudioException(
    message: 'File size ($sizeMB MB) exceeds maximum ($maxSizeMB MB)',
    code: 'FILE_SIZE_EXCEEDED',
  );

  factory AudioException.queueFull(int maxSize) => AudioException(
    message: 'Queue is full (max $maxSize tracks)',
    code: 'QUEUE_FULL',
  );

  factory AudioException.noActivePlayer() => AudioException(
    message: 'No active audio player',
    code: 'NO_ACTIVE_PLAYER',
  );
}

