import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/mixer_screen.dart';
import 'services/service_locator.dart';
import 'core/utils/logger.dart';
import 'core/constants/ui_constants.dart';

void main() async {
  // Инициализируем loggerирование
  Logger.setLogLevel(LogLevel.info);

  // Инициализируем Service Locator (Dependency Injection)
  await ServiceLocator.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fly Mixxx - DJ Mixer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: UIConstants.backgroundColor,
      ),
      home: const MixerScreen(),
    );
  }
}
