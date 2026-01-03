# Руководство по запуску приложения Fly Mixxx

## Требования

- Flutter SDK (версия >=3.0.0)
- Dart SDK (идёт с Flutter)
- Android Studio / VS Code с расширением Flutter
- (Для Windows) Visual Studio Build Tools 2019 или новее

## Быстрый старт

### 1. Подготовка окружения

```bash
# Проверить установку Flutter
flutter doctor

# Получить зависимости
flutter pub get

# Обновить зависимости (если нужно)
flutter pub upgrade
```

### 2. Запуск в режиме разработки

#### Вариант А: Командная строка (PowerShell/Command Prompt)

```bash
# Запуск на Windows
flutter run -d windows

# Запуск на Android (если подключено устройство или эмулятор)
flutter run -d android

# Запуск в режиме Hot Reload
flutter run
```

#### Вариант Б: VS Code

1. Откройте папку проекта в VS Code
2. Перейдите на вкладку "Run and Debug" (Ctrl+Shift+D)
3. Выберите конфигурацию:
   - **Flutter (Debug - Windows)** — для Windows в режиме debug
   - **Flutter (Debug - Android)** — для Android в режиме debug
   - **Flutter (Debug - All Devices)** — для всех доступных устройств
4. Нажмите кнопку "Start Debugging" (F5)

#### Вариант В: Android Studio

1. Откройте проект в Android Studio
2. Выберите целевое устройство (Windows / Android)
3. Нажмите зелёную кнопку "Run" (Shift+F10)
4. Или используйте меню **Run > Run 'main.dart'**

### 3. Доступные команды

```bash
# Запуск с определённым уровнем логирования
flutter run --verbose

# Запуск на конкретном устройстве
flutter run -d windows
flutter run -d android

# Запуск в режиме Release (оптимизированный)
flutter run --release

# Сборка приложения без запуска
flutter build windows    # Для Windows
flutter build apk        # Для Android (APK)
flutter build aab        # Для Android (App Bundle)

# Очистка кэша и пересборка
flutter clean
flutter pub get
flutter run
```

## Решение типичных проблем

### Проблема: "flutter: command not found"

**Решение**: Добавьте Flutter в переменную окружения PATH:
- Windows: Добавьте `C:\path\to\flutter\bin` в PATH
- Перезагрузите терминал

### Проблема: "No Android devices/emulators available"

**Решение**:
```bash
# Проверить список доступных устройств
flutter devices

# Создать или запустить эмулятор Android
flutter emulators
flutter emulators launch Pixel_4_API_30

# Или подключить физический Android-девайс с включённым USB Debug
```

### Проблема: "Windows SDK not found" или ошибки сборки Windows

**Решение**:
```bash
# Запустить flutter doctor и следовать его рекомендациям
flutter doctor -v

# Убедиться что установлен Visual Studio Build Tools
# https://visualstudio.microsoft.com/downloads/

# Переустановить зависимости Windows
rm -r build/
flutter pub get
flutter run -d windows
```

### Проблема: "Hot Reload не работает"

**Решение**:
- Убедитесь что вы внесли изменения в `.dart` файл (не в нативный код)
- Попробуйте Hot Restart (Shift+R) вместо Hot Reload (R)
- Если не помогает, остановите приложение и запустите заново

### Проблема: "Build failed" с ошибками deprecated withOpacity

**Решение**: Уже исправлено в коде. Если ошибка сохраняется:
```bash
flutter clean
flutter pub get
flutter pub upgrade
flutter run
```

## Структура проекта

```
lib/
├── main.dart                    # Точка входа приложения
├── screens/
│   └── mixer_screen.dart        # Главный экран микшера
├── widgets/
│   ├── frequency_response_widget.dart    # Графики частотной характеристики
│   ├── equalizer_widget.dart             # Эквалайзер
│   ├── mixer_controls_widget.dart        # Управление микшером
│   ├── deck_widget.dart                  # Дека для трека
│   ├── track_loader_widget.dart          # Загрузка треков
│   └── ...
├── providers/
│   ├── audio_provider.dart      # State management для аудио
│   ├── audio_device_analyzer.dart
│   └── composition_generator.dart
└── models/
    ├── audio_device_model.dart
    └── composition_model.dart

build/           # Итоговые файлы сборки (git ignored)
windows/         # Нативный код для Windows
android/         # Нативный код для Android
```

## Конфигурация для разработки

- **.vscode/launch.json** — конфигурации для VS Code (Debug, Release, разные платформы)
- **.vscode/settings.json** — параметры форматирования и линтинга кода
- **analysis_options.yaml** — правила статического анализа Dart
- **pubspec.yaml** — зависимости и конфигурация проекта

## Развёртывание в production

### Для Windows

```bash
# Собрать Release-версию
flutter build windows --release

# Итоговый exe находится в:
# build/windows/x64/Release/new_fly_mixxxx.exe

# Для распространения: упакуйте папку build/windows/x64/Release в MSIX или архив
```

### Для Android

```bash
# Собрать APK
flutter build apk --release

# Собрать App Bundle (для Google Play)
flutter build aab --release

# Выходные файлы:
# build/app/outputs/flutter-apk/app-release.apk
# build/app/outputs/bundle/release/app-release.aab
```

## Дополнительные ресурсы

- [Flutter документация](https://flutter.dev/docs)
- [Dart документация](https://dart.dev/guides)
- [Provider package](https://pub.dev/packages/provider)
- [Just Audio package](https://pub.dev/packages/just_audio)
- [FL Chart package](https://pub.dev/packages/fl_chart)

## Связь и поддержка

Если у вас возникают проблемы:
1. Проверьте раздел "Решение типичных проблем" выше
2. Посмотрите `docs/developer/TROUBLESHOOTING.md`
3. Создайте Issue в репозитории с подробным описанием

