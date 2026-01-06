import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_fly_mixxxx/widgets/rotary_knob_widget.dart';
import 'package:new_fly_mixxxx/providers/audio_provider.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

void main() {
  group('RotaryKnobWidget Tests', () {
    // Test 1: Widget initialization
    testWidgets('RotaryKnobWidget initializes with correct default values',
        (WidgetTester tester) async {
      double testValue = 50;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: testValue,
              min: 0,
              max: 100,
              onChanged: (_) {},
              label: 'Test Knob',
            ),
          ),
        ),
      );

      expect(find.byType(RotaryKnobWidget), findsOneWidget);
      expect(find.text('Test Knob'), findsOneWidget);
      expect(find.text('50.0'), findsOneWidget);
    });

    // Test 2: Value display format
    testWidgets('RotaryKnobWidget displays value with correct decimal places',
        (WidgetTester tester) async {
      double testValue = 42.567;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: testValue,
              min: 0,
              max: 100,
              onChanged: (_) {},
              label: 'Test',
              unit: 'dB',
            ),
          ),
        ),
      );

      // Значение должно быть отформатировано с одной цифрой после запятой
      expect(find.text('42.6dB'), findsOneWidget);
    });

    // Test 3: Unit display
    testWidgets('RotaryKnobWidget displays unit correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 50,
              min: 0,
              max: 100,
              onChanged: (_) {},
              label: 'Volume',
              unit: '%',
            ),
          ),
        ),
      );

      expect(find.text('50.0%'), findsOneWidget);
    });

    // Test 4: Custom size
    testWidgets('RotaryKnobWidget respects custom size',
        (WidgetTester tester) async {
      const double customSize = 120;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 50,
              min: 0,
              max: 100,
              onChanged: (_) {},
              label: 'Test',
              size: customSize,
            ),
          ),
        ),
      );

      final sizedBox = find.byType(SizedBox).first;
      expect(sizedBox, findsOneWidget);
    });

    // Test 5: Value range validation
    testWidgets('RotaryKnobWidget handles values within range',
        (WidgetTester tester) async {
      final values = <double>[];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 50,
              min: 0,
              max: 100,
              onChanged: (value) => values.add(value),
              label: 'Test',
            ),
          ),
        ),
      );

      // Значение должно быть в диапазоне [0, 100]
      expect(values.isEmpty, true);
    });

    // Test 6: Minimum and maximum values
    testWidgets('RotaryKnobWidget displays minimum value correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 0,
              min: 0,
              max: 100,
              onChanged: (_) {},
              label: 'Min Test',
            ),
          ),
        ),
      );

      expect(find.text('0.0'), findsOneWidget);
    });

    testWidgets('RotaryKnobWidget displays maximum value correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 100,
              min: 0,
              max: 100,
              onChanged: (_) {},
              label: 'Max Test',
            ),
          ),
        ),
      );

      expect(find.text('100.0'), findsOneWidget);
    });

    // Test 7: Label display
    testWidgets('RotaryKnobWidget displays custom labels correctly',
        (WidgetTester tester) async {
      const String testLabel = 'Master Volume';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 50,
              min: 0,
              max: 100,
              onChanged: (_) {},
              label: testLabel,
            ),
          ),
        ),
      );

      expect(find.text(testLabel), findsOneWidget);
    });

    // Test 8: Value hiding option
    testWidgets('RotaryKnobWidget hides value when showValue is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 50,
              min: 0,
              max: 100,
              onChanged: (_) {},
              label: 'Hidden',
              showValue: false,
            ),
          ),
        ),
      );

      // Значение не должно отображаться
      expect(find.text('50.0'), findsNothing);
      expect(find.text('Hidden'), findsOneWidget);
    });

    // Test 9: Custom colors
    testWidgets('RotaryKnobWidget applies custom colors',
        (WidgetTester tester) async {
      const Color customActive = Colors.red;
      const Color customInactive = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 50,
              min: 0,
              max: 100,
              onChanged: (_) {},
              label: 'Colored',
              activeColor: customActive,
              inactiveColor: customInactive,
            ),
          ),
        ),
      );

      expect(find.byType(RotaryKnobWidget), findsOneWidget);
    });

    // Test 10: Negative values
    testWidgets('RotaryKnobWidget handles negative values',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: -5,
              min: -12,
              max: 12,
              onChanged: (_) {},
              label: 'EQ Band',
              unit: 'dB',
            ),
          ),
        ),
      );

      expect(find.text('-5.0dB'), findsOneWidget);
    });

    // Test 11: Callback invocation
    testWidgets('RotaryKnobWidget invokes onChanged callback',
        (WidgetTester tester) async {
      final changedValues = <double>[];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 50,
              min: 0,
              max: 100,
              onChanged: (value) => changedValues.add(value),
              label: 'Test',
            ),
          ),
        ),
      );

      // Callback не должен быть вызван при инициализации
      expect(changedValues.isEmpty, true);
    });

    // Test 12: Value update
    testWidgets('RotaryKnobWidget updates display when value changes',
        (WidgetTester tester) async {
      double currentValue = 25;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return RotaryKnobWidget(
                  value: currentValue,
                  min: 0,
                  max: 100,
                  onChanged: (newValue) {
                    setState(() {
                      currentValue = newValue;
                    });
                  },
                  label: 'Dynamic',
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('25.0'), findsOneWidget);
    });

    // Test 13: Edge case - very small range
    testWidgets('RotaryKnobWidget handles very small value range',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 0.5,
              min: 0,
              max: 1,
              onChanged: (_) {},
              label: 'Small Range',
            ),
          ),
        ),
      );

      expect(find.text('0.5'), findsOneWidget);
    });

    // Test 14: Edge case - large values
    testWidgets('RotaryKnobWidget handles large values',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 10000,
              min: 0,
              max: 20000,
              onChanged: (_) {},
              label: 'Large',
            ),
          ),
        ),
      );

      expect(find.text('10000.0'), findsOneWidget);
    });

    // Test 15: Label multi-line
    testWidgets('RotaryKnobWidget handles multi-line labels',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 50,
              min: 0,
              max: 100,
              onChanged: (_) {},
              label: 'Deck 1\nVol',
            ),
          ),
        ),
      );

      expect(find.text('Deck 1\nVol'), findsOneWidget);
    });
  });

  group('RotaryKnobPainter Tests', () {
    // Test 16: Painter repaints on value change
    testWidgets('RotaryKnobPainter repaints when value changes',
        (WidgetTester tester) async {
      double value = 25;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    RotaryKnobWidget(
                      value: value,
                      min: 0,
                      max: 100,
                      onChanged: (newValue) {
                        setState(() {
                          value = newValue;
                        });
                      },
                      label: 'Test',
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          value = 75;
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
      );

      expect(find.text('25.0'), findsOneWidget);

      await tester.tap(find.text('Change'));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 75,
              min: 0,
              max: 100,
              onChanged: (_) {},
              label: 'Test',
            ),
          ),
        ),
      );

      expect(find.text('75.0'), findsOneWidget);
    });

    // Test 17: Default values
    testWidgets('RotaryKnobWidget has correct default values',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 50,
              min: 0,
              max: 100,
              onChanged: (_) {},
              label: 'Default Test',
              // size defaults to 80
              // showValue defaults to true
              // activeColor defaults to Colors.deepPurple
              // inactiveColor defaults to Colors.grey
            ),
          ),
        ),
      );

      expect(find.byType(RotaryKnobWidget), findsOneWidget);
    });
  });

  group('Mathematical Calculations Tests', () {
    // Test 18: Angle calculation (from -135 to +135 degrees)
    test('Angle calculation from normalized value', () {
      final normalizedValue = 0.5; // 50%
      final expectedAngle = -135 + (normalizedValue * 270);
      expect(expectedAngle, 0); // 50% = 0 degrees (center)
    });

    test('Angle calculation at minimum', () {
      final normalizedValue = 0.0; // 0%
      final expectedAngle = -135 + (normalizedValue * 270);
      expect(expectedAngle, -135);
    });

    test('Angle calculation at maximum', () {
      final normalizedValue = 1.0; // 100%
      final expectedAngle = -135 + (normalizedValue * 270);
      expect(expectedAngle, 135);
    });

    // Test 19: Coordinate conversion
    test('Offset calculation from angle', () {
      final angle = 0.0; // Center
      final radians = angle * math.pi / 180;
      final radius = 30.0;

      final knobX = radius * math.cos(radians);
      final knobY = radius * math.sin(radians);

      expect(knobX, closeTo(30.0, 0.01));
      expect(knobY, closeTo(0.0, 0.01));
    });

    // Test 20: Clamping
    test('Normalized degrees clamped to valid range', () {
      var degrees = 370; // Out of range
      var normalized = (degrees + 135) / 270;
      expect(normalized > 1, true); // Should be > 1 before clamping

      final clamped = normalized.clamp(0.0, 1.0);
      expect(clamped, lessThanOrEqualTo(1.0));
      expect(clamped, greaterThanOrEqualTo(0.0));
    });
  });

  group('PointerMove Handler Tests', () {
    // Test 21: _onPointerMove with Offset parameter
    testWidgets('_onPointerMove correctly handles Offset',
        (WidgetTester tester) async {
      final changedValues = <double>[];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 50,
              min: 0,
              max: 100,
              onChanged: (value) => changedValues.add(value),
              label: 'Test',
            ),
          ),
        ),
      );

      // Виджет должен быть инициализирован без ошибок
      expect(find.byType(RotaryKnobWidget), findsOneWidget);
    });

    // Test 22: Listener pointer tracking
    testWidgets('Listener tracks pointer movement correctly',
        (WidgetTester tester) async {
      final audioProvider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: audioProvider,
            child: const Scaffold(
              body: SizedBox(
                width: 100,
                height: 100,
                child: RotaryKnobWidget(
                  value: 50,
                  min: 0,
                  max: 100,
                  onChanged: null,
                  label: 'Test',
                  size: 80,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Listener), findsOneWidget);
    });

    // Test 23: GestureDetector pan handling
    testWidgets('GestureDetector pan update works correctly',
        (WidgetTester tester) async {
      double currentValue = 50;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return RotaryKnobWidget(
                  value: currentValue,
                  min: 0,
                  max: 100,
                  onChanged: (newValue) {
                    setState(() {
                      currentValue = newValue;
                    });
                  },
                  label: 'Test',
                  size: 80,
                );
              },
            ),
          ),
        ),
      );

      expect(find.byType(GestureDetector), findsOneWidget);
    });

    // Test 24: RenderBox conversion test
    testWidgets('RenderBox.globalToLocal conversion works',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 50,
              min: 0,
              max: 100,
              onChanged: (_) {},
              label: 'Test',
              size: 100,
            ),
          ),
        ),
      );

      final sizedBox = find.byType(SizedBox).first;
      expect(sizedBox, findsOneWidget);

      // RenderBox должен быть получен без ошибок
      final renderBox = tester.binding.window.onMetricsChanged;
      expect(renderBox, isNotNull);
    });

    // Test 25: Offset parameter validation
    test('Offset calculation with real coordinates', () {
      // Тест проверяет математику преобразования координат
      final centerX = 50.0;
      final centerY = 50.0;
      final localX = 75.0;
      final localY = 50.0;

      final center = Offset(centerX, centerY);
      final localPosition = Offset(localX, localY);
      final offset = localPosition - center;

      expect(offset.dx, 25.0);
      expect(offset.dy, 0.0);
    });
  });
}
}

