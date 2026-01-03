# Fly Mixxx - Developer Guide

## Project Architecture

### State Management (Provider Pattern)

The application uses the Provider package for state management:

```
AudioProvider (ChangeNotifier)
├── Audio Players (2x AudioPlayer)
├── Equalizer State (10 bands)
├── Mixer State (crossfader, volumes, BPM, tempo)
└── Playback State (playing, duration, position)
```

### Widget Hierarchy

```
MyApp
└── MixerScreen
    ├── DeckWidget (x2)
    │   ├── Play/Pause/Stop buttons
    │   ├── Progress bar
    │   └── Volume slider
    ├── MixerControlsWidget
    │   ├── Crossfader
    │   ├── Master Volume
    │   ├── BPM Control
    │   └── Tempo Control
    └── EqualizerWidget
        └── EQ Sliders (x10)
```

## Adding New Features

### 1. Adding a New Control

**Example: Adding a Filter Control**

1. Update `AudioProvider`:
```dart
class AudioProvider extends ChangeNotifier {
  double _filterFrequency = 20000.0;
  
  double get filterFrequency => _filterFrequency;
  
  void setFilterFrequency(double value) {
    _filterFrequency = value.clamp(100.0, 20000.0);
    notifyListeners();
  }
}
```

2. Create new widget `lib/widgets/filter_widget.dart`:
```dart
class FilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audioProvider, _) {
        return Slider(
          value: audioProvider.filterFrequency,
          min: 100,
          max: 20000,
          onChanged: (value) {
            audioProvider.setFilterFrequency(value);
          },
        );
      },
    );
  }
}
```

3. Add to `MixerScreen`:
```dart
const FilterWidget(),
```

### 2. Adding Audio Effects

**Example: Adding Reverb Effect**

1. Update `pubspec.yaml`:
```yaml
dependencies:
  audio_service: ^0.18.0
```

2. Update `AudioProvider`:
```dart
Future<void> setReverb(double amount) async {
  // Implement reverb using audio service
  // This would require native platform channels
}
```

3. Create effect widget and add to UI

### 3. Adding Waveform Visualization

1. Add dependency:
```yaml
dependencies:
  audio_waveforms: ^1.0.0
```

2. Create `lib/widgets/waveform_widget.dart`:
```dart
class WaveformWidget extends StatelessWidget {
  final AudioPlayer audioPlayer;
  
  @override
  Widget build(BuildContext context) {
    // Implement waveform visualization
  }
}
```

3. Add to deck widgets

## Code Style Guidelines

### Naming Conventions

- **Classes**: PascalCase (e.g., `AudioProvider`, `DeckWidget`)
- **Functions/Methods**: camelCase (e.g., `playPause()`, `setVolume()`)
- **Variables**: camelCase (e.g., `_audioPlayer`, `crossfaderPosition`)
- **Constants**: camelCase (e.g., `bandLabels`)
- **Private members**: Prefix with underscore (e.g., `_audioPlayer`)

### File Organization

```
lib/
├── main.dart                    # App entry point
├── providers/                   # State management
│   └── audio_provider.dart
├── screens/                     # Full-screen widgets
│   └── mixer_screen.dart
├── widgets/                     # Reusable components
│   ├── deck_widget.dart
│   ├── mixer_controls_widget.dart
│   ├── equalizer_widget.dart
│   └── [new_feature_widget.dart]
├── models/                      # Data models (future)
├── services/                    # Business logic (future)
└── utils/                       # Utility functions (future)
```

### Code Formatting

- Use 2-space indentation
- Max line length: 80 characters (comments), 100 (code)
- Use `const` for constant values
- Use `final` for variables that don't change
- Add documentation comments for public APIs

## Testing

### Unit Tests

Create `test/providers/audio_provider_test.dart`:

```dart
void main() {
  group('AudioProvider', () {
    late AudioProvider audioProvider;
    
    setUp(() {
      audioProvider = AudioProvider();
    });
    
    tearDown(() {
      audioProvider.dispose();
    });
    
    test('setVolume1 updates volume correctly', () {
      audioProvider.setVolume1(0.5);
      expect(audioProvider.volume1, 0.5);
    });
  });
}
```

Run tests:
```bash
flutter test
```

### Widget Tests

Create `test/widgets/deck_widget_test.dart`:

```dart
void main() {
  testWidgets('DeckWidget displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DeckWidget(
            deckNumber: 1,
            isPlaying: false,
            duration: Duration.zero,
            position: Duration.zero,
            onPlayPause: () {},
            onStop: () {},
            onSeek: (_) {},
          ),
        ),
      ),
    );
    
    expect(find.text('Deck 1'), findsOneWidget);
  });
}
```

## Performance Optimization

### Memory Management

1. **Dispose Resources**:
```dart
@override
void dispose() {
  _audioPlayer1.dispose();
  _audioPlayer2.dispose();
  super.dispose();
}
```

2. **Use Const Constructors**:
```dart
const DeckWidget(...)  // Prevents unnecessary rebuilds
```

3. **Lazy Loading**:
```dart
late AudioPlayer _audioPlayer;  // Initialized only when needed
```

### UI Performance

1. **Use Consumer Selectively**:
```dart
Consumer<AudioProvider>(
  builder: (context, audioProvider, child) {
    // Only rebuild when audioProvider changes
  },
)
```

2. **Avoid Rebuilding Entire Tree**:
```dart
// Good: Only rebuild specific widget
Consumer<AudioProvider>(
  builder: (context, audioProvider, _) {
    return Text('${audioProvider.volume1}');
  },
)

// Bad: Rebuilds entire screen
if (audioProvider.volume1 > 0.5) {
  // Rebuild logic
}
```

## Platform-Specific Development

### Windows-Specific Code

Create `lib/utils/windows_utils.dart`:

```dart
import 'dart:io';

class WindowsUtils {
  static bool isWindows() => Platform.isWindows;
  
  static Future<String?> selectAudioFile() async {
    // Windows file picker implementation
  }
}
```

### Android-Specific Code

Create `lib/utils/android_utils.dart`:

```dart
import 'dart:io';

class AndroidUtils {
  static bool isAndroid() => Platform.isAndroid;
  
  static Future<bool> requestPermissions() async {
    // Android permission handling
  }
}
```

## Debugging

### Enable Debug Logging

```dart
void main() {
  debugPrintBeginFrame = true;
  debugPrintEndFrame = true;
  runApp(const MyApp());
}
```

### Use DevTools

```bash
flutter pub global activate devtools
flutter pub global run devtools
```

### Hot Reload

```bash
flutter run
# Press 'r' for hot reload
# Press 'R' for hot restart
```

## Building and Distribution

### Windows Build

```bash
flutter build windows --release
```

Output: `build/windows/runner/Release/new_fly_mixxxx.exe`

### Android Build

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Code Signing (Android)

1. Create keystore:
```bash
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

2. Sign APK:
```bash
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore ~/key.jks app-release-unsigned.apk key
```

## Future Enhancements

### Phase 1: Core Features
- [ ] Waveform visualization
- [ ] Cue points and hot cues
- [ ] Loop functionality
- [ ] Playlist management

### Phase 2: Advanced Features
- [ ] Audio effects (reverb, delay, echo)
- [ ] Recording capability
- [ ] Skin customization
- [ ] MIDI controller support

### Phase 3: Professional Features
- [ ] Multi-deck support (4+ decks)
- [ ] Sampler functionality
- [ ] Advanced effects chain
- [ ] Sync with external devices

### Phase 4: Community Features
- [ ] Cloud sync
- [ ] Preset sharing
- [ ] Community presets
- [ ] Social features

## Troubleshooting Development

### Issue: Hot reload not working
- Solution: Use hot restart (`R` key)
- Check for syntax errors

### Issue: State not updating
- Solution: Ensure `notifyListeners()` is called
- Check Consumer widget is properly connected

### Issue: Audio not playing
- Solution: Check permissions (Android)
- Verify audio file path
- Check audio player initialization

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [just_audio Package](https://pub.dev/packages/just_audio)
- [Flutter Best Practices](https://flutter.dev/docs/testing/best-practices)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is provided as-is for personal and commercial use.

---

**Fly Mixxx** - Developer Guide v1.0
