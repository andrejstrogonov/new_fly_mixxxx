# 👨‍💻 Developer Documentation - Fly Mixxx

## 🏗️ Архитектура проекта

### MVC Pattern (Modified)
```
┌─────────────────────────────────────────────────────────┐
│                    UI Layer (Widgets)                   │
│  mixer_screen.dart, deck_widget.dart, etc.              │
└────────────────┬────────────────────────────────────────┘
                 │
┌─────────────────────────────────────────────────────────┐
│              Business Logic (Provider)                  │
│        audio_provider.dart - AudioProvider              │
└────────────────┬────────────────────────────────────────┘
                 │
┌─────────────────────────────────────────────────────────┐
│        Data Layer (Services & Models)                   │
│  just_audio, file_picker, Track model                  │
└─────────────────────────────────────────────────────────┘
```

---

## 📁 Структура файлов

```
lib/
├── main.dart                          # Точка входа, MultiProvider
├── screens/
│   └── mixer_screen.dart              # Главный экран (SingleChildScrollView)
├── providers/
│   └── audio_provider.dart            # ChangeNotifier + AudioPlayer + Queue Logic
└── widgets/
    ├── deck_widget.dart               # Дек (воспроизведение, громкость, прогресс)
    ├── mixer_controls_widget.dart     # Кроссфейдер, BPM, Master Volume
    ├── equalizer_widget.dart          # 10-полосный EQ
    ├── eq_preset_carousel_widget.dart # ✨ Карусель EQ предустановок жанров
    ├── presets_widget.dart            # (Deprecated) Управление предустановками
    ├── frequency_response_widget.dart  # АЧХ и ФЧХ графики
    └── track_loader_widget.dart       # Загрузка и очереди
```

---

## 🎯 Основные компоненты

### 1. AudioProvider (lib/providers/audio_provider.dart)

**Ответственность**:
- Управление двумя AudioPlayer экземплярами
- Управление очередями треков
- Управление эквалайзером
- Расчеты частотной характеристики

**Ключевые поля**:
```dart
late AudioPlayer _audioPlayer1;
late AudioPlayer _audioPlayer2;

final List<Track> _queue1 = [];
final List<Track> _queue2 = [];
int _currentTrackIndex1 = -1;
int _currentTrackIndex2 = -1;

final List<double> _eqBands = List.filled(10, 0.0);
double _crossfaderPosition = 0.5;
double _masterVolume = 0.8;
```

**Основные методы**:
```dart
// Audio control
Future<void> playPause1()
Future<void> playPause2()
Future<void> loadTrack1(String path)
Future<void> loadTrack2(String path)

// Queue management
bool addTrackToQueue1(Track track)
Future<void> playTrackFromQueue1(int index)
void removeTrackFromQueue1(int index)

// EQ control
void setEqBand(int index, double value)
void applyPreset(String presetName)
```

### 2. Track Model

```dart
class Track {
  final String id;        // Уникальный идентификатор
  final String name;      // Имя файла
  final String path;      // Полный путь к файлу
  final Duration? duration; // Длительность трека
}
```

### 3. TrackLoaderWidget (lib/widgets/track_loader_widget.dart)

**Функции**:
- Отображение очередей обоих деков
- Кнопки для добавления треков/папок
- Список треков в очереди с контролями

**Методы**:
```dart
Future<void> _selectAndAddTrack()    // Выбор одного файла
Future<void> _selectAndAddFolder()   // Выбор папки
void _showSnackBar(String message)   // Уведомления
String _formatDuration()             // Форматирование времени
```

---

## 🔄 Поток данных (Data Flow)

### Загрузка трека из очереди

```
TrackLoaderWidget
    │
    ├─ onPlayTrack(index)
    │       │
    │       └─> audioProvider.playTrackFromQueue1(index)
    │               │
    │               ├─> _currentTrackIndex1 = index
    │               ├─> loadTrack1(_queue1[index].path)
    │               │       │
    │               │       └─> _audioPlayer1.setFilePath(path)
    │               │
    │               ├─> playPause1()
    │               │       │
    │               │       └─> _audioPlayer1.play()
    │               │
    │               └─> notifyListeners()
    │
    └─> Consumer<AudioProvider> перестраивает UI
```

### Управление громкостью

```
DeckWidget (Slider)
    │
    └─> onChanged(volume)
        │
        └─> audioProvider.setVolume1(volume)
                │
                ├─> _volume1 = volume.clamp(0.0, 1.0)
                ├─> _updateCrossfaderVolumes()
                │       │
                │       └─> _audioPlayer1.setVolume(...)
                │
                └─> notifyListeners()
                    │
                    └─> UI обновляется через Consumer
```

---

## 🎨 UI Hierarchy

```
Scaffold
├── AppBar
│   └── "Fly Mixxx - DJ Mixer"
│
└── Body: SingleChildScrollView
    └── Column
        ├── TrackLoaderWidget (✨ НОВОЕ)
        │   ├── Deck 1 Queue
        │   │   ├── Track List
        │   │   ├── Add Track Button
        │   │   └── Add Folder Button
        │   │
        │   └── Deck 2 Queue
        │       ├── Track List
        │       ├── Add Track Button
        │       └── Add Folder Button
        │
        ├── Row (Decks)
        │   ├── DeckWidget (1)
        │   │   ├── Track Info
        │   │   ├── Progress Bar
        │   │   ├── Controls (Play/Stop)
        │   │   └── Volume Slider
        │   │
        │   └── DeckWidget (2)
        │       ├── Track Info
        │       ├── Progress Bar
        │       ├── Controls (Play/Stop)
        │       └── Volume Slider
        │
        ├── MixerControlsWidget
        │   ├── Crossfader
        │   ├── BPM Control
        │   └── Master Volume
        │
        ├── EqualizerWidget
        │   ├── EQ Sliders (10 bands)
        │   └── Preset Buttons
        │
        ├── PresetsWidget
        │   └── Preset Selection Buttons
        │
        └── FrequencyResponseWidget
            ├── АЧХ Chart (Amplitude)
            └── ФЧХ Chart (Phase)
```

---

## 💾 State Management (Provider Pattern)

### Как это работает

1. **AudioProvider наследует ChangeNotifier**:
```dart
class AudioProvider extends ChangeNotifier { ... }
```

2. **MultiProvider в main.dart**:
```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AudioProvider()),
  ],
  child: MaterialApp(...),
)
```

3. **Consumer в виджетах**:
```dart
Consumer<AudioProvider>(
  builder: (context, audioProvider, _) {
    return Text('Volume: ${audioProvider.volume1}');
  },
)
```

4. **notifyListeners() для обновления**:
```dart
void setVolume1(double value) {
  _volume1 = value.clamp(0.0, 1.0);
  _updateCrossfaderVolumes();
  notifyListeners(); // ← Обновляет все Consumer'ы
}
```

---

## 🎵 Поддерживаемые форматы

```dart
const audioExtensions = ['.mp3', '.wav', '.flac', '.m4a', '.aac'];
```

**file_picker интеграция**:
```dart
final result = await FilePicker.platform.pickFiles(
  type: FileType.audio,
  allowMultiple: false,
);
```

---

## 🔧 Зависимости

| Пакет | Версия | Назначение |
|-------|--------|-----------|
| `just_audio` | ^0.9.36 | Воспроизведение аудио |
| `audio_session` | ^0.1.16 | Управление аудио сессией |
| `provider` | ^6.0.0 | State management |
| `fl_chart` | ^0.65.0 | Графики (АЧХ, ФЧХ) |
| `file_picker` | ^5.4.0 | Выбор файлов/папок |

---

## 🚀 Как добавить новую функцию

### Пример: Добавить кнопку "Shuffle"

#### 1. Добавить метод в AudioProvider

```dart
void toggleShuffle1() {
  _isShuffled1 = !_isShuffled1;
  notifyListeners();
}
```

#### 2. Добавить getter

```dart
bool get isShuffled1 => _isShuffled1;
```

#### 3. Использовать в виджете

```dart
Consumer<AudioProvider>(
  builder: (context, audioProvider, _) {
    return IconButton(
      onPressed: () => audioProvider.toggleShuffle1(),
      icon: Icon(
        audioProvider.isShuffled1 ? Icons.shuffle : Icons.shuffle_on,
      ),
    );
  },
)
```

---

## 🧪 Тестирование

### Запуск анализа кода
```bash
dart analyze lib/
```

### Запуск приложения
```bash
flutter run -d windows --debug
```

### Профилирование производительности
```bash
flutter run -d windows --profile
```

### Сборка релиза
```bash
flutter build windows --release
```

---

## 🎨 UI/UX Компоненты

### EQPresetCarouselWidget (✨ NEW)

Карусель для переключения EQ предустановок жанров музыки.

**Особенности**:
- Компактный дизайн (экономит ~40% пространства)
- Анимированная 3D карусель при прокрутке
- 9 предустановок жанров: Flat, Tango, Jazz, Folk, Waltz, Bass/Treble Boost, Vocal
- Навигация: свайп или клик на точки-индикаторы
- Автоматическое применение preset при прокрутке

**Использование**:
```dart
const EQPresetCarouselWidget()
```

Подробнее: [EQ_PRESET_CAROUSEL.md](EQ_PRESET_CAROUSEL.md)

---

## 🐛 Отладка

### Включить debug логи
```dart
// В AudioProvider
debugPrint('Loading track: $path');
```

### DevTools
```bash
flutter pub global activate devtools
devtools
```

---

## 📚 Полезные ссылки

- **Flutter Docs**: https://flutter.dev/docs
- **Provider Package**: https://pub.dev/packages/provider
- **just_audio**: https://pub.dev/packages/just_audio
- **file_picker**: https://pub.dev/packages/file_picker
- **fl_chart**: https://pub.dev/packages/fl_chart

---

## 🎯 Лучшие практики

1. **State Management**: Всегда используйте Provider для глобального состояния
2. **Производительность**: Избегайте перестроения больших виджетов
3. **Обработка ошибок**: Оборачивайте I/O операции в try-catch
4. **Ресурсы**: Правильно освобождайте AudioPlayer в dispose()
5. **Код**: Следуйте Dart code style guidelines

---

**Версия документации**: 1.0  
**Последнее обновление**: Январь 2026

