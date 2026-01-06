# Fly Mixxx - DJ Mixer Application

> **⭐ Начните здесь:** [START_HERE.md](START_HERE.md) ← Прочитайте это первым!

Профессиональное DJ-микшерное приложение с поддержкой эквалайзера, анализа частотной характеристики и AI-генерации композиций.

## ⚡ Быстрый старт

### Для пользователей
Начните здесь: [docs/user/QUICK_START.md](docs/user/QUICK_START.md)
- [Как установить приложение](docs/user/QUICK_START.md)
- [Основные возможности](docs/user/USAGE.md)
- [Решение проблем](docs/user/TROUBLESHOOTING.md)

### Для разработчиков
Начните с подготовки окружения: [docs/developer/SETUP.md](docs/developer/SETUP.md)

Также посмотрите:
- [Правила вклада](docs/developer/CONTRIBUTING.md) — как помочь проекту
- [Архитектура кода](docs/developer/ARCHITECTURE.md) — структура проекта
- [Решение проблем разработки](docs/developer/TROUBLESHOOTING.md) — типичные ошибки
- [Deployment guide](docs/developer/DEPLOYMENT.md) — как собрать и выпустить приложение

## 🎯 Основные возможности

- **🎚️ Микшер**: Работа с несколькими аудио дорожками одновременно
- **🎛️ 10-полосный EQ**: С предустановками для разных жанров (Bass Boost, Treble, и др.)
- **🎪 EQ Preset Carousel**: Компактная карусель с 9 жанрами (Tango, Jazz, Folk, и др.) ✨ NEW
- **📊 Частотная характеристика**: АЧХ, ФЧХ, диаграмма Боде
- **🔍 Анализ оборудования**: Определение параметров аудиоустройств
- **🤖 AI Композиции**: Генерирование мелодий через нейросеть API
- **💾 Экспорт**: Сохранение миксов в WAV формате
- **⚙️ Эффекты**: Встроенные аудиоэффекты в реальном времени

## 🛠️ Установка и запуск

### Общие требования
- Flutter SDK >= 3.0.0
- Dart >= 3.0.0
- Для Windows: Visual C++ Redistributable
- Для Android: Android 5.0+ (API 21+)

### Быстрая подготовка (разработка)
```bash
# Получить зависимости
flutter pub get

# Запустить приложение
flutter run -d windows          # Windows
flutter run -d android          # Android
```

Для полной информации см. [RUN_APP.md](RUN_APP.md)

## 🎪 Что нового в v0.2.0

### ✨ EQ Preset Carousel
Компактный компонент для быстрого переключения между 9 жанрами музыки:

**Преимущества:**
- 🎨 **Компактный дизайн** - экономит ~40% пространства
- 🔄 **Красивые анимации** - 3D эффекты при прокрутке
- 👆 **Интуитивная навигация** - свайп или клик на точки
- 📝 **Информативность** - название, описание и статус

**Доступные жанры:**
Flat, Tango, Jazz, Folk Argentino, Folk Russian, Cross-step Waltz, Bass Boost, Treble Boost, Vocal

Подробнее: [EQ_PRESET_CAROUSEL.md](docs/developer/EQ_PRESET_CAROUSEL.md)

## 📁 Структура проекта

```
lib/
├── main.dart                     # Точка входа
├── screens/
│   └── mixer_screen.dart         # Главный экран
├── widgets/                      # Переиспользуемые компоненты UI
│   ├── frequency_response_widget.dart
│   ├── equalizer_widget.dart
│   ├── eq_preset_carousel_widget.dart  # ✨ NEW: Карусель жанров
│   ├── mixer_controls_widget.dart
│   ├── deck_widget.dart
│   └── ...
├── providers/                    # State Management (Provider)
│   ├── audio_provider.dart
│   ├── audio_device_analyzer.dart
│   └── composition_generator.dart
└── models/                       # Модели данных

docs/
├── developer/                    # Для разработчиков
│   ├── SETUP.md
│   ├── CONTRIBUTING.md
│   ├── ARCHITECTURE.md
│   ├── EQ_PRESET_CAROUSEL.md     # ✨ NEW: Документация для новой фичи
│   ├── TROUBLESHOOTING.md
│   └── DEPLOYMENT.md
└── user/                         # Для пользователей
    ├── QUICK_START.md
    ├── USAGE.md
    ├── FEATURES.md
    └── TROUBLESHOOTING.md
```

## 🚀 Запуск для разработки

### VS Code
1. Откройте папку проекта
2. F5 (Debug) или Ctrl+Shift+D и выберите конфигурацию
3. Доступные конфигурации в `.vscode/launch.json`:
   - Flutter (Debug - Windows)
   - Flutter (Debug - Android)
   - Flutter (Release - Windows)
   - и др.

### Android Studio
1. Откройте проект
2. Выберите целевое устройство
3. Нажмите Shift+F10 (Run) или Ctrl+F5 (Debug)

### Командная строка
```bash
flutter run                      # Все устройства
flutter run -d windows          # Windows
flutter run --release           # Release сборка
```

## 📦 Зависимости

Основные пакеты:
- **provider** — управление состоянием (State Management)
- **just_audio** — воспроизведение аудио
- **fl_chart** — графики и диаграммы
- **file_picker** — выбор файлов
- **http/dio** — сетевые запросы для API
- **win32** — нативные вызовы Windows

## 🔨 Сборка для production

### Windows EXE
```bash
flutter build windows --release
# Выход: build/windows/x64/Release/new_fly_mixxxx.exe
```

### Android APK/AAB
```bash
flutter build apk --release       # APK для прямой установки
flutter build aab --release       # App Bundle для Google Play
```

Полная инструкция: [docs/developer/DEPLOYMENT.md](docs/developer/DEPLOYMENT.md)

## 🐛 Решение проблем

### Быстрые команды
```bash
flutter clean                    # Очистить кэш
flutter pub get                  # Получить зависимости
flutter analyze                  # Проверить код
flutter doctor -v                # Диагностика окружения
```

Подробнее:
- [Решение проблем для пользователей](docs/user/TROUBLESHOOTING.md)
- [Решение проблем для разработчиков](docs/developer/TROUBLESHOOTING.md)

## 📚 Документация

**Для пользователей:**
- [Быстрый старт](docs/user/QUICK_START.md)
- [Как использовать приложение](docs/user/USAGE.md)
- [Решение проблем](docs/user/TROUBLESHOOTING.md)

**Для разработчиков:**
- [Настройка окружения](docs/developer/SETUP.md)
- [Архитектура приложения](docs/developer/ARCHITECTURE.md)
- [Правила вклада](docs/developer/CONTRIBUTING.md)
- [Решение проблем разработки](docs/developer/TROUBLESHOOTING.md)
- [Сборка и развёртывание](docs/developer/DEPLOYMENT.md)

**Общие гайды:**
- [Как запустить приложение](RUN_APP.md)

## 🤝 Вклад в проект

Хотите помочь? Посмотрите [CONTRIBUTING.md](docs/developer/CONTRIBUTING.md)

Краткие правила:
1. Fork репозитория
2. Создайте feature ветку: `git checkout -b feature/awesome-feature`
3. Commit изменений: `git commit -m 'Add awesome feature'`
4. Push в ветку: `git push origin feature/awesome-feature`
5. Откройте Pull Request

## 📄 Лицензия

MIT License — см. [LICENSE](LICENSE) файл

## 📞 Контакт и поддержка

Если у вас возникли вопросы:
- Создайте Issue в репозитории
- Посмотрите раздел "Решение проблем" в документации
- Свяжитесь через GitHub Discussions

## 📝 Версионирование

Текущая версия: **1.0.0**

Следуем [Semantic Versioning](https://semver.org/):
- MAJOR (1.0.0) — несовместимые изменения
- MINOR (0.1.0) — новые функции
- PATCH (0.0.1) — исправления ошибок

## 🎓 Полезные ресурсы

- [Flutter документация](https://flutter.dev/docs)
- [Dart документация](https://dart.dev/guides)
- [Provider package](https://pub.dev/packages/provider)
- [Just Audio package](https://pub.dev/packages/just_audio)
- [FL Chart package](https://pub.dev/packages/fl_chart)

---

Спасибо что вы используете Fly Mixxx! 🎵

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
