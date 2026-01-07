/// Константы для аудио обработки
class AudioConstants {
  // EQ Frequencies (Hz) - 10 band equalizer
  static const List<double> eqFrequencies = [
    31, // 31 Hz
    62, // 62 Hz
    125, // 125 Hz
    250, // 250 Hz
    500, // 500 Hz
    1000, // 1 kHz
    2000, // 2 kHz
    4000, // 4 kHz
    8000, // 8 kHz
    16000, // 16 kHz
  ];

  static const int eqBandCount = 10;
  static const double eqMinGain = -12.0; // dB
  static const double eqMaxGain = 12.0; // dB
  static const double eqDefaultGain = 0.0; // dB

  // Frequency Response
  static const double minFrequency = 10.0; // Hz
  static const double maxFrequency = 20000.0; // Hz
  static const int frequencyResponseBands = 100; // точек на графике

  // Mixer
  static const double minVolume = 0.0;
  static const double maxVolume = 100.0;
  static const double defaultVolume = 50.0;

  static const double minCrossfader = 0.0;
  static const double maxCrossfader = 100.0;
  static const double defaultCrossfader = 50.0;

  // Audio format
  static const List<String> supportedAudioFormats = [
    'mp3',
    'wav',
    'flac',
    'aac',
    'm4a',
  ];

  // File size limits (MB)
  static const int maxAudioFileSizeMB = 500;
}

