import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends ChangeNotifier {
  late AudioPlayer _audioPlayer1;
  late AudioPlayer _audioPlayer2;
  
  // Equalizer bands (10-band)
  final List<double> _eqBands = List.filled(10, 0.0);
  
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
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer1.dispose();
    _audioPlayer2.dispose();
    super.dispose();
  }
}
