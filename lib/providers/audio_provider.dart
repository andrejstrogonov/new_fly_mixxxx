import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';

// Track model
class Track {
  final String id;
  final String name;
  final String path;
  final Duration? duration;

  Track({
    required this.id,
    required this.name,
    required this.path,
    this.duration,
  });
}

// Equalizer preset definitions
class EQPreset {
  final String name;
  final List<double> bands;
  final String description;

  EQPreset({
    required this.name,
    required this.bands,
    required this.description,
  });
}

class AudioProvider extends ChangeNotifier {
  late AudioPlayer _audioPlayer1;
  late AudioPlayer _audioPlayer2;
  
  // Track queues (max 4 tracks per deck)
  final List<Track> _queue1 = [];
  final List<Track> _queue2 = [];
  int _currentTrackIndex1 = -1;
  int _currentTrackIndex2 = -1;
  static const int maxQueueSize = 4;

  // Equalizer bands (10-band)
  final List<double> _eqBands = List.filled(10, 0.0);
  
  // Current preset
  String _currentPreset = 'Flat';
  
  // Equalizer presets for different genres
  static final Map<String, EQPreset> eqPresets = {
    'Flat': EQPreset(
      name: 'Flat',
      bands: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
      description: 'Neutral flat response',
    ),
    'Tango': EQPreset(
      name: 'Tango',
      bands: [-2.0, -1.0, 1.0, 2.0, 3.0, 2.0, 1.0, -1.0, -2.0, -3.0],
      description: 'Enhanced midrange for tango vocals and strings',
    ),
    'Jazz': EQPreset(
      name: 'Jazz',
      bands: [1.0, 2.0, 1.0, 0.0, -1.0, 1.0, 2.0, 3.0, 2.0, 1.0],
      description: 'Warm bass and bright highs for jazz',
    ),
    'Folk Argentino': EQPreset(
      name: 'Folk Argentino',
      bands: [2.0, 1.0, 0.0, 1.0, 2.0, 1.0, 0.0, -1.0, -2.0, -1.0],
      description: 'Warm and earthy for Argentine folk',
    ),
    'Folk Russian': EQPreset(
      name: 'Folk Russian',
      bands: [1.0, 0.0, -1.0, 0.0, 1.0, 2.0, 3.0, 2.0, 1.0, 0.0],
      description: 'Bright and crisp for Russian folk',
    ),
    'Cross-step Waltz': EQPreset(
      name: 'Cross-step Waltz',
      bands: [0.0, 1.0, 2.0, 1.0, 0.0, -1.0, 0.0, 1.0, 2.0, 1.0],
      description: 'Balanced with emphasis on rhythm',
    ),
    'Bass Boost': EQPreset(
      name: 'Bass Boost',
      bands: [6.0, 5.0, 3.0, 0.0, -2.0, -3.0, -2.0, 0.0, 1.0, 2.0],
      description: 'Enhanced low frequencies',
    ),
    'Treble Boost': EQPreset(
      name: 'Treble Boost',
      bands: [-3.0, -2.0, -1.0, 0.0, 1.0, 3.0, 5.0, 6.0, 5.0, 4.0],
      description: 'Enhanced high frequencies',
    ),
    'Vocal': EQPreset(
      name: 'Vocal',
      bands: [-2.0, -1.0, 0.0, 2.0, 3.0, 2.0, 1.0, -1.0, -2.0, -3.0],
      description: 'Optimized for vocal clarity',
    ),
  };

  // Crossfader position (0 = deck1, 1 = deck2)
  double _crossfaderPosition = 0.5;
  
  // BPM and tempo
  double _bpm = 120.0;
  double _tempoMultiplier = 1.0;
  
  // Volume levels
  double _volume1 = 0.5;
  double _volume2 = 0.5;
  double _masterVolume = 0.8;
  
  // Playback state
  bool _isPlaying1 = false;
  bool _isPlaying2 = false;
  Duration _duration1 = Duration.zero;
  Duration _position1 = Duration.zero;
  Duration _duration2 = Duration.zero;
  Duration _position2 = Duration.zero;

  AudioProvider() {
    _audioPlayer1 = AudioPlayer();
    _audioPlayer2 = AudioPlayer();
    _setupListeners();
  }

  void _setupListeners() {
    _audioPlayer1.playerStateStream.listen((state) {
      _isPlaying1 = state.playing;
      notifyListeners();
    });

    _audioPlayer2.playerStateStream.listen((state) {
      _isPlaying2 = state.playing;
      notifyListeners();
    });

    _audioPlayer1.durationStream.listen((duration) {
      _duration1 = duration ?? Duration.zero;
      notifyListeners();
    });

    _audioPlayer2.durationStream.listen((duration) {
      _duration2 = duration ?? Duration.zero;
      notifyListeners();
    });

    _audioPlayer1.positionStream.listen((position) {
      _position1 = position;
      notifyListeners();
    });

    _audioPlayer2.positionStream.listen((position) {
      _position2 = position;
      notifyListeners();
    });
  }

  // Getters
  List<double> get eqBands => _eqBands;
  double get crossfaderPosition => _crossfaderPosition;
  double get bpm => _bpm;
  double get tempoMultiplier => _tempoMultiplier;
  double get volume1 => _volume1;
  double get volume2 => _volume2;
  double get masterVolume => _masterVolume;
  bool get isPlaying1 => _isPlaying1;
  bool get isPlaying2 => _isPlaying2;
  Duration get duration1 => _duration1;
  Duration get position1 => _position1;
  Duration get duration2 => _duration2;
  Duration get position2 => _position2;
  AudioPlayer get audioPlayer1 => _audioPlayer1;
  AudioPlayer get audioPlayer2 => _audioPlayer2;

  // Queue getters
  List<Track> get queue1 => _queue1;
  List<Track> get queue2 => _queue2;
  int get currentTrackIndex1 => _currentTrackIndex1;
  int get currentTrackIndex2 => _currentTrackIndex2;

  // Setters
  void setEqBand(int index, double value) {
    if (index >= 0 && index < _eqBands.length) {
      _eqBands[index] = value;
      notifyListeners();
    }
  }

  void setCrossfaderPosition(double value) {
    _crossfaderPosition = value.clamp(0.0, 1.0);
    _updateCrossfaderVolumes();
    notifyListeners();
  }

  void _updateCrossfaderVolumes() {
    // Crossfader affects the volume balance between decks
    // This is a simple linear crossfade
    _audioPlayer1.setVolume(_volume1 * (1 - _crossfaderPosition) * _masterVolume);
    _audioPlayer2.setVolume(_volume2 * _crossfaderPosition * _masterVolume);
  }

  void setBpm(double value) {
    _bpm = value.clamp(60.0, 240.0);
    notifyListeners();
  }

  void setTempoMultiplier(double value) {
    _tempoMultiplier = value.clamp(0.5, 2.0);
    _audioPlayer1.setSpeed(_tempoMultiplier);
    _audioPlayer2.setSpeed(_tempoMultiplier);
    notifyListeners();
  }

  void setVolume1(double value) {
    _volume1 = value.clamp(0.0, 1.0);
    _updateCrossfaderVolumes();
    notifyListeners();
  }

  void setVolume2(double value) {
    _volume2 = value.clamp(0.0, 1.0);
    _updateCrossfaderVolumes();
    notifyListeners();
  }

  void setMasterVolume(double value) {
    _masterVolume = value.clamp(0.0, 1.0);
    _updateCrossfaderVolumes();
    notifyListeners();
  }

  // Playback controls
  Future<void> playPause1() async {
    if (_isPlaying1) {
      await _audioPlayer1.pause();
    } else {
      await _audioPlayer1.play();
    }
  }

  Future<void> playPause2() async {
    if (_isPlaying2) {
      await _audioPlayer2.pause();
    } else {
      await _audioPlayer2.play();
    }
  }

  Future<void> stop1() async {
    await _audioPlayer1.stop();
  }

  Future<void> stop2() async {
    await _audioPlayer2.stop();
  }

  Future<void> seek1(Duration position) async {
    await _audioPlayer1.seek(position);
  }

  Future<void> seek2(Duration position) async {
    await _audioPlayer2.seek(position);
  }

  // Queue management
  bool addTrackToQueue1(Track track) {
    if (_queue1.length < maxQueueSize) {
      _queue1.add(track);
      notifyListeners();
      return true;
    }
    return false;
  }

  bool addTrackToQueue2(Track track) {
    if (_queue2.length < maxQueueSize) {
      _queue2.add(track);
      notifyListeners();
      return true;
    }
    return false;
  }

  void removeTrackFromQueue1(int index) {
    if (index >= 0 && index < _queue1.length) {
      _queue1.removeAt(index);
      if (_currentTrackIndex1 == index) {
        _currentTrackIndex1 = -1;
      } else if (_currentTrackIndex1 > index) {
        _currentTrackIndex1--;
      }
      notifyListeners();
    }
  }

  void removeTrackFromQueue2(int index) {
    if (index >= 0 && index < _queue2.length) {
      _queue2.removeAt(index);
      if (_currentTrackIndex2 == index) {
        _currentTrackIndex2 = -1;
      } else if (_currentTrackIndex2 > index) {
        _currentTrackIndex2--;
      }
      notifyListeners();
    }
  }

  void clearQueue1() {
    _queue1.clear();
    _currentTrackIndex1 = -1;
    notifyListeners();
  }

  void clearQueue2() {
    _queue2.clear();
    _currentTrackIndex2 = -1;
    notifyListeners();
  }

  Future<void> playTrackFromQueue1(int index) async {
    if (index >= 0 && index < _queue1.length) {
      _currentTrackIndex1 = index;
      await loadTrack1(_queue1[index].path);
      await playPause1();
      notifyListeners();
    }
  }

  Future<void> playTrackFromQueue2(int index) async {
    if (index >= 0 && index < _queue2.length) {
      _currentTrackIndex2 = index;
      await loadTrack2(_queue2[index].path);
      await playPause2();
      notifyListeners();
    }
  }

  Future<void> nextTrack1() async {
    if (_currentTrackIndex1 < _queue1.length - 1) {
      await playTrackFromQueue1(_currentTrackIndex1 + 1);
    }
  }

  Future<void> nextTrack2() async {
    if (_currentTrackIndex2 < _queue2.length - 1) {
      await playTrackFromQueue2(_currentTrackIndex2 + 1);
    }
  }

  Future<void> previousTrack1() async {
    if (_currentTrackIndex1 > 0) {
      await playTrackFromQueue1(_currentTrackIndex1 - 1);
    }
  }

  Future<void> previousTrack2() async {
    if (_currentTrackIndex2 > 0) {
      await playTrackFromQueue2(_currentTrackIndex2 - 1);
    }
  }

  Future<void> loadTrack1(String path) async {
    try {
      await _audioPlayer1.setFilePath(path);
    } catch (e) {
      debugPrint('Error loading track 1: $e');
    }
  }

  Future<void> loadTrack2(String path) async {
    try {
      await _audioPlayer2.setFilePath(path);
    } catch (e) {
      debugPrint('Error loading track 2: $e');
    }
  }

  void resetEqualizer() {
    for (int i = 0; i < _eqBands.length; i++) {
      _eqBands[i] = 0.0;
    }
    _currentPreset = 'Flat';
    notifyListeners();
  }

  // Preset management
  String get currentPreset => _currentPreset;
  
  List<String> getAvailablePresets() {
    return eqPresets.keys.toList();
  }

  void applyPreset(String presetName) {
    if (eqPresets.containsKey(presetName)) {
      final preset = eqPresets[presetName]!;
      for (int i = 0; i < preset.bands.length && i < _eqBands.length; i++) {
        _eqBands[i] = preset.bands[i];
      }
      _currentPreset = presetName;
      notifyListeners();
    }
  }

  EQPreset? getPreset(String presetName) {
    return eqPresets[presetName];
  }

  // Frequency response calculation for visualization
  List<double> calculateFrequencyResponse(List<int> frequencies) {
    // Simplified frequency response calculation
    // Maps EQ band adjustments to frequency response curve
    List<double> response = [];
    
    for (int freq in frequencies) {
      double magnitude = 0.0;
      
      // Calculate contribution from each EQ band
      for (int i = 0; i < _eqBands.length; i++) {
        double bandFreq = _getBandFrequency(i);
        double bandwidth = _getBandwidth(i);
        
        // Gaussian-like response centered at band frequency
        double distance = (freq - bandFreq).abs();
        double contribution = _eqBands[i] * exp(-(distance * distance) / (2 * bandwidth * bandwidth));
        magnitude += contribution;
      }
      
      response.add(magnitude);
    }
    
    return response;
  }

  double _getBandFrequency(int bandIndex) {
    // 10-band EQ frequencies (Hz)
    const frequencies = [60, 150, 400, 1000, 2400, 6000, 15000, 20000, 30000, 40000];
    return frequencies[bandIndex].toDouble();
  }

  double _getBandwidth(int bandIndex) {
    // Bandwidth increases for higher frequencies
    return 100.0 + (bandIndex * 50.0);
  }

  // Phase response calculation (simplified)
  List<double> calculatePhaseResponse(List<int> frequencies) {
    List<double> phases = [];
    
    for (int freq in frequencies) {
      double phase = 0.0;
      
      for (int i = 0; i < _eqBands.length; i++) {
        if (_eqBands[i] != 0.0) {
          double bandFreq = _getBandFrequency(i);
          // Simplified phase calculation
          double phaseDiff = (freq - bandFreq) / bandFreq;
          phase += _eqBands[i] * atan(phaseDiff) * 180 / 3.14159;
        }
      }
      
      phases.add(phase);
    }
    
    return phases;
  }

  @override
  void dispose() {
    _audioPlayer1.dispose();
    _audioPlayer2.dispose();
    super.dispose();
  }
}
