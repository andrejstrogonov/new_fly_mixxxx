import 'package:flutter/foundation.dart';
import '../../lib/core/constants/eq_presets_constants.dart';
import '../../lib/domain/entities/eq_preset_entity.dart';

class MockAudioProvider extends ChangeNotifier {
  final List<double> _eqBands = List.filled(10, 0.0);
  String _currentPreset = 'Flat';
  double _crossfaderPosition = 0.5;
  double _masterVolume = 0.8;
  double _bpm = 120.0;

  List<double> get eqBands => _eqBands;
  String get currentPreset => _currentPreset;
  double get crossfaderPosition => _crossfaderPosition;
  double get masterVolume => _masterVolume;
  double get bpm => _bpm;

  void setEqBand(int index, double value) {
    if (index >= 0 && index < _eqBands.length) {
      _eqBands[index] = value.clamp(-12.0, 12.0);
      _currentPreset = 'Custom';
      notifyListeners();
    }
  }

  void applyPreset(String presetName) {
    final preset = EQPresetsConstants.presets[presetName];
    if (preset != null) {
      for (int i = 0; i < preset.bands.length && i < _eqBands.length; i++) {
        _eqBands[i] = preset.bands[i];
      }
      _currentPreset = presetName;
      notifyListeners();
    }
  }

  void resetEqualizer() {
    for (int i = 0; i < _eqBands.length; i++) {
      _eqBands[i] = 0.0;
    }
    _currentPreset = 'Flat';
    notifyListeners();
  }

  void setCrossfaderPosition(double value) {
    _crossfaderPosition = value.clamp(0.0, 1.0);
    notifyListeners();
  }
}