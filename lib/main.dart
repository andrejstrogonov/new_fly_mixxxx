import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/mixer_screen.dart';
import 'providers/audio_provider.dart';
import 'providers/audio_device_analyzer.dart';
import 'providers/composition_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioProvider()),
        ChangeNotifierProvider(create: (_) => AudioDeviceAnalyzer()),
        ChangeNotifierProvider(create: (_) => CompositionGeneratorProvider()),
      ],
      child: MaterialApp(
        title: 'Fly Mixxx - DJ Mixer',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFF1a1a1a),
        ),
        home: const MixerScreen(),
      ),
    );
  }
}
