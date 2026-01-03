Настройка окружения для разработки (Windows)

## Системные требования

- **ОС**: Windows 10 или новее (x64)
- **Flutter SDK**: версия >=3.0.0
- **Dart SDK**: идёт вместе с Flutter
- **Android Studio** или **VS Code** с расширением Flutter
- **Visual Studio Build Tools 2019+** (для Windows-сборки) или полный Visual Studio

## Минимальные шаги установки

### 1. Установка Flutter

1. Скачайте Flutter с https://flutter.dev
2. Распакуйте в папку без пробелов (например, `C:\flutter`)
3. Добавьте `C:\flutter\bin` в переменную окружения PATH
4. Откройте новый терминал и проверьте:
```bash
flutter doctor
```
Исправьте все требуемые зависимости, следуя советам `flutter doctor`.

### 2. Получение зависимостей

В корне проекта:
```bash
cd C:\Users\strog\StudioProjects\new_fly_mixxxx
flutter pub get
```

### 3. Выбор целевой платформы и IDE

#### Для VS Code:
1. Установите расширения:
   - Flutter (Dart Code)
   - Dart
2. Откройте папку проекта
3. Откройте `RUN_APP.md` или используйте конфигурации в `.vscode/launch.json`

#### Для Android Studio:
1. Откройте проект (File > Open)
2. Дождитесь индексации проекта
3. Выберите целевое устройство в правом верхнем углу
4. Нажмите зелёную кнопку Run (Shift+F10)

## Запуск в режиме разработки

### Windows (командная строка)
```bash
flutter run -d windows
```

### Android (физическое устройство или эмулятор)
```bash
# Списка доступных устройств
flutter devices

# Запуск
flutter run -d android
```

### Все платформы
```bash
flutter run
```

## Windows-специфичные советы

- **LNK1168 ошибка (файл .exe занят)**: перед билдом завершите работающий процесс приложения. В репозитории есть скрипт `scripts/kill_windows_exe.ps1` который завершит исполняемый файл по имени проекта.
  ```bash
  .\scripts\kill_windows_exe.ps1 -exeName "new_fly_mixxxx"
  ```
- **Ошибки с пакетом win32**: обновите Flutter/Dart до актуальной стабильной версии или используйте совместимую версию пакета (см. docs/developer/TROUBLESHOOTING.md).
- **Visual Studio Build Tools не найден**: убедитесь что установлены C++ build tools. Скачайте с https://visualstudio.microsoft.com/downloads/

## Расширенные команды

```bash
# Запуск с подробным логированием
flutter run --verbose

# Запуск в режиме Release (оптимизированный)
flutter run --release

# Сборка без запуска
flutter build windows    # Windows
flutter build apk        # Android APK
flutter build aab        # Android App Bundle

# Очистка кэша
flutter clean

# Статический анализ кода
flutter analyze
```

## Если что-то не получается

1. Создайте issue с выводом `flutter doctor -v`
2. Приложите скриншот ошибки из консоли
3. Укажите что вы пробовали исправить
4. Посмотрите `docs/developer/TROUBLESHOOTING.md`
