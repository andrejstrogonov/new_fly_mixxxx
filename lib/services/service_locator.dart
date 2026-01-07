import 'package:get_it/get_it.dart';
import '../core/utils/logger.dart';
import '../domain/repositories/audio_repository.dart';
import '../domain/repositories/track_repository.dart';
import '../domain/repositories/equalizer_repository.dart';
import '../domain/repositories/composition_repository.dart';
import '../domain/repositories/device_analyzer_repository.dart';
import '../domain/repositories/frequency_response_repository.dart';
import '../domain/usecases/audio/load_track_usecase.dart';
import '../domain/usecases/audio/play_audio_usecase.dart';
import '../domain/usecases/audio/pause_audio_usecase.dart';
import '../domain/usecases/audio/stop_audio_usecase.dart';
import '../domain/usecases/audio/seek_audio_usecase.dart';

/// Service Locator для управления зависимостями (Dependency Injection)
class ServiceLocator {
  static final GetIt _getIt = GetIt.instance;

  static Future<void> init() async {
    Logger.info('Initializing ServiceLocator...');

    try {
      // 1. Инициализируем логирование
      Logger.setLogLevel(LogLevel.info);

      // 2. Регистрируем Repository (обычно это MockRepository или HttpRepository)
      // TODO: Заменить на реальные реализации
      // _getIt.registerSingleton<AudioRepository>(AudioRepositoryImpl(...));
      // _getIt.registerSingleton<TrackRepository>(TrackRepositoryImpl(...));
      // _getIt.registerSingleton<EqualizerRepository>(EqualizerRepositoryImpl(...));
      // _getIt.registerSingleton<CompositionRepository>(CompositionRepositoryImpl(...));
      // _getIt.registerSingleton<DeviceAnalyzerRepository>(DeviceAnalyzerRepositoryImpl(...));
      // _getIt.registerSingleton<FrequencyResponseRepository>(FrequencyResponseRepositoryImpl(...));

      // 3. Регистрируем UseCase
      // _getIt.registerSingleton<LoadTrackUseCase>(
      //   LoadTrackUseCase(audioRepository: _getIt<AudioRepository>()),
      // );
      // _getIt.registerSingleton<PlayAudioUseCase>(
      //   PlayAudioUseCase(audioRepository: _getIt<AudioRepository>()),
      // );
      // _getIt.registerSingleton<PauseAudioUseCase>(
      //   PauseAudioUseCase(audioRepository: _getIt<AudioRepository>()),
      // );
      // _getIt.registerSingleton<StopAudioUseCase>(
      //   StopAudioUseCase(audioRepository: _getIt<AudioRepository>()),
      // );
      // _getIt.registerSingleton<SeekAudioUseCase>(
      //   SeekAudioUseCase(audioRepository: _getIt<AudioRepository>()),
      // );

      // 4. Регистрируем ViewModel (позже, когда создадим)
      // _getIt.registerSingleton<AudioViewModel>(...);

      Logger.info('ServiceLocator initialized successfully');
    } catch (e) {
      Logger.error('Failed to initialize ServiceLocator', error: e);
      rethrow;
    }
  }

  /// Получает инстанс сервиса по типу
  static T get<T extends Object>() {
    try {
      return _getIt.get<T>();
    } catch (e) {
      Logger.error('Failed to get instance of $T', error: e);
      rethrow;
    }
  }

  /// Регистрирует синглтон
  static void registerSingleton<T extends Object>(T instance) {
    _getIt.registerSingleton<T>(instance);
  }

  /// Регистрирует lazySingleton (создается только при первом использовании)
  static void registerLazySingleton<T extends Object>(
    T Function() factoryFunc,
  ) {
    _getIt.registerLazySingleton<T>(factoryFunc);
  }

  /// Очищает все зарегистрированные зависимости
  static Future<void> reset() async {
    await _getIt.reset();
    Logger.info('ServiceLocator reset');
  }
}

