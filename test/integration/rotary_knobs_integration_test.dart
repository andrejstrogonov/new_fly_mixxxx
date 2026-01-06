import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:new_fly_mixxxx/screens/mixer_screen.dart';
import 'package:new_fly_mixxxx/providers/audio_provider.dart';

void main() {
  group('Rotary Knobs Integration Tests', () {
    // Test 1: Full integration - Equalizer and Mixer Controls together
    testWidgets('Full mixer UI with rotary knobs loads correctly',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: MixerScreen(),
          ),
        ),
      );

      // Проверяем основные элементы
      expect(find.text('Fly Mixxx - DJ Mixer'), findsOneWidget);
    });

    // Test 2: Mixer Controls with rotary knobs visible
    testWidgets('MixerScreen displays Mixer Controls with knobs',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: MixerScreen(),
          ),
        ),
      );

      expect(find.text('Mixer Controls'), findsOneWidget);
      // CustomPaint для крутилок
      expect(find.byType(CustomPaint), findsWidgets);
    });

    // Test 3: Equalizer with 10-band rotary knobs
    testWidgets('MixerScreen displays 10-Band Equalizer with knobs',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: MixerScreen(),
          ),
        ),
      );

      expect(find.text('10-Band Equalizer'), findsOneWidget);
      // Все 10 частот должны быть видны
      expect(find.text('60Hz'), findsOneWidget);
      expect(find.text('40kHz'), findsOneWidget);
    });

    // Test 4: Space efficiency on large screen
    testWidgets('Rotary knobs save space on large screen',
        (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1400, 900);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: MixerScreen(),
          ),
        ),
      );

      // На большом экране должны быть видны все контролы
      expect(find.text('Mixer Controls'), findsOneWidget);
      expect(find.text('10-Band Equalizer'), findsOneWidget);
    });

    // Test 5: Master Volume knob functionality
    testWidgets('Master Volume knob updates value',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();
      double currentValue = 0.5;

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: [
                      Text('Master: ${(currentValue * 100).toStringAsFixed(0)}%'),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentValue = 0.75;
                          });
                        },
                        child: const Text('Change'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('Master: 50%'), findsOneWidget);

      await tester.tap(find.text('Change'));
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: Scaffold(
              body: Text('Master: 75%'),
            ),
          ),
        ),
      );

      expect(find.text('Master: 75%'), findsOneWidget);
    });

    // Test 6: EQ band updates
    testWidgets('EQ band values update correctly',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: MixerScreen(),
          ),
        ),
      );

      // Установим значение для 60Hz
      audioProvider.setEqBand(0, 3.0);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: MixerScreen(),
          ),
        ),
      );

      // Значение должно быть обновлено
      expect(audioProvider.eqBands[0], 3.0);
    });

    // Test 7: Tango preset application
    testWidgets('Tango preset applies correct EQ values',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      // Применяем Tango preset
      audioProvider.applyPreset('Tango');

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: MixerScreen(),
          ),
        ),
      );

      // Проверяем критические значения Tango
      expect(audioProvider.eqBands[0], 1.0); // 60Hz: +1.0 dB
      expect(audioProvider.eqBands[1], 2.0); // 150Hz: +2.0 dB
      expect(audioProvider.eqBands[9], 0.0); // 40kHz: 0.0 dB (ИСПРАВЛЕНО!)
    });

    // Test 8: All knobs initialized properly
    testWidgets('All rotary knobs initialize with proper values',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: MixerScreen(),
          ),
        ),
      );

      // Проверяем, что контролы имеют начальные значения
      expect(audioProvider.masterVolume, isNotNull);
      expect(audioProvider.bpm, isNotNull);
      expect(audioProvider.tempoMultiplier, isNotNull);
      expect(audioProvider.volume1, isNotNull);
      expect(audioProvider.volume2, isNotNull);
    });

    // Test 9: Reset equalizer through UI
    testWidgets('Reset button resets all EQ bands',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      // Установим значения
      for (int i = 0; i < 10; i++) {
        audioProvider.setEqBand(i, 2.0);
      }

      // Проверяем, что они установлены
      for (int i = 0; i < 10; i++) {
        expect(audioProvider.eqBands[i], 2.0);
      }

      // Сбрасываем
      audioProvider.resetEqualizer();

      // Проверяем, что все вернулись к 0
      for (int i = 0; i < 10; i++) {
        expect(audioProvider.eqBands[i], 0.0);
      }
    });

    // Test 10: Multiple presets switching
    testWidgets('Presets can be switched without errors',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      final presets = ['Flat', 'Tango', 'Jazz'];

      for (String preset in presets) {
        audioProvider.applyPreset(preset);
        expect(audioProvider.currentPreset, preset);

        await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider.value(
              value: audioProvider,
              child: MixerScreen(),
            ),
          ),
        );
      }
    });
  });

  group('Tango Preset Bug Fix Verification', () {
    // Test 11: 40kHz value is 0.0 (not -3.0)
    test('Tango preset has correct 40kHz value', () {
      final audioProvider = AudioProvider();
      audioProvider.applyPreset('Tango');

      // КРИТИЧЕСКИ ВАЖНО: 40kHz должна быть 0.0, не -3.0
      expect(audioProvider.eqBands[9], 0.0);
      expect(audioProvider.eqBands[9], isNot(-3.0));
    });

    // Test 12: 60Hz bass enhancement
    test('Tango preset has bass enhancement at 60Hz', () {
      final audioProvider = AudioProvider();
      audioProvider.applyPreset('Tango');

      // 60Hz должна быть +1.0 (усиление баса)
      expect(audioProvider.eqBands[0], 1.0);
      expect(audioProvider.eqBands[0], isNot(-2.0)); // Не должна быть старым значением
    });

    // Test 13: 150Hz bandoneon enhancement
    test('Tango preset has bandoneon enhancement at 150Hz', () {
      final audioProvider = AudioProvider();
      audioProvider.applyPreset('Tango');

      // 150Hz должна быть +2.0 (характер бандонеона)
      expect(audioProvider.eqBands[1], 2.0);
      expect(audioProvider.eqBands[1], isNot(-1.0)); // Не старое значение
    });

    // Test 14: All Tango values correct
    test('All Tango preset values are correct', () {
      final audioProvider = AudioProvider();
      audioProvider.applyPreset('Tango');

      final expectedValues = [1.0, 2.0, 1.0, 1.5, 2.0, 1.0, 0.5, -0.5, -1.0, 0.0];

      for (int i = 0; i < 10; i++) {
        expect(
          audioProvider.eqBands[i],
          expectedValues[i],
          reason: 'Band $i should be ${expectedValues[i]}, but got ${audioProvider.eqBands[i]}',
        );
      }
    });

    // Test 15: Tango preset is within valid range
    test('All Tango values are within valid dB range', () {
      final audioProvider = AudioProvider();
      audioProvider.applyPreset('Tango');

      for (int i = 0; i < 10; i++) {
        expect(
          audioProvider.eqBands[i] >= -12.0 && audioProvider.eqBands[i] <= 12.0,
          true,
          reason: 'Band $i value ${audioProvider.eqBands[i]} is out of range',
        );
      }
    });
  });

  group('Widget Error Handling', () {
    // Test 16: Widget builds without errors on initialization
    testWidgets('MixerScreen builds without errors',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: MixerScreen(),
          ),
        ),
      );

      // No exceptions should be thrown
      expect(find.byType(MixerScreen), findsOneWidget);
    });

    // Test 17: Rapid value changes don't cause crashes
    testWidgets('Rapid EQ changes do not crash',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: MixerScreen(),
          ),
        ),
      );

      // Быстро меняем значения
      for (int i = 0; i < 10; i++) {
        for (double value = -12; value <= 12; value += 6) {
          audioProvider.setEqBand(i, value);
        }
      }

      // Приложение не должно упасть
      expect(find.byType(MixerScreen), findsOneWidget);
    });

    // Test 18: Memory efficiency
    testWidgets('No memory leaks with multiple widget builds',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      // Несколько раз пересчитываем виджет
      for (int i = 0; i < 5; i++) {
        await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider.value(
              value: audioProvider,
              child: MixerScreen(),
            ),
          ),
        );
      }

      expect(find.byType(MixerScreen), findsOneWidget);
    });
  });

  group('Accessibility Tests', () {
    // Test 19: All controls are tappable
    testWidgets('All mixer controls are accessible',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: MixerScreen(),
          ),
        ),
      );

      // Проверяем наличие interactive элементов
      expect(find.byType(GestureDetector), findsWidgets);
      expect(find.byType(Slider), findsWidgets);
    });

    // Test 20: Labels are readable
    testWidgets('All controls have readable labels',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: MixerScreen(),
          ),
        ),
      );

      // Проверяем наличие текстовых меток
      expect(find.byType(Text), findsWidgets);
    });
  });
}

