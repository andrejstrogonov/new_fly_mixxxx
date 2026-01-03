Решение распространённых проблем при разработке

## Проблемы при запуске

### "flutter: command not found"

**Причина**: Flutter не в PATH

**Решение**:
1. Найдите папку с Flutter (например, C:\flutter)
2. Откройте System Properties > Environment Variables
3. Добавьте `C:\flutter\bin` в переменную PATH
4. Перезагрузите терминал

### "No Android/Windows devices detected"

**Причина**: Целевое устройство не подключено

**Решение для Windows**:
- Windows приложение запускается прямо на ПК, просто выполните:
  ```bash
  flutter run -d windows
  ```

**Решение для Android**:
```bash
# Проверьте список устройств
flutter devices

# Если нет устройств, создайте эмулятор
flutter emulators
flutter emulators launch Pixel_4_API_30

# Или подключите физический девайс с USB Debug включённым
```

### "FAILURE: Build failed with exception"

**Если это ошибка `withOpacity`**:
```bash
flutter clean
flutter pub get
flutter pub upgrade
flutter run
```

**Если это ошибка Windows SDK**:
```bash
flutter doctor -v
# Следуйте рекомендациям, обновите необходимые компоненты
```

### "LNK1168: не удается открыть new_fly_mixxxx.exe для записи"

**Причина**: Приложение запущено из предыдущего хода сборки

**Решение**:
```bash
# Способ 1: Выполнить скрипт PowerShell
.\scripts\kill_windows_exe.ps1 -exeName "new_fly_mixxxx"

# Способ 2: Вручную завершить процесс в Task Manager
# Ctrl+Shift+Esc > найти new_fly_mixxxx.exe > End Task

# Способ 3: Перезагрузить ПК
```

## Проблемы при разработке

### Hot Reload не работает

**Причина**: Неподдерживаемые изменения (нативный код, инициализация)

**Решение**:
1. Нажмите `Shift+R` для Hot Restart (полная перезагрузка)
2. Если не помогает:
   ```bash
   flutter run
   # И нажимайте 'r' после сохранения файла
   ```

### "Unhandled Exception: MissingPluginException"

**Причина**: Плагин не инициализирован на платформе

**Решение**:
```bash
flutter clean
flutter pub get
flutter run
```

### Зависимость не загружается (file_picker и др.)

**Причина**: file_picker требует native реализации на каждой платформе

**Решение**:
```bash
# Удалите lockfile и переполучите зависимости
rm pubspec.lock
flutter pub get

# Если ошибки сохраняются, обновите file_picker
flutter pub upgrade file_picker
```

## Проблемы с компиляцией кода

### "The method 'pow' isn't defined" или "The method 'log' isn't defined"

**Причина**: Отсутствует импорт `dart:math`

**Решение**: Убедитесь что в файле есть строка:
```dart
import 'dart:math';
```

### "Type 'UnmodifiableUint8ListView' not found"

**Причина**: Несовместимость версии пакета win32 с версией Dart SDK

**Решение**:
```bash
# Обновите Flutter до последней стабильной версии
flutter upgrade

# Или откатите win32 на совместимую версию в pubspec.yaml
# win32: ^4.1.4

flutter pub get
```

### "Compilation failed with 123 errors"

**Обычно это зависит от множественных ошибок**

**Решение**:
```bash
flutter clean
flutter pub get
dart fix --apply
flutter run --verbose
```

## Проблемы при сборке Release

### "Flutter/Generated.xcconfig: No such file or directory" (iOS/macOS)

**Причина**: Неполная очистка

**Решение**:
```bash
flutter clean
flutter pub get
flutter build apk --release
```

### "keystore not found" (Android)

**Причина**: Ключ для подписи не сгенерирован

**Решение**:
```bash
# Создать ключ (выполнить один раз)
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key

# Затем собрать APK
flutter build apk --release
```

### "Unexpected character in pom-metadata.xml" (Android)

**Причина**: Кэш gradle повреждён

**Решение**:
```bash
# Windows
rmdir /s %USERPROFILE%\.gradle\caches
# Или Linux/Mac
rm -rf ~/.gradle/caches

flutter clean
flutter pub get
flutter build apk --release
```

## Проблемы с VS Code

### "Dart: Unresolved URI" для импортов пакетов

**Причина**: Индексация не завершена

**Решение**:
1. Закройте файл и откройте снова
2. Выполните `flutter pub get` из терминала VS Code
3. Перезагрузите VS Code (Ctrl+Shift+P > Developer: Reload Window)

### Breakpoints не работают при Debug

**Причина**: Debug информация не сгенерирована

**Решение**:
```bash
# Убедитесь что вы в debug режиме (по умолчанию)
flutter run
# Breakpoints должны работать автоматически
```

## Общие советы

1. **Всегда начните с `flutter clean` и `flutter pub get`** при странных ошибках
2. **Используйте `flutter doctor -v`** для диагностики проблем окружения
3. **Проверяйте версии пакетов** в pubspec.lock при обновлении зависимостей
4. **Читайте полный вывод ошибок** (ищите root cause, не последнюю строку)
5. **Попробуйте на чистой машине/в контейнере** если ничего не помогает

## Полезные команды

```bash
# Полная диагностика
flutter doctor -v

# Обновить всё
flutter upgrade
flutter pub upgrade --major-versions

# Анализ кода
flutter analyze

# Форматирование кода
dart format lib/ --line-length 100

# Запуск тестов
flutter test

# Запуск на конкретном устройстве с именем
flutter run -d "device_name"

# Запуск с дополнительными флагами
flutter run --no-fast-start --verbose --enable-checked-mode
```

## Где найти логи

```
Windows: %USERPROFILE%\AppData\Local\Flutter\logs\
Linux/Mac: ~/.config/Flutter/logs/
```

## Если ничего не помогает

1. Создайте Issue в репозитории
2. Приложите:
   - Вывод `flutter doctor -v`
   - Полную ошибку сборки (копируйте первую ошибку, не последнюю)
   - Шаги для воспроизведения
   - ОС и версию Flutter

