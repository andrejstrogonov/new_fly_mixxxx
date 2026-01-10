import 'base_viewmodel.dart';
import '../../domain/entities/track_entity.dart';
import '../../domain/entities/eq_preset_entity.dart';
import '../../core/constants/eq_presets_constants.dart';

class MixerViewModel extends BaseViewModel {
  // Audio state
  TrackEntity? _currentTrack1;
  TrackEntity? _currentTrack2;
  bool _isPlaying1 = false;
  bool _isPlaying2 = false;
  Duration _position1 = Duration.zero;
  Duration _position2 = Duration.zero;
  final Duration _duration1 = Duration.zero;
  final Duration _duration2 = Duration.zero;

  // Mixer controls
  double _crossfaderPosition = 0.5;
  double _volume1 = 0.5;
  double _volume2 = 0.5;
  double _masterVolume = 0.8;
  double _bpm = 120.0;
  double _tempoMultiplier = 1.0;

  // Equalizer
  final List<double> _eqBands = List.filled(10, 0.0);
  String _currentPreset = 'Flat';

  // Getters
  TrackEntity? get currentTrack1 => _currentTrack1;
  TrackEntity? get currentTrack2 => _currentTrack2;
  bool get isPlaying1 => _isPlaying1;
  bool get isPlaying2 => _isPlaying2;
  Duration get position1 => _position1;
  Duration get position2 => _position2;
  Duration get duration1 => _duration1;
  Duration get duration2 => _duration2;
  
  double get crossfaderPosition => _crossfaderPosition;
  double get volume1 => _volume1;
  double get volume2 => _volume2;
  double get masterVolume => _masterVolume;
  double get bpm => _bpm;
  double get tempoMultiplier => _tempoMultiplier;
  
  List<double> get eqBands => List.unmodifiable(_eqBands);
  String get currentPreset => _currentPreset;

  // Audio controls
  Future<void> playPauseDeck1() async {
    setLoading();
    try {
      _isPlaying1 = !_isPlaying1;
      log('Deck 1 ${_isPlaying1 ? "playing" : "paused"}');
      setSuccess();
      notifyListeners();
    } catch (e) {
      setError('Failed to control deck 1: $e');
    }
  }

  Future<void> playPauseDeck2() async {
    setLoading();
    try {
      _isPlaying2 = !_isPlaying2;
      log('Deck 2 ${_isPlaying2 ? "playing" : "paused"}');
      setSuccess();
      notifyListeners();
    } catch (e) {
      setError('Failed to control deck 2: $e');
    }
  }

  Future<void> stopDeck1() async {
    try {
      _isPlaying1 = false;
      _position1 = Duration.zero;
      log('Deck 1 stopped');
      notifyListeners();
    } catch (e) {
      setError('Failed to stop deck 1: $e');
    }
  }

  Future<void> stopDeck2() async {
    try {
      _isPlaying2 = false;
      _position2 = Duration.zero;
      log('Deck 2 stopped');
      notifyListeners();
    } catch (e) {
      setError('Failed to stop deck 2: $e');
    }
  }

  Future<void> seekDeck1(Duration position) async {
    try {
      _position1 = position;
      log('Deck 1 seeked to ${position.inSeconds}s');
      notifyListeners();
    } catch (e) {
      setError('Failed to seek deck 1: $e');
    }
  }

  Future<void> seekDeck2(Duration position) async {
    try {
      _position2 = position;
      log('Deck 2 seeked to ${position.inSeconds}s');
      notifyListeners();
    } catch (e) {
      setError('Failed to seek deck 2: $e');
    }
  }

  // Mixer controls
  void setCrossfaderPosition(double value) {
    _crossfaderPosition = value.clamp(0.0, 1.0);
    log('Crossfader position: $_crossfaderPosition');
    notifyListeners();
  }

  void setVolume1(double value) {
    _volume1 = value.clamp(0.0, 1.0);
    log('Volume 1: $_volume1');
    notifyListeners();
  }

  void setVolume2(double value) {
    _volume2 = value.clamp(0.0, 1.0);
    log('Volume 2: $_volume2');
    notifyListeners();
  }

  void setMasterVolume(double value) {
    _masterVolume = value.clamp(0.0, 1.0);
    log('Master volume: $_masterVolume');
    notifyListeners();
  }

  void setBpm(double value) {
    _bpm = value.clamp(60.0, 240.0);
    log('BPM: $_bpm');
    notifyListeners();
  }

  void setTempoMultiplier(double value) {
    _tempoMultiplier = value.clamp(0.5, 2.0);
    log('Tempo multiplier: $_tempoMultiplier');
    notifyListeners();
  }

  // Equalizer controls
  void setEqBand(int index, double value) {
    if (index >= 0 && index < _eqBands.length) {
      _eqBands[index] = value.clamp(-12.0, 12.0);
      _currentPreset = 'Custom';
      log('EQ band $index: ${_eqBands[index]}');
      notifyListeners();
    }
  }

  void applyEqPreset(String presetName) {
    final preset = EQPresetsConstants.presets[presetName];
    if (preset != null) {
      for (int i = 0; i < preset.bands.length && i < _eqBands.length; i++) {
        _eqBands[i] = preset.bands[i];
      }
      _currentPreset = presetName;
      log('Applied EQ preset: $presetName');
      notifyListeners();
    }
  }

  void resetEqualizer() {
    for (int i = 0; i < _eqBands.length; i++) {
      _eqBands[i] = 0.0;
    }
    _currentPreset = 'Flat';
    log('Equalizer reset');
    notifyListeners();
  }

  List<String> getAvailablePresets() {
    return EQPresetsConstants.presets.keys.toList();
  }

  EQPresetEntity? getPreset(String presetName) {
    return EQPresetsConstants.presets[presetName];
  }

  @override
  void dispose() {
    log('MixerViewModel disposed');
    super.dispose();
  }
}