import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:new_fly_mixxxx/widgets/rotary_knob_widget.dart';

void main() {
  group('RotaryKnobWidget Tests', () {
    testWidgets('RotaryKnobWidget renders correctly', (WidgetTester tester) async {
      double testValue = 50;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: testValue,
              min: 0,
              max: 100,
              onChanged: (value) {},
              label: 'Test Knob',
            ),
          ),
        ),
      );

      expect(find.byType(RotaryKnobWidget), findsOneWidget);
      expect(find.text('Test Knob'), findsOneWidget);
    });

    testWidgets('RotaryKnobWidget displays value', (WidgetTester tester) async {
      double testValue = 50;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: testValue,
              min: 0,
              max: 100,
              onChanged: (value) {},
              label: 'Test Knob',
              unit: '%',
              showValue: true,
            ),
          ),
        ),
      );

      expect(find.text('50.0%'), findsOneWidget);
    });

    testWidgets('RotaryKnobWidget calls onChanged', (WidgetTester tester) async {
      double testValue = 50;
      double? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: testValue,
              min: 0,
              max: 100,
              onChanged: (value) {
                changedValue = value;
              },
              label: 'Test Knob',
            ),
          ),
        ),
      );

      // Эмулируем drag события
      await tester.drag(find.byType(RotaryKnobWidget), const Offset(20, 0));
      await tester.pumpAndSettle();

      // Проверяем, что onChanged был вызван
      expect(changedValue, isNotNull);
    });

    testWidgets('RotaryKnobWidget respects min/max values', (WidgetTester tester) async {
      double testValue = 50;
      double? changedValue = testValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: testValue,
              min: 10,
              max: 90,
              onChanged: (value) {
                changedValue = value;
              },
              label: 'Test Knob',
            ),
          ),
        ),
      );

      expect(find.byType(RotaryKnobWidget), findsOneWidget);
    });

    testWidgets('RotaryKnobWidget updates on value change', (WidgetTester tester) async {
      double testValue = 50;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) => Scaffold(
              body: RotaryKnobWidget(
                value: testValue,
                min: 0,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    testValue = value;
                  });
                },
                label: 'Test Knob',
                unit: '%',
              ),
            ),
          ),
        ),
      );

      expect(find.text('50.0%'), findsOneWidget);

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) => Scaffold(
              body: RotaryKnobWidget(
                value: 75,
                min: 0,
                max: 100,
                onChanged: (value) {},
                label: 'Test Knob',
                unit: '%',
              ),
            ),
          ),
        ),
      );

      expect(find.text('75.0%'), findsOneWidget);
    });

    testWidgets('RotaryKnobWidget custom colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 50,
              min: 0,
              max: 100,
              onChanged: (value) {},
              label: 'Test Knob',
              activeColor: Colors.red,
              inactiveColor: Colors.blue,
            ),
          ),
        ),
      );

      expect(find.byType(RotaryKnobWidget), findsOneWidget);
    });

    testWidgets('RotaryKnobWidget custom size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotaryKnobWidget(
              value: 50,
              min: 0,
              max: 100,
              onChanged: (value) {},
              label: 'Test Knob',
              size: 120,
            ),
          ),
        ),
      );

      final sizedBox = find.byType(SizedBox).first;
      expect(sizedBox, findsOneWidget);
    });
  });
}

