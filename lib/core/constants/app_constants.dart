/// Основные константы приложения
class AppConstants {
  // App Info
  static const String appName = 'Fly Mixxx - DJ Mixer';
  static const String appVersion = '1.0.0';

  // Timeouts (в миллисекундах)
  static const int connectionTimeout = 10000;
  static const int receiveTimeout = 10000;
  static const int audioLoadTimeout = 30000;

  // Queue
  static const int maxQueueSize = 4;
  static const int maxTrackNameLength = 100;

  // Common durations
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration shortDuration = Duration(milliseconds: 100);
  static const Duration mediumDuration = Duration(milliseconds: 500);
}

