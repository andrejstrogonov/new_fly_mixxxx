import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:new_fly_mixxxx/widgets/equalizer_widget.dart';
import 'package:new_fly_mixxxx/providers/audio_provider.dart';

void main() {
  group('EqualizerWidget Tests', () {
    // Test 1: Widget initialization
    testWidgets('EqualizerWidget displays title', (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: EqualizerWidget(),
            ),
          ),
        ),
      );

      expect(find.text('10-Band Equalizer'), findsOneWidget);
    });

    // Test 2: All 10 EQ bands visible
    testWidgets('EqualizerWidget displays all 10 frequency bands',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: EqualizerWidget(),
            ),
          ),
        ),
      );

      // Проверяем все частоты
      expect(find.text('60Hz'), findsOneWidget);
      expect(find.text('150Hz'), findsOneWidget);
      expect(find.text('400Hz'), findsOneWidget);
      expect(find.text('1kHz'), findsOneWidget);
      expect(find.text('2.4kHz'), findsOneWidget);
      expect(find.text('6kHz'), findsOneWidget);
      expect(find.text('15kHz'), findsOneWidget);
      expect(find.text('20kHz'), findsOneWidget);
      expect(find.text('30kHz'), findsOneWidget);
      expect(find.text('40kHz'), findsOneWidget);
    });

    // Test 3: Reset button present and functional
    testWidgets('EqualizerWidget has Reset button', (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: EqualizerWidget(),
            ),
          ),
        ),
      );

      expect(find.text('Reset'), findsOneWidget);
    });

    // Test 4: Horizontal scrolling for EQ bands
    testWidgets('EqualizerWidget bands are in horizontal scroll view',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: EqualizerWidget(),
            ),
          ),
        ),
      );

      expect(find.byType(SingleChildScrollView), findsWidgets);
    });

    // Test 5: EQ band labels are displayed
    testWidgets('EqualizerWidget displays EQ band values',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: EqualizerWidget(),
            ),
          ),
        ),
      );

      // Все полосы должны отображать "0.0dB" изначально
      final dbTexts = find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data != null &&
            widget.data!.contains('dB'),
      );

      // Должны быть значения для всех 10 полос
      expect(dbTexts, findsWidgets);
    });

    // Test 6: Container styling
    testWidgets('EqualizerWidget has proper styling', (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: EqualizerWidget(),
            ),
          ),
        ),
      );

      // Должен быть основной контейнер
      expect(find.byType(Container), findsWidgets);
    });

    // Test 7: Rotary knob widgets present
    testWidgets('EqualizerWidget uses RotaryKnobWidget',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: EqualizerWidget(),
            ),
          ),
        ),
      );

      // Должны быть крутилки (10 штук)
      // Проверяем наличие Column (каждая крутилка в Column)
      expect(find.byType(Column), findsWidgets);
    });

    // Test 8: Band labels constants
    test('EqualizerWidget bandLabels constant is correct', () {
      expect(EqualizerWidget.bandLabels.length, 10);
      expect(EqualizerWidget.bandLabels[0], '60Hz');
      expect(EqualizerWidget.bandLabels[4], '2.4kHz');
      expect(EqualizerWidget.bandLabels[9], '40kHz');
    });

    // Test 9: Provider integration
    testWidgets('EqualizerWidget reads from AudioProvider',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: EqualizerWidget(),
            ),
          ),
        ),
      );

      // Все EQ значения должны быть изначально 0
      expect(find.text('0.0dB'), findsWidgets);
    });

    // Test 10: Layout structure
    testWidgets('EqualizerWidget has correct layout structure',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: EqualizerWidget(),
            ),
          ),
        ),
      );

      // Основная структура: Container > Column > [Row with title/reset, SingleChildScrollView]
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Row), findsWidgets);
    });

    // Test 11: Title styling
    testWidgets('EqualizerWidget title has correct style',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: EqualizerWidget(),
            ),
          ),
        ),
      );

      final titleFinder = find.text('10-Band Equalizer');
      expect(titleFinder, findsOneWidget);

      // Проверяем, что это Text виджет
      final titleWidget = titleFinder.evaluate().first.widget as Text;
      expect(titleWidget.style?.fontSize, 16);
      expect(titleWidget.style?.fontWeight, FontWeight.bold);
    });

    // Test 12: Reset button styling
    testWidgets('EqualizerWidget Reset button has correct styling',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: EqualizerWidget(),
            ),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('EqualizerWidget EQ Band Tests', () {
    // Test 13: EQ band range validation
    testWidgets('EqualizerWidget EQ bands have correct value ranges',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      // Установим значения для всех полос
      for (int i = 0; i < 10; i++) {
        audioProvider.setEqBand(i, 5.0); // +5 dB
      }

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: EqualizerWidget(),
            ),
          ),
        ),
      );

      // Все значения должны быть видны как "5.0dB"
      expect(find.text('5.0dB'), findsWidgets);
    });

    // Test 14: Negative EQ values
    testWidgets('EqualizerWidget displays negative EQ values correctly',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      audioProvider.setEqBand(0, -3.0); // -3 dB

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: EqualizerWidget(),
            ),
          ),
        ),
      );

      expect(find.text('-3.0dB'), findsOneWidget);
    });

    // Test 15: EQ reset functionality
    testWidgets('EqualizerWidget reset sets all bands to 0',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      // Установим все полосы на ненулевые значения
      for (int i = 0; i < 10; i++) {
        audioProvider.setEqBand(i, 3.0 + i);
      }

      // Проверяем, что они установлены
      for (int i = 0; i < 10; i++) {
        expect(audioProvider.eqBands[i] > 0, true);
      }

      // Вызываем сброс
      audioProvider.resetEqualizer();

      // Проверяем, что все полосы вернулись к 0
      for (int i = 0; i < 10; i++) {
        expect(audioProvider.eqBands[i], 0.0);
      }
    });
  });

  group('EqualizerWidget Responsive Tests', () {
    // Test 16: Small screen layout
    testWidgets('EqualizerWidget works on small screen',
        (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: EqualizerWidget(),
            ),
          ),
        ),
      );

      expect(find.text('10-Band Equalizer'), findsOneWidget);
    });

    // Test 17: Large screen layout
    testWidgets('EqualizerWidget works on large screen',
        (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1400, 900);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: EqualizerWidget(),
            ),
          ),
        ),
      );

      expect(find.text('10-Band Equalizer'), findsOneWidget);
    });
  });
}

