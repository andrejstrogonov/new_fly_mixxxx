# Fly Mixxx - Setup and Build Guide

## Quick Start

### Prerequisites
- Flutter SDK 3.10.4+
- Dart SDK 3.10.4+
- For Windows: Visual Studio 2022 or Build Tools
- For Android: Android SDK, Android NDK, Java Development Kit (JDK)

### Step 1: Install Dependencies

Navigate to the project directory and run:

```bash
cd C:\Users\strog\StudioProjects\new_fly_mixxxx
flutter pub get
```

### Step 2: Run on Windows

```bash
flutter run -d windows
```

Or build a release version:

```bash
flutter build windows --release
```

The Windows executable will be located at:
```
build\windows\runner\Release\new_fly_mixxxx.exe
```

### Step 3: Run on Android

Connect an Android device or start an emulator, then run:

```bash
flutter run -d android
```

Or build an APK:

```bash
flutter build apk --release
```

The APK will be located at:
```
build\app\outputs\flutter-apk\app-release.apk
```

## Application Features

### Main Interface

The application consists of three main sections:

1. **Dual Decks** (Top)
   - Deck 1 and Deck 2 side by side
   - Each deck has independent playback controls
   - Individual volume sliders
   - Progress tracking with seek capability

2. **Mixer Controls** (Middle)
   - Crossfader: Blend between decks
   - Master Volume: Overall output level
   - BPM Control: Set tempo (60-240 BPM)
   - Tempo/Speed: Adjust playback speed (0.5x-2.0x)

3. **10-Band Equalizer** (Bottom)
   - Frequency bands: 60Hz, 150Hz, 400Hz, 1kHz, 2.4kHz, 6kHz, 15kHz, 20kHz, 30kHz, 40kHz
   - Range: -12dB to +12dB per band
   - Reset button to return to flat response

## File Structure

```
new_fly_mixxxx/
├── lib/
│   ├── main.dart                          # App entry point
│   ├── providers/
│   │   └── audio_provider.dart            # Audio state management
│   ├── screens/
│   │   └── mixer_screen.dart              # Main UI screen
│   └── widgets/
│       ├── deck_widget.dart               # Deck UI component
│       ├── mixer_controls_widget.dart     # Mixer controls component
│       └── equalizer_widget.dart          # Equalizer component
├── android/                               # Android-specific files
├── windows/                               # Windows-specific files
├── pubspec.yaml                           # Project dependencies
└── README.md                              # Documentation
```

## Key Components

### AudioProvider (State Management)

Manages all audio playback and mixer state:
- Two AudioPlayer instances (for dual decks)
- Equalizer band values (10 bands)
- Crossfader position
- Volume levels (deck 1, deck 2, master)
- BPM and tempo settings
- Playback state tracking

### DeckWidget

Individual deck interface with:
- Play/Pause/Stop controls
- Progress bar with seek capability
- Volume slider
- Duration and position display
- Visual feedback for active playback

### MixerControlsWidget

Central mixer controls:
- Crossfader for blending decks
- Master volume control
- BPM adjustment
- Tempo/speed control

### EqualizerWidget

10-band equalizer with:
- Vertical sliders for each frequency band
- Real-time value display
- Reset functionality
- Frequency labels

## Audio File Support

Supported formats:
- MP3
- WAV
- FLAC
- OGG
- M4A
- AAC

## Customization

### Changing Colors

Edit `lib/main.dart` to modify the theme:

```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.deepPurple,  // Change this color
  brightness: Brightness.dark,
),
```

### Adjusting Equalizer Bands

Edit `lib/widgets/equalizer_widget.dart` to add/remove bands:

```dart
static const List<String> bandLabels = [
  '60Hz',
  '150Hz',
  // Add more frequencies here
];
```

### Modifying BPM Range

Edit `lib/widgets/mixer_controls_widget.dart`:

```dart
Slider(
  value: audioProvider.bpm,
  min: 60,      // Minimum BPM
  max: 240,     // Maximum BPM
  // ...
)
```

## Troubleshooting

### Build Issues

**Issue**: "Flutter not found"
- Solution: Add Flutter to PATH or use full path to flutter command

**Issue**: "Android SDK not found"
- Solution: Run `flutter doctor` and follow instructions to install Android SDK

**Issue**: "Windows build tools not found"
- Solution: Install Visual Studio 2022 with C++ build tools

### Runtime Issues

**Issue**: No sound output
- Check system volume settings
- Verify audio file format is supported
- Check device audio permissions (Android)

**Issue**: App crashes on startup
- Run `flutter clean`
- Delete `pubspec.lock`
- Run `flutter pub get`
- Rebuild the app

**Issue**: Audio file won't load
- Verify file path is correct
- Check file format is supported
- Ensure file is not corrupted

## Performance Tips

1. **For Smooth Mixing**:
   - Use consistent BPM between tracks
   - Adjust tempo gradually
   - Use crossfader for smooth transitions

2. **For Better Sound**:
   - Use high-quality audio files (320kbps MP3 or lossless)
   - Adjust equalizer to enhance desired frequencies
   - Keep master volume at reasonable levels

3. **For Stability**:
   - Close other audio applications
   - Ensure sufficient device storage
   - Keep device temperature normal

## Advanced Features (Future)

Planned enhancements:
- Waveform visualization
- Cue points and hot cues
- Loop functionality
- Playlist management
- Audio effects (reverb, delay, echo)
- Recording capability
- Skin customization
- MIDI controller support

## Development Notes

### Adding New Features

1. Update `AudioProvider` for state management
2. Create new widget in `lib/widgets/`
3. Update `MixerScreen` to include new widget
4. Test on both Windows and Android

### Testing

Run tests with:
```bash
flutter test
```

### Code Analysis

Check code quality with:
```bash
flutter analyze
```

## Distribution

### Windows Distribution

1. Build release:
   ```bash
   flutter build windows --release
   ```

2. Create installer using NSIS or similar tool

3. Distribute `.exe` file

### Android Distribution

1. Build release APK:
   ```bash
   flutter build apk --release
   ```

2. Sign APK with your keystore

3. Upload to Google Play Store or distribute directly

## Support and Feedback

For issues, feature requests, or feedback, please refer to the project repository.

---

**Fly Mixxx** - Professional DJ Mixing Application
Version 1.0.0
