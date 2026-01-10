import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import '../mocks/mock_audio_provider.dart';
import '../../lib/widgets/mixer_controls_widget.dart';

void main() {
  group('MixerControlsWidget Tests', () {
    testWidgets('should display mixer controls', (WidgetTester tester) async {
      final mockProvider = MockAudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: mockProvider,
            child: const Scaffold(
              body: MixerControlsWidget(),
            ),
          ),
        ),
      );

      expect(find.text('Mixer Controls'), findsOneWidget);
      expect(find.text('Crossfader'), findsOneWidget);
      expect(find.text('Deck Volumes'), findsOneWidget);
    });
  });
}