import 'package:flutter/material.dart';
import '../viewmodels/base_viewmodel.dart';
import '../../domain/entities/track_entity.dart';
import '../../domain/repositories/audio_repository.dart';
import '../../domain/usecases/audio/load_track_usecase.dart';
import '../../domain/usecases/audio/play_audio_usecase.dart';
import '../../domain/usecases/audio/pause_audio_usecase.dart';
import '../../domain/usecases/audio/stop_audio_usecase.dart';
import '../../domain/usecases/audio/seek_audio_usecase.dart';
import '../../core/utils/logger.dart';

/// ViewModel для управления аудиоплеером
class AudioViewModel extends BaseViewModel {
  final AudioRepository audioRepository;
  final LoadTrackUseCase loadTrackUseCase;
  final PlayAudioUseCase playAudioUseCase;
  final PauseAudioUseCase pauseAudioUseCase;
  final StopAudioUseCase stopAudioUseCase;
  final SeekAudioUseCase seekAudioUseCase;

  // State для Дека 1
  TrackEntity? _currentTrack1;
  bool _isPlaying1 = false;
  Duration _position1 = Duration.zero;
  Duration _duration1 = Duration.zero;
  final List<TrackEntity> _queue1 = [];

  // State для Дека 2
  TrackEntity? _currentTrack2;
  bool _isPlaying2 = false;
  Duration _position2 = Duration.zero;
  Duration _duration2 = Duration.zero;
  final List<TrackEntity> _queue2 = [];

  // Getters для Дека 1
  TrackEntity? get currentTrack1 => _currentTrack1;
  bool get isPlaying1 => _isPlaying1;
  Duration get position1 => _position1;
  Duration get duration1 => _duration1;
  List<TrackEntity> get queue1 => List.unmodifiable(_queue1);

  // Getters для Дека 2
  TrackEntity? get currentTrack2 => _currentTrack2;
  bool get isPlaying2 => _isPlaying2;
  Duration get position2 => _position2;
  Duration get duration2 => _duration2;
  List<TrackEntity> get queue2 => List.unmodifiable(_queue2);

  AudioViewModel({
    required this.audioRepository,
    required this.loadTrackUseCase,
    required this.playAudioUseCase,
    required this.pauseAudioUseCase,
    required this.stopAudioUseCase,
    required this.seekAudioUseCase,
  });

  // ==================== Дек 1 методы ====================

  /// Загружает трек в Дек 1
  Future<void> loadTrack1(TrackEntity track) async {
    setLoading();
    log('Loading track into Deck 1: ${track.displayName}');

    final result = await loadTrackUseCase(
      LoadTrackParams(track: track, playerNumber: 1),
    );

    result.fold(
      (failure) {
        setError(failure.message, code: failure.code);
        logError('Failed to load track in Deck 1: ${failure.message}');
      },
      (_) {
        _currentTrack1 = track;
        _duration1 = track.duration ?? Duration.zero;
        _position1 = Duration.zero;
        setSuccess();
        log('Track loaded in Deck 1 successfully');
        notifyListeners();
      },
    );
  }

  /// Начинает воспроизведение на Деке 1
  Future<void> playDeck1() async {
    setLoading();
    final result = await playAudioUseCase(const PlayAudioParams(playerNumber: 1));

    handleResult(
      result,
      onSuccess: (_) {
        _isPlaying1 = true;
        log('Playback started on Deck 1');
        notifyListeners();
      },
      onError: (message, code) {
        logError('Failed to play on Deck 1: $message');
      },
    );
  }

  /// Паузирует воспроизведение на Деке 1
  Future<void> pauseDeck1() async {
    setLoading();
    final result = await pauseAudioUseCase(const PauseAudioParams(playerNumber: 1));

    handleResult(
      result,
      onSuccess: (_) {
        _isPlaying1 = false;
        log('Playback paused on Deck 1');
        notifyListeners();
      },
      onError: (message, code) {
        logError('Failed to pause on Deck 1: $message');
      },
    );
  }

  /// Останавливает воспроизведение на Деке 1
  Future<void> stopDeck1() async {
    setLoading();
    final result = await stopAudioUseCase(const StopAudioParams(playerNumber: 1));

    handleResult(
      result,
      onSuccess: (_) {
        _isPlaying1 = false;
        _position1 = Duration.zero;
        log('Playback stopped on Deck 1');
        notifyListeners();
      },
      onError: (message, code) {
        logError('Failed to stop on Deck 1: $message');
      },
    );
  }

  /// Переходит на позицию в треке на Деке 1
  Future<void> seekDeck1(Duration position) async {
    final result = await seekAudioUseCase(
      SeekAudioParams(position: position, playerNumber: 1),
    );

    handleResult(
      result,
      onSuccess: (_) {
        _position1 = position;
        log('Seeked to ${position.inSeconds}s on Deck 1');
        notifyListeners();
      },
      onError: (message, code) {
        logError('Failed to seek on Deck 1: $message');
      },
    );
  }

  // ==================== Дек 2 методы ====================

  /// Загружает трек в Дек 2
  Future<void> loadTrack2(TrackEntity track) async {
    setLoading();
    log('Loading track into Deck 2: ${track.displayName}');

    final result = await loadTrackUseCase(
      LoadTrackParams(track: track, playerNumber: 2),
    );

    result.fold(
      (failure) {
        setError(failure.message, code: failure.code);
        logError('Failed to load track in Deck 2: ${failure.message}');
      },
      (_) {
        _currentTrack2 = track;
        _duration2 = track.duration ?? Duration.zero;
        _position2 = Duration.zero;
        setSuccess();
        log('Track loaded in Deck 2 successfully');
        notifyListeners();
      },
    );
  }

  /// Начинает воспроизведение на Деке 2
  Future<void> playDeck2() async {
    setLoading();
    final result = await playAudioUseCase(const PlayAudioParams(playerNumber: 2));

    handleResult(
      result,
      onSuccess: (_) {
        _isPlaying2 = true;
        log('Playback started on Deck 2');
        notifyListeners();
      },
      onError: (message, code) {
        logError('Failed to play on Deck 2: $message');
      },
    );
  }

  /// Паузирует воспроизведение на Деке 2
  Future<void> pauseDeck2() async {
    setLoading();
    final result = await pauseAudioUseCase(const PauseAudioParams(playerNumber: 2));

    handleResult(
      result,
      onSuccess: (_) {
        _isPlaying2 = false;
        log('Playback paused on Deck 2');
        notifyListeners();
      },
      onError: (message, code) {
        logError('Failed to pause on Deck 2: $message');
      },
    );
  }

  /// Останавливает воспроизведение на Деке 2
  Future<void> stopDeck2() async {
    setLoading();
    final result = await stopAudioUseCase(const StopAudioParams(playerNumber: 2));

    handleResult(
      result,
      onSuccess: (_) {
        _isPlaying2 = false;
        _position2 = Duration.zero;
        log('Playback stopped on Deck 2');
        notifyListeners();
      },
      onError: (message, code) {
        logError('Failed to stop on Deck 2: $message');
      },
    );
  }

  /// Переходит на позицию в треке на Деке 2
  Future<void> seekDeck2(Duration position) async {
    final result = await seekAudioUseCase(
      SeekAudioParams(position: position, playerNumber: 2),
    );

    handleResult(
      result,
      onSuccess: (_) {
        _position2 = position;
        log('Seeked to ${position.inSeconds}s on Deck 2');
        notifyListeners();
      },
      onError: (message, code) {
        logError('Failed to seek on Deck 2: $message');
      },
    );
  }

  // ==================== Очередь (Queue) методы ====================

  /// Добавляет трек в очередь Дека 1
  void addToQueue1(TrackEntity track) {
    if (_queue1.length >= 4) {
      setError('Queue is full (max 4 tracks)', code: 'QUEUE_FULL');
      return;
    }
    _queue1.add(track);
    log('Track added to Queue 1: ${track.displayName}');
    notifyListeners();
  }

  /// Добавляет трек в очередь Дека 2
  void addToQueue2(TrackEntity track) {
    if (_queue2.length >= 4) {
      setError('Queue is full (max 4 tracks)', code: 'QUEUE_FULL');
      return;
    }
    _queue2.add(track);
    log('Track added to Queue 2: ${track.displayName}');
    notifyListeners();
  }

  /// Удаляет трек из очереди Дека 1
  void removeFromQueue1(int index) {
    if (index >= 0 && index < _queue1.length) {
      _queue1.removeAt(index);
      log('Track removed from Queue 1 at index $index');
      notifyListeners();
    }
  }

  /// Удаляет трек из очереди Дека 2
  void removeFromQueue2(int index) {
    if (index >= 0 && index < _queue2.length) {
      _queue2.removeAt(index);
      log('Track removed from Queue 2 at index $index');
      notifyListeners();
    }
  }

  /// Очищает очередь Дека 1
  void clearQueue1() {
    _queue1.clear();
    log('Queue 1 cleared');
    notifyListeners();
  }

  /// Очищает очередь Дека 2
  void clearQueue2() {
    _queue2.clear();
    log('Queue 2 cleared');
    notifyListeners();
  }

  @override
  void dispose() {
    log('AudioViewModel disposed');
    super.dispose();
  }
}

