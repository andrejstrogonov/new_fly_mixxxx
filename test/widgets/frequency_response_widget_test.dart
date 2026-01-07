import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_fly_mixxxx/widgets/frequency_response_widget.dart';
import 'package:new_fly_mixxxx/providers/audio_provider.dart';

class MockAudioProvider extends ChangeNotifier {
  @override
  List<double> calculateFrequencyResponse(List<int> frequencies) {
    // Возвращаем mock данные: от -3 до +3 дБ
    return List.generate(frequencies.length, (i) {
      return ((i - frequencies.length / 2) / frequencies.length) * 6 - 3;
    });
  }

  @override
  List<double> calculatePhaseResponse(List<int> frequencies) {
    // Возвращаем mock данные: от -180 до +180 градусов
    return List.generate(frequencies.length, (i) {
      return ((i / frequencies.length) * 360) - 180;
    });
  }
}

void main() {
  group('FrequencyResponseWidget Tests', () {
    testWidgets('FrequencyResponseWidget renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MockAudioProvider>(
              create: (_) => MockAudioProvider(),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: FrequencyResponseWidget(),
            ),
          ),
        ),
      );

      expect(find.byType(FrequencyResponseWidget), findsOneWidget);
      expect(
        find.text('Frequency Response (АЧХ & ФЧХ & Диаграмма Боде)'),
        findsOneWidget,
      );
    });

    testWidgets('FrequencyResponseWidget has TabBar',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MockAudioProvider>(
              create: (_) => MockAudioProvider(),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: FrequencyResponseWidget(),
            ),
          ),
        ),
      );

      expect(find.byType(TabBar), findsOneWidget);
      expect(find.byType(Tab), findsNWidgets(3));
    });

    testWidgets('FrequencyResponseWidget TabBar tabs have correct titles',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MockAudioProvider>(
              create: (_) => MockAudioProvider(),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: FrequencyResponseWidget(),
            ),
          ),
        ),
      );

      expect(find.text('АЧХ (Амплитуда)'), findsOneWidget);
      expect(find.text('ФЧХ (Фаза)'), findsOneWidget);
      expect(find.text('Диаграмма Боде'), findsOneWidget);
    });

    testWidgets('FrequencyResponseWidget can switch tabs',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MockAudioProvider>(
              create: (_) => MockAudioProvider(),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: FrequencyResponseWidget(),
            ),
          ),
        ),
      );

      // Tap на вторую вкладку
      await tester.tap(find.text('ФЧХ (Фаза)'));
      await tester.pumpAndSettle();

      expect(find.text('Phase Frequency Response (ФЧХ)'), findsOneWidget);
    });

    testWidgets('FrequencyResponseWidget displays all three charts',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MockAudioProvider>(
              create: (_) => MockAudioProvider(),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: FrequencyResponseWidget(),
              ),
            ),
          ),
        ),
      );

      // Проверяем наличие текстов диаграмм
      expect(find.text('Amplitude Frequency Response (АЧХ)'), findsOneWidget);
      expect(find.text('Phase Frequency Response (ФЧХ)'), findsOneWidget);
    });
  });
}

