# Fly Mixxx - Professional DJ Mixer

A cross-platform DJ mixer application for Windows and Android, designed for mixing tango instrumentals and other music genres.

## Features

- **Dual Deck System**: Mix between two audio tracks simultaneously
- **10-Band Equalizer**: Fine-tune audio frequencies (60Hz to 40kHz)
- **Crossfader**: Smooth transitions between decks
- **BPM Control**: Adjust tempo from 60 to 240 BPM
- **Tempo/Speed Control**: Adjust playback speed from 0.5x to 2.0x
- **Master Volume Control**: Control overall output level
- **Individual Deck Volume**: Separate volume controls for each deck
- **Progress Tracking**: Real-time position and duration display
- **Dark Theme UI**: Professional DJ-style interface

## Requirements

- Flutter SDK 3.10.4 or higher
- Dart SDK 3.10.4 or higher
- Android SDK (for Android builds)
- Windows SDK (for Windows builds)

## Installation

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Build for Windows

```bash
flutter build windows
```

To run on Windows:
```bash
flutter run -d windows
```

### 3. Build for Android

```bash
flutter build apk
```

To run on Android device/emulator:
```bash
flutter run -d android
```

## Usage

### Loading Tracks

1. Click on a deck (Deck 1 or Deck 2)
2. Select an audio file from your device
3. The track will load and display duration

### Playback Controls

- **Play/Pause**: Start or pause playback
- **Stop**: Stop playback and reset position
- **Progress Bar**: Click to seek to a specific position

### Mixing

1. Load different tracks on Deck 1 and Deck 2
2. Use the **Crossfader** to blend between decks
3. Adjust individual **Volume** sliders for each deck
4. Use **Master Volume** to control overall output

### Equalizer

- Adjust each of the 10 frequency bands (-12dB to +12dB)
- **Reset** button returns all bands to 0dB
- Bands: 60Hz, 150Hz, 400Hz, 1kHz, 2.4kHz, 6kHz, 15kHz, 20kHz, 30kHz, 40kHz

### Tempo Control

- **BPM**: Set the target beats per minute (60-240)
- **Tempo**: Adjust playback speed (0.5x to 2.0x)

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── providers/
│   └── audio_provider.dart   # Audio playback state management
├── screens/
│   └── mixer_screen.dart     # Main mixer interface
└── widgets/
    ├── deck_widget.dart      # Individual deck UI
    ├── mixer_controls_widget.dart  # Mixer controls
    └── equalizer_widget.dart # 10-band equalizer
```

## Dependencies

- **just_audio**: Audio playback engine
- **audio_session**: Audio session management
- **provider**: State management
- **fl_chart**: Chart visualization (for future enhancements)

## Supported Audio Formats

- MP3
- WAV
- FLAC
- OGG
- M4A
- AAC

## Platform-Specific Notes

### Windows
- Requires Windows 10 or later
- Audio output through system default device
- File access through Windows file system

### Android
- Requires Android 5.0 (API 21) or higher
- Requires storage permissions to access audio files
- Audio output through device speakers or connected audio device

## Tips for Tango Instrumentals

1. **Crossfader**: Use smooth crossfades to blend tango tracks seamlessly
2. **Equalizer**: Enhance bass frequencies (60Hz-150Hz) for traditional tango sound
3. **Tempo**: Maintain consistent BPM between tracks for smooth transitions
4. **Volume**: Keep levels balanced to prevent distortion

## Troubleshooting

### No Sound Output
- Check device volume settings
- Verify audio file format is supported
- Ensure audio permissions are granted (Android)

### App Crashes on Startup
- Run `flutter clean`
- Run `flutter pub get`
- Rebuild the application

### Audio File Won't Load
- Verify file path is correct
- Check file format is supported
- Ensure sufficient storage space

## Future Enhancements

- Waveform visualization
- Cue points and hot cues
- Loop functionality
- Playlist management
- Audio effects (reverb, delay, etc.)
- Recording capability
- Skin customization

## License

This project is provided as-is for personal and commercial use.

## Support

For issues or feature requests, please refer to the GitHub repository.

---

**Fly Mixxx** - Professional DJ Mixing Made Simple
