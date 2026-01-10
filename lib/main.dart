import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/mixer_screen.dart';
import 'providers/audio_provider.dart';
import 'core/utils/logger.dart';
import 'core/constants/ui_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.setLogLevel(LogLevel.info);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AudioProvider(),
      child: MaterialApp(
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
      ),
    );
  }
}
