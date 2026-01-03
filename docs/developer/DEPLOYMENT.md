Deployment и Production Build

## Сборка для Production

### Windows EXE

#### 1. Подготовка

```bash
# Убедитесь что кода чист
git status
git stash  # Если есть неконтролируемые изменения

# Очистите предыдущие сборки
flutter clean

# Получите зависимости
flutter pub get
```

#### 2. Сборка Release

```bash
# Собрать Release версию
flutter build windows --release

# Выходной файл:
# build/windows/x64/Release/new_fly_mixxxx.exe
```

#### 3. Создание установщика (опционально)

Для создания MSI установщика используйте:
- **NSIS** (Nullsoft Scriptable Install System)
- **Inno Setup**
- **WiX Toolset**

Пример с Inno Setup:

```ini
[Setup]
AppName=Fly Mixxx
AppVersion=1.0.0
DefaultDirName={pf}\FlyMixxxx
DefaultGroupName=Fly Mixxx
OutputDir=build\windows\installer
OutputBaseFilename=FlyMixxxx-Setup
SourceDir=build\windows\x64\Release

[Files]
Source: "*"; DestDir: "{app}"; Flags: recursesubdirs

[Icons]
Name: "{group}\Fly Mixxx"; Filename: "{app}\new_fly_mixxxx.exe"
Name: "{commondesktop}\Fly Mixxx"; Filename: "{app}\new_fly_mixxxx.exe"

[Run]
Filename: "{app}\new_fly_mixxxx.exe"; Description: "Launch Fly Mixxx"; Flags: nowait postinstall skipifsilent
```

Сохраните как `windows/installer/installer.iss` и выполните:
```bash
iscc windows/installer/installer.iss
```

### Android APK/AAB

#### 1. Создание ключа подписи (один раз)

```bash
# Windows
keytool -genkey -v -keystore %USERPROFILE%\.android\my-app-key.jks ^
  -keyalg RSA -keysize 2048 -validity 10000 -alias my-app-key

# Linux/Mac
keytool -genkey -v -keystore ~/.android/my-app-key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 -alias my-app-key
```

Запомните пароль и информацию о создателе.

#### 2. Конфигурация подписи

Создайте `android/key.properties`:
```properties
storePassword=YOUR_PASSWORD
keyPassword=YOUR_PASSWORD
keyAlias=my-app-key
storeFile=key.jks
```

**Важно**: Добавьте в `.gitignore`:
```
android/key.properties
android/app/release/
```

#### 3. Сборка APK

```bash
# APK (для тестирования и прямой установки)
flutter build apk --release
# Выходной файл: build/app/outputs/flutter-apk/app-release.apk

# App Bundle (для Google Play)
flutter build aab --release
# Выходной файл: build/app/outputs/bundle/release/app-release.aab
```

## Распространение

### Windows

1. **Прямой EXE**: Распространяйте файл `build/windows/x64/Release/new_fly_mixxxx.exe`
   - Пользователю нужна установка Visual C++ Redistributable

2. **MSI Installer**: Создайте инсталлятор (см. выше)

3. **Microsoft Store**: Преобразуйте в MSIX и загрузите

### Android

1. **APK**: Распространяйте на сайте
   - Пользователи устанавливают через `adb install app-release.apk` или прямой загрузкой

2. **Google Play**: Загрузите AAB через Google Play Console
   - Требуется Google разработчик аккаунт

## Версионирование

В `pubspec.yaml`:
```yaml
version: 1.0.0+1
```

Формат: `major.minor.patch+build`

### Обновление версии

```bash
# Перед сборкой обновите версию в pubspec.yaml
# Например: 1.0.1+2

flutter pub get
flutter build windows --release
```

## Проверка перед релизом

```bash
# Статический анализ
flutter analyze

# Запуск тестов (если есть)
flutter test

# Проверка размера приложения
flutter build apk --release --verbose | grep -i "size"

# Проверка всех зависимостей
flutter pub outdated
```

## Конфигурирование приложения

### Окончательная проверка перед рилизом

1. **Версия в pubspec.yaml** — соответствует планируемому релизу
2. **Значки приложения** — обновлены в `android/app/src/main/res/` и других местах
3. **Разрешения** — только необходимые в `AndroidManifest.xml`
4. **Сертификаты** — актуальны для подписи
5. **Логирование** — убедитесь что sensitive данные не логируются

### Отключение Debug режима для production

В `lib/main.dart`:
```dart
void main() {
  // Отключить debug banner в release сборке
  assert(() {
    // Этот код выполнится только в debug режиме
    return true;
  }());
  
  runApp(const MyApp());
}
```

## Автоматизация сборки (CI/CD)

### GitHub Actions пример

Создайте `.github/workflows/build.yml`:

```yaml
name: Build and Release

on:
  push:
    tags:
      - 'v*'

jobs:
  build:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.0.0'
          channel: 'stable'
      
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test
      - run: flutter build windows --release
      
      - name: Upload Release
        uses: softprops/action-gh-release@v1
        with:
          files: build/windows/x64/Release/new_fly_mixxxx.exe
```

## Мониторинг после релиза

1. **Сбор ошибок**: Добавьте Sentry или Firebase Crashlytics
2. **Аналитика**: Firebase Analytics для отслеживания использования
3. **Обратная связь пользователей**: Email, GitHub Issues

## Откат версии

Если обнаружена критическая ошибка после релиза:

```bash
# Откатиться на предыдущий коммит
git revert HEAD

# Или создать hotfix ветку
git checkout -b hotfix/critical-bug
# ... исправьте баг ...
git push
# Создайте PR для merge в main
```

## Поддерживаемые платформы

- **Windows**: 10 x64 и новее
- **Android**: API 21+ (Android 5.0+)
- **macOS**: 10.11+ (при наличии конфигурации)

## Требования для конечных пользователей

### Windows
- Windows 10 или 11 (x64)
- ~200MB свободного места
- Visual C++ Redistributable (обычно уже установлен)

### Android
- Android 5.0+ (API 21+)
- ~100MB свободного места
- Разрешения: микрофон, хранилище

## Поддержка и обновления

Выпускайте обновления регулярно:
- Критические баги: ASAP
- Важные фичи: еженедельно/ежемесячно
- Незначительные улучшения: когда накопятся

Документируйте изменения в CHANGELOG.md.

