import 'package:flutter_test/flutter_test.dart';
import 'package:new_fly_mixxxx/providers/audio_provider.dart';

void main() {
  group('AudioProvider Tests', () {
    late AudioProvider audioProvider;

    setUp(() {
      audioProvider = AudioProvider();
    });

    test('AudioProvider initializes with default values', () {
      expect(audioProvider.currentPreset, 'Flat');
      expect(audioProvider.crossfaderPosition, 0.5);
      expect(audioProvider.eqBands.length, 10);
      expect(audioProvider.eqBands.every((b) => b == 0.0), true);
    });

    test('EQ Bands can be modified', () {
      audioProvider.setEqBand(0, 5.0);
      expect(audioProvider.eqBands[0], 5.0);

      audioProvider.setEqBand(9, -3.0);
      expect(audioProvider.eqBands[9], -3.0);
    });

    test('EQ Bands are clamped to valid range', () {
      audioProvider.setEqBand(0, 15.0); // Max is 12
      expect(audioProvider.eqBands[0] <= 12.0, true);

      audioProvider.setEqBand(1, -15.0); // Min is -12
      expect(audioProvider.eqBands[1] >= -12.0, true);
    });

    test('Crossfader position is valid', () {
      audioProvider.setCrossfaderPosition(0.0);
      expect(audioProvider.crossfaderPosition, 0.0);

      audioProvider.setCrossfaderPosition(1.0);
      expect(audioProvider.crossfaderPosition, 1.0);

      audioProvider.setCrossfaderPosition(0.5);
      expect(audioProvider.crossfaderPosition, 0.5);
    });

    test('Crossfader position is clamped to 0-1 range', () {
      audioProvider.setCrossfaderPosition(-0.5);
      expect(audioProvider.crossfaderPosition >= 0.0, true);

      audioProvider.setCrossfaderPosition(1.5);
      expect(audioProvider.crossfaderPosition <= 1.0, true);
    });

    test('EQ Presets contain all required genres', () {
      expect(AudioProvider.eqPresets.containsKey('Flat'), true);
      expect(AudioProvider.eqPresets.containsKey('Tango'), true);
      expect(AudioProvider.eqPresets.containsKey('Jazz'), true);
      expect(AudioProvider.eqPresets.containsKey('Folk Argentino'), true);
      expect(AudioProvider.eqPresets.containsKey('Folk Russian'), true);
    });

    test('EQ Presets have correct band count', () {
      AudioProvider.eqPresets.forEach((name, preset) {
        expect(preset.bands.length, 10,
            reason: 'Preset $name should have 10 bands');
        preset.bands.forEach((band) {
          expect(band >= -12.0 && band <= 12.0, true,
              reason: 'Band value $band in preset $name is out of range');
        });
      });
    });

    test('Preset can be applied', () {
      audioProvider.applyPreset('Bass Boost');
      expect(audioProvider.currentPreset, 'Bass Boost');
      expect(audioProvider.eqBands, AudioProvider.eqPresets['Bass Boost']!.bands);
    });

    test('Invalid preset application is handled gracefully', () {
      audioProvider.applyPreset('NonExistentPreset');
      // Should remain unchanged
      expect(audioProvider.currentPreset, 'Flat');
    });

    test('Frequency response calculation works', () {
      final frequencies = [20, 100, 1000, 10000, 20000];
      final magnitudes = audioProvider.calculateFrequencyResponse(frequencies);

      expect(magnitudes.length, frequencies.length);
      magnitudes.forEach((mag) {
        expect(mag >= -12.0 && mag <= 12.0, true);
      });
    });

    test('Phase response calculation works', () {
      final frequencies = [20, 100, 1000, 10000, 20000];
      final phases = audioProvider.calculatePhaseResponse(frequencies);

      expect(phases.length, frequencies.length);
      phases.forEach((phase) {
        expect(phase >= -180.0 && phase <= 180.0, true);
      });
    });

    test('Presets are notifiable', () async {
      bool notified = false;
      audioProvider.addListener(() {
        notified = true;
      });

      audioProvider.applyPreset('Tango');
      await Future.delayed(const Duration(milliseconds: 100));

      expect(notified, true);
    });
  });
}

