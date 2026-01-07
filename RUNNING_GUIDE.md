# 🚀 Инструкция по запуску приложения

## Быстрый старт

### Для разработки (Debug режим)

#### На Windows:
```powershell
cd C:\Users\strog\StudioProjects\new_fly_mixxxx
flutter run -d windows
```

#### На Android (через Android Studio):
```bash
flutter run
```

### Для продакшена (Release режим)

#### Windows:
```powershell
cd C:\Users\strog\StudioProjects\new_fly_mixxxx
flutter build windows --release
# Исполняемый файл: build\windows\x64\runner\Release\new_fly_mixxxx.exe
```

#### Android:
```bash
flutter build apk --release
# APK файл: build\app\outputs\flutter-apk\app-release.apk
```

#### macOS:
```bash
flutter build macos --release
# Приложение: build/macos/Build/Products/Release/new_fly_mixxxx.app
```

#### Linux:
```bash
flutter build linux --release
# Исполняемый файл: build/linux/x64/release/bundle/new_fly_mixxxx
```

## Запуск тестов

### Все тесты:
```bash
flutter test
```

### Только тесты RotaryKnobWidget:
```bash
flutter test test/widgets/rotary_knob_widget_test.dart
```

### С verbose выводом:
```bash
flutter test --verbose
```

### С покрытием кода:
```bash
flutter test --coverage
```

## Системные требования

### Для разработки:
- **Flutter:** 3.0+
- **Dart:** 3.0+
- **VS Code/Android Studio:** Последняя версия
- **Windows:** 10/11 (для Windows разработки)
- **macOS:** 10.15+ (для macOS разработки)
- **Linux:** Ubuntu 20.04+ (для Linux разработки)

### Для запуска собранного приложения:
- **Windows:** Windows 10/11 (встроенный Visual C++ Runtime)
- **Android:** Android 5.0+ (API 21+)
- **macOS:** macOS 10.15+
- **Linux:** Ubuntu 20.04+

## Структура проекта

```
lib/
├── main.dart                          # Точка входа приложения
├── models/                            # Модели данных
│   ├── eq_preset_model.dart          # Модель EQ пресета
│   └── ...
├── providers/                         # State management (Provider)
│   ├── audio_provider.dart           # Основной аудио провайдер
│   └── ...
├── screens/                           # Экраны приложения
│   ├── main_screen.dart              # Главный экран
│   └── ...
├── widgets/                           # Пользовательские виджеты
│   ├── rotary_knob_widget.dart       # Ротарная ручка ✓ ИСПРАВЛЕНО
│   ├── frequency_response_widget.dart # Частотная характеристика
│   └── ...
└── utils/                             # Утилиты и константы
    ├── constants.dart
    └── ...

test/
├── widgets/
│   ├── rotary_knob_widget_test.dart  # Тесты ротарной ручки (38 тестов)
│   └── ...
├── providers/
└── ...
```

## Основные функции приложения

### 🎚️ Ротарные ручки (RotaryKnobWidget) - ✓ ИСПРАВЛЕНО
- Плавное вращение курсором мыши
- Преобразование глобальных координат в локальные
- Диапазон углов: -135° до +135°
- Поддержка значений с плавающей точкой

### 🎛️ Эквалайзер (10-полосный)
- Быстрое управление через ротарные ручки
- Сохранение пресетов
- Управление жанрами музыки

### 📊 Анализ частотного ответа
- АЧХ (Амплитудно-частотная характеристика)
- ФЧХ (Фазо-частотная характеристика)
- Диаграмма Боде

### 🎵 Загрузка и воспроизведение треков
- Загрузка музыки с помощью file_picker
- Поддержка различных форматов (MP3, WAV, FLAC и т.д.)
- История воспроизведения

## Решение проблем

### Проблема: "Build failed" при компиляции
**Решение:**
```bash
flutter clean
flutter pub get
flutter build windows
```

### Проблема: "No named parameter with the name 'localPosition'"
**Статус:** ✅ ИСПРАВЛЕНО в версии 1.0.0
- Используется правильное преобразование координат через `RenderBox.globalToLocal()`
- Все тесты пройдены успешно (38/38)

### Проблема: Невозможно запустить приложение на Windows
**Решение:**
1. Убедитесь, что установлен Visual Studio Build Tools
2. Запустите `flutter doctor -v` для проверки окружения
3. Выполните `flutter clean` и пересоберите проект

### Проблема: "SDK version is not compatible"
**Решение:**
```bash
flutter upgrade
flutter pub get
```

## Отладка

### Просмотр логов:
```bash
flutter logs
```

### Отладка на Windows:
```bash
flutter run -d windows --dart-define=FLUTTER_WEB_CANVASKIT_URL=canvaskit/
```

### Профилирование производительности:
```bash
flutter run --profile
```

## Развертывание

### Подготовка к релизу:
1. Обновить версию в `pubspec.yaml`
2. Убедитесь, что все тесты проходят
3. Обновить `CHANGELOG.md`

### Создание релиза для Windows:
```bash
flutter build windows --release --verbose
# Готовый exe: build\windows\x64\runner\Release\new_fly_mixxxx.exe
```

### Создание релиза для Android (Play Store):
```bash
flutter build appbundle --release
# Готовый файл: build\app\outputs\bundle\release\app-release.aab
```

## Поддержка и помощь

### Ссылки:
- [Flutter документация](https://flutter.dev/docs)
- [Dart документация](https://dart.dev/guides)
- [GitHub репозиторий проекта](https://github.com/yourusername/new_fly_mixxxx)

### Отчет об ошибках:
Пожалуйста, создавайте issues на GitHub с описанием:
1. Платформы и версии OS
2. Версии Flutter и Dart
3. Шагов воспроизведения ошибки
4. Ожидаемого результата

---

**Последнее обновление:** 7 января 2026
**Версия:** 1.0.0

