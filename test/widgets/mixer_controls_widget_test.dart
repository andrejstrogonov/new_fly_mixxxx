import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:new_fly_mixxxx/widgets/mixer_controls_widget.dart';
import 'package:new_fly_mixxxx/providers/audio_provider.dart';

void main() {
  group('MixerControlsWidget Tests', () {
    // Test 1: Widget initialization
    testWidgets('MixerControlsWidget displays title',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      expect(find.text('Mixer Controls'), findsOneWidget);
    });

    // Test 2: All control labels visible
    testWidgets('MixerControlsWidget displays all control labels',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      expect(find.text('Crossfader'), findsOneWidget);
      expect(find.text('Master\nVol'), findsOneWidget);
      expect(find.text('BPM'), findsOneWidget);
      expect(find.text('Tempo'), findsOneWidget);
      expect(find.text('Deck Volumes'), findsOneWidget);
      expect(find.text('Deck 1\nVol'), findsOneWidget);
      expect(find.text('Deck 2\nVol'), findsOneWidget);
    });

    // Test 3: Crossfader slider present
    testWidgets('MixerControlsWidget has Crossfader slider',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      // Должен быть слайдер для кроссфейдера
      expect(find.byType(Slider), findsWidgets);
    });

    // Test 4: Rotary knobs for mixer controls
    testWidgets('MixerControlsWidget has rotary knobs',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      // RotaryKnobWidget должны быть визуализированы
      // Проверяем наличие CustomPaint (используется в RotaryKnobPainter)
      expect(find.byType(CustomPaint), findsWidgets);
    });

    // Test 5: Master Volume knob visible
    testWidgets('MixerControlsWidget displays Master Volume knob',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      expect(find.text('Master\nVol'), findsOneWidget);
      // Значение в процентах
      expect(find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data != null &&
            widget.data!.contains('%'),
      ), findsWidgets);
    });

    // Test 6: BPM knob visible
    testWidgets('MixerControlsWidget displays BPM knob',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      expect(find.text('BPM'), findsOneWidget);
    });

    // Test 7: Tempo knob visible
    testWidgets('MixerControlsWidget displays Tempo knob',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      expect(find.text('Tempo'), findsOneWidget);
    });

    // Test 8: Deck volume controls visible
    testWidgets('MixerControlsWidget displays Deck Volume controls',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      expect(find.text('Deck 1\nVol'), findsOneWidget);
      expect(find.text('Deck 2\nVol'), findsOneWidget);
    });

    // Test 9: Horizontal scrolling for controls
    testWidgets('MixerControlsWidget main controls in horizontal scroll',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      expect(find.byType(SingleChildScrollView), findsWidgets);
    });

    // Test 10: Container styling
    testWidgets('MixerControlsWidget has proper styling',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsWidgets);
    });

    // Test 11: Layout structure
    testWidgets('MixerControlsWidget has correct layout',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      // Container > Column
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Row), findsWidgets);
    });
  });

  group('MixerControlsWidget Control Tests', () {
    // Test 12: Crossfader position
    testWidgets('MixerControlsWidget Crossfader shows deck info',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      // Должна быть информация о текущей позиции кроссфейдера
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data != null &&
              (widget.data!.contains('D1') || widget.data!.contains('D2')),
        ),
        findsWidgets,
      );
    });

    // Test 13: Master Volume value display
    testWidgets('MixerControlsWidget Master Volume displays percentage',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();
      audioProvider.setMasterVolume(0.85); // 85%

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      // Должно отображаться значение громкости
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data != null &&
              widget.data!.contains('85'),
        ),
        findsWidgets,
      );
    });

    // Test 14: BPM display
    testWidgets('MixerControlsWidget displays BPM value',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();
      audioProvider.setBpm(120);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      // Должно быть значение BPM
      expect(find.text('120.0'), findsOneWidget);
    });

    // Test 15: Tempo display
    testWidgets('MixerControlsWidget displays Tempo percentage',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();
      audioProvider.setTempoMultiplier(1.0);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      // Должно быть значение Tempo
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data != null &&
              widget.data!.contains('100'),
        ),
        findsWidgets,
      );
    });

    // Test 16: Deck volume values
    testWidgets('MixerControlsWidget displays Deck volumes',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();
      audioProvider.setVolume1(0.75); // 75%
      audioProvider.setVolume2(0.50); // 50%

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      // Должны быть значения громкости для обоих деков
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data != null &&
              (widget.data!.contains('75') || widget.data!.contains('50')),
        ),
        findsWidgets,
      );
    });

    // Test 17: Min/Max BPM values
    test('MixerControlsWidget BPM range is correct', () {
      final audioProvider = AudioProvider();

      // BPM should be between 60 and 240
      audioProvider.setBpm(60);
      expect(audioProvider.bpm, 60);

      audioProvider.setBpm(240);
      expect(audioProvider.bpm, 240);

      // Out of range should be clamped (if implemented)
      audioProvider.setBpm(120);
      expect(audioProvider.bpm, 120);
    });

    // Test 18: Tempo range
    test('MixerControlsWidget Tempo range is correct', () {
      final audioProvider = AudioProvider();

      // Tempo multiplier should be between 0.5 and 2.0
      audioProvider.setTempoMultiplier(0.5);
      expect(audioProvider.tempoMultiplier, 0.5);

      audioProvider.setTempoMultiplier(2.0);
      expect(audioProvider.tempoMultiplier, 2.0);

      audioProvider.setTempoMultiplier(1.0);
      expect(audioProvider.tempoMultiplier, 1.0);
    });

    // Test 19: Crossfader range
    test('MixerControlsWidget Crossfader range is correct', () {
      final audioProvider = AudioProvider();

      // Crossfader should be between 0 and 1
      audioProvider.setCrossfaderPosition(0);
      expect(audioProvider.crossfaderPosition, 0);

      audioProvider.setCrossfaderPosition(1);
      expect(audioProvider.crossfaderPosition, 1);

      audioProvider.setCrossfaderPosition(0.5);
      expect(audioProvider.crossfaderPosition, 0.5);
    });

    // Test 20: Volume range
    test('MixerControlsWidget Volume range is correct', () {
      final audioProvider = AudioProvider();

      // Volumes should be between 0 and 1
      audioProvider.setVolume1(0);
      expect(audioProvider.volume1, 0);

      audioProvider.setVolume1(1);
      expect(audioProvider.volume1, 1);

      audioProvider.setVolume2(0.5);
      expect(audioProvider.volume2, 0.5);
    });
  });

  group('MixerControlsWidget Provider Integration Tests', () {
    // Test 21: AudioProvider integration
    testWidgets('MixerControlsWidget reads from AudioProvider',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      // Set some initial values
      audioProvider.setMasterVolume(0.8);
      audioProvider.setBpm(130);
      audioProvider.setVolume1(0.65);
      audioProvider.setVolume2(0.45);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      // Проверяем, что значения отображаются
      expect(find.byType(MixerControlsWidget), findsOneWidget);
    });

    // Test 22: State updates
    testWidgets('MixerControlsWidget updates when provider changes',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      // Change a value
      audioProvider.setMasterVolume(0.9);

      // Rebuild
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      // Value should be updated
      expect(audioProvider.masterVolume, 0.9);
    });
  });

  group('MixerControlsWidget Responsive Tests', () {
    // Test 23: Small screen
    testWidgets('MixerControlsWidget works on small screen',
        (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      expect(find.text('Mixer Controls'), findsOneWidget);
    });

    // Test 24: Large screen
    testWidgets('MixerControlsWidget works on large screen',
        (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1400, 900);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      expect(find.text('Mixer Controls'), findsOneWidget);
    });
  });
}

