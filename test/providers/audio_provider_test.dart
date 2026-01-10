import 'package:flutter_test/flutter_test.dart';
import '../mocks/mock_audio_provider.dart';

void main() {
  group('AudioProvider Tests', () {
    late MockAudioProvider audioProvider;

    setUp(() {
      audioProvider = MockAudioProvider();
    });

    test('should initialize with default values', () {
      expect(audioProvider.crossfaderPosition, 0.5);
      expect(audioProvider.masterVolume, 0.8);
      expect(audioProvider.bpm, 120.0);
      expect(audioProvider.currentPreset, 'Flat');
    });

    test('should update crossfader position', () {
      audioProvider.setCrossfaderPosition(0.7);
      expect(audioProvider.crossfaderPosition, 0.7);
    });

    test('should update EQ band', () {
      audioProvider.setEqBand(0, 5.0);
      expect(audioProvider.eqBands[0], 5.0);
      expect(audioProvider.currentPreset, 'Custom');
    });

    test('should apply EQ preset', () {
      audioProvider.applyPreset('Bass Boost');
      expect(audioProvider.currentPreset, 'Bass Boost');
    });

    test('should reset equalizer', () {
      audioProvider.setEqBand(0, 5.0);
      audioProvider.resetEqualizer();
      expect(audioProvider.eqBands[0], 0.0);
      expect(audioProvider.currentPreset, 'Flat');
    });
  });
}