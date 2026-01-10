import 'package:get_it/get_it.dart';
import '../core/utils/logger.dart';
import '../presentation/viewmodels/mixer_viewmodel.dart';

class ServiceLocator {
  static final GetIt _getIt = GetIt.instance;

  static Future<void> init() async {
    Logger.info('Initializing ServiceLocator...');

    try {
      Logger.setLogLevel(LogLevel.info);

      // Register ViewModels
      _getIt.registerLazySingleton<MixerViewModel>(
        () => MixerViewModel(),
      );

      Logger.info('ServiceLocator initialized successfully');
    } catch (e) {
      Logger.error('Failed to initialize ServiceLocator', error: e);
      rethrow;
    }
  }

  static T get<T extends Object>() {
    try {
      return _getIt.get<T>();
    } catch (e) {
      Logger.error('Failed to get instance of $T', error: e);
      rethrow;
    }
  }

  static void registerSingleton<T extends Object>(T instance) {
    _getIt.registerSingleton<T>(instance);
  }

  static void registerLazySingleton<T extends Object>(
    T Function() factoryFunc,
  ) {
    _getIt.registerLazySingleton<T>(factoryFunc);
  }

  static Future<void> reset() async {
    await _getIt.reset();
    Logger.info('ServiceLocator reset');
  }
}

