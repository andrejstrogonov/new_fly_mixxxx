# Developer Setup Guide

## Требования

- **Flutter SDK**: 3.0.0 или выше
- **Dart SDK**: 3.0.0 или выше
- **Android SDK**: API 21 или выше (для Android разработки)
- **Xcode**: 13.0 или выше (для iOS разработки)
- **Visual Studio 2022**: для Windows разработки
- **Git**: для управления версиями

## Установка

### 1. Клонирование репозитория

```bash
git clone https://github.com/your-repo/new_fly_mixxxx.git
cd new_fly_mixxxx
```

### 2. Установка зависимостей

```bash
flutter pub get
```

### 3. Генерация кода (если необходимо)

```bash
flutter pub run build_runner build
```

## Конфигурация IDE

### Android Studio / IntelliJ IDEA

1. Откройте проект в Android Studio
2. Android Studio автоматически определит Flutter SDK
3. Подождите завершения индексирования проекта

### VS Code

Установите расширения:

- **Dart**: официальное расширение для Dart
- **Flutter**: официальное расширение для Flutter

## Запуск на разных платформах

### Windows (Desktop)

```bash
# Список доступных Windows devices
flutter devices

# Запуск на Windows
flutter run -d windows

# Запуск в release режиме
flutter run -d windows --release

# Build
flutter build windows
```

### Android

```bash
# Запуск на Android эмуляторе
flutter run -d emulator

# Запуск на физическом устройстве
flutter run -d <device-id>

# Build APK
flutter build apk

# Build App Bundle
flutter build appbundle
```

### iOS

```bash
# Запуск на iOS эмуляторе
flutter run -d ios

# Запуск на физическом устройстве
flutter run -d <device-id>

# Build
flutter build ios
```

## Тестирование

### Запуск всех тестов

```bash
flutter test
```

### Запуск конкретного теста

```bash
flutter test test/presentation/viewmodels/base_viewmodel_test.dart
```

### С покрытием кода

```bash
flutter test --coverage
```

Результат будет в `coverage/lcov.info`

## Troubleshooting

### Ошибка: "Flutter SDK not found"

```bash
# Установите Flutter SDK
# https://flutter.dev/docs/get-started/install

# Добавьте Flutter в PATH
export PATH="$PATH:/path/to/flutter/bin"
```

### Ошибка: "Android SDK not found"

```bash
# Установите Android SDK через Android Studio или:
flutter doctor --android-licenses
```

### Ошибка: "Build failed on Windows"

```bash
# Очистите build директорию
flutter clean

# Обновите зависимости
flutter pub get

# Пересоберите
flutter build windows
```

### Ошибка: "LNK1168: cannot open file"

```powershell
# Убейте все процессы приложения
taskkill /F /IM new_fly_mixxxx.exe

# Очистите build
flutter clean
```

## Форматирование кода

### Автоматическое форматирование

```bash
flutter format lib/ test/
```

### Анализ кода

```bash
flutter analyze
```

### Используемые правила

Правила определены в `analysis_options.yaml`

## Git Workflow

### Создание веток

```bash
# Feature branch
git checkout -b feature/feature-name

# Bugfix branch
git checkout -b bugfix/bug-name
```

### Коммиты

```bash
# Следуйте conventional commits
git commit -m "feat: add new feature"
git commit -m "fix: resolve issue"
git commit -m "test: add tests"
```

### Push changes

```bash
git push origin feature/feature-name
```

## Documentation

Документация находится в:

- **Developer Guide**: `docs/developer/`
- **User Guide**: `docs/user/`
- **API Documentation**: встроенная в код

## Профилирование производительности

### Flutter DevTools

```bash
flutter pub global activate devtools
devtools
```

Затем откройте `http://localhost:9100` в браузере.

### Профилирование памяти

```bash
flutter run --profile
# Откройте DevTools -> Memory tab
```

### Профилирование производительности

```bash
flutter run --profile
# Откройте DevTools -> Performance tab
```

## Release Process

### Android

```bash
# Подготовка к релизу
flutter build appbundle --release

# Загрузка на Google Play Store
# Используйте Play Console: https://play.google.com/console
```

### Windows

```bash
# Build для распространения
flutter build windows --release

# Файлы будут в: build/windows/x64/runner/Release/
```

### iOS

```bash
# Подготовка к релизу
flutter build ios --release

# Загрузка на App Store
# Используйте Xcode или Application Loader
```

## Дополнительные команды

```bash
# Показать информацию о Flutter установке
flutter doctor -v

# Очистить все кэши
flutter clean

# Обновить Flutter SDK
flutter upgrade

# Получить информацию о зависимостях
flutter pub outdated

# Обновить зависимости
flutter pub upgrade

# Получить конкретную версию пакета
flutter pub get --no-precompile
```

