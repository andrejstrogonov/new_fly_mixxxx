# 📂 Структура и описание файлов проекта Fly Mixxx

## 🎯 Главные документы (читайте в первую очередь)

| Файл | Описание | Для кого |
|------|---------|----------|
| **[START_HERE.md](START_HERE.md)** | ⭐ Начните отсюда! | Все |
| **[README.md](README.md)** | Обзор проекта и основная информация | Все |
| **[RUN_APP.md](RUN_APP.md)** | Все способы запуска приложения | Разработчики |
| **[DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md)** | Индекс всей документации | Все |
| **[PROJECT_STATUS.md](PROJECT_STATUS.md)** | Статус проекта и что было сделано | Все |
| **[COMPLETION_SUMMARY.md](COMPLETION_SUMMARY.md)** | Детальный отчёт о выполненных работах | Все |

---

## 📚 Документация для разработчиков

### `docs/developer/` — Для разработчиков

| Файл | Описание |
|------|---------|
| **[README.md](docs/developer/README.md)** | Обзор документации для разработчиков |
| **[SETUP.md](docs/developer/SETUP.md)** | 📖 Полная настройка окружения (шаг за шагом) |
| **[ARCHITECTURE.md](docs/developer/ARCHITECTURE.md)** | 🏗️ Описание архитектуры приложения |
| **[CONTRIBUTING.md](docs/developer/CONTRIBUTING.md)** | 🤝 Как вносить вклад в проект |
| **[TROUBLESHOOTING.md](docs/developer/TROUBLESHOOTING.md)** | 🐛 30+ решений типичных проблем |
| **[DEPLOYMENT.md](docs/developer/DEPLOYMENT.md)** | 📦 Сборка и развёртывание (Windows, Android) |

---

## 👥 Документация для пользователей

### `docs/user/` — Для пользователей

| Файл | Описание |
|------|---------|
| **[README.md](docs/user/README.md)** | О приложении и его возможностях |
| **[QUICK_START.md](docs/user/QUICK_START.md)** | 🚀 Как установить и запустить |
| **[USAGE.md](docs/user/USAGE.md)** | 📖 Как пользоваться приложением |
| **[TROUBLESHOOTING.md](docs/user/TROUBLESHOOTING.md)** | 🐛 Решение проблем пользователя |

---

## 💻 Конфигурационные файлы

### `.vscode/` — Для VS Code

| Файл | Описание |
|------|---------|
| **[launch.json](.vscode/launch.json)** | 5 конфигураций для запуска (Debug/Release, Windows/Android) |
| **[settings.json](.vscode/settings.json)** | Параметры форматирования и линтинга |

### Корневые файлы конфигурации

| Файл | Описание |
|------|---------|
| **[pubspec.yaml](pubspec.yaml)** | Конфигурация зависимостей Flutter |
| **[pubspec.lock](pubspec.lock)** | Зафиксированные версии пакетов |
| **[analysis_options.yaml](analysis_options.yaml)** | Правила статического анализа Dart |

---

## 🔧 Скрипты и утилиты

### `scripts/` — Автоматизация

| Файл | Описание | ОС |
|------|---------|-------|
| **[kill_windows_exe.ps1](scripts/kill_windows_exe.ps1)** | Завершить процесс .exe (решение LNK1168) | Windows |

### Корневые скрипты

| Файл | Описание | ОС |
|------|---------|-------|
| **[check_project.bat](check_project.bat)** | Проверка проекта (13 критериев) | Windows |
| **[check_project.sh](check_project.sh)** | Проверка проекта (13 критериев) | Linux/Mac |

---

## 📱 Исходный код приложения

### `lib/` — Код приложения

```
lib/
├── main.dart                          # 📌 Точка входа приложения
│
├── screens/
│   └── mixer_screen.dart             # 🎛️ Главный экран микшера
│
├── widgets/                          # 🎨 Переиспользуемые компоненты
│   ├── frequency_response_widget.dart # 📊 АЧХ, ФЧХ, Боде диаграммы ✅ ИСПРАВЛЕНО
│   ├── equalizer_widget.dart         # 🎚️ Эквалайзер с 10 полосами
│   ├── mixer_controls_widget.dart    # 🎛️ Управление микшером
│   ├── deck_widget.dart              # 🎵 Дека для трека
│   ├── track_loader_widget.dart      # 📁 Загрузка аудиофайлов
│   ├── audio_device_analysis_widget.dart  # 🔍 Анализ оборудования
│   ├── composition_generator_widget.dart  # 🤖 Генератор композиций
│   └── presets_widget.dart           # 💾 Сохранённые предустановки
│
├── providers/                        # 🔄 State Management
│   ├── audio_provider.dart           # 🔊 Управление аудио
│   ├── audio_device_analyzer.dart    # 🔍 Анализ устройств
│   └── composition_generator.dart    # 🤖 AI композиции
│
└── models/                           # 📊 Модели данных
    ├── audio_device_model.dart       # 🔊 Модель устройства
    └── composition_model.dart        # 🎵 Модель композиции
```

---

## 🌐 Нативный код

### `windows/` — Код для Windows

```
windows/
├── CMakeLists.txt                   # Конфигурация сборки
├── flutter/
│   ├── CMakeLists.txt              # Flutter интеграция
│   └── generated_plugins.cmake      # Подключённые плагины
└── runner/
    ├── main.cpp                    # Точка входа приложения
    ├── mainwindow.h/.cpp           # Главное окно
    ├── utils.h/.cpp                # Утилиты
    └── new_fly_mixxxx.rc           # Ресурсы приложения
```

### `android/` — Код для Android

```
android/
├── build.gradle.kts                # Конфигурация gradle
├── settings.gradle.kts             # Settings gradle
├── app/
│   ├── build.gradle.kts           # App-level build
│   └── src/
│       └── main/
│           ├── AndroidManifest.xml # Манифест приложения
│           └── res/                # Ресурсы (иконки, строки)
└── gradle/wrapper/                 # Gradle wrapper
```

---

## 📦 Зависимости (из pubspec.yaml)

| Пакет | Версия | Назначение |
|-------|--------|-----------|
| **flutter** | SDK | Фреймворк |
| **provider** | ^6.0.0 | State Management |
| **just_audio** | ^0.10.5 | Воспроизведение аудио |
| **audio_session** | ^0.2.2 | Сессия аудио |
| **fl_chart** | ^1.1.1 | Графики и диаграммы |
| **file_picker** | ^10.3.8 | Выбор файлов |
| **http** | ^1.1.0 | HTTP запросы |
| **dio** | ^5.3.0 | HTTP клиент |
| **win32** | ^3.3.0 | Windows API |

---

## 📋 Тестирование

### `test/` — Тесты

```
test/
├── widget_test.dart               # Widget тесты (пример)
└── widget_integration_test.dart   # Integration тесты
```

**Статус**: Базовая структура. Полное покрытие тестами рекомендуется добавить.

---

## 📊 Какой файл читать в какой ситуации?

### Я хочу...

| Ситуация | Читайте файл |
|----------|-------------|
| **Запустить приложение быстро** | [START_HERE.md](START_HERE.md) или [RUN_APP.md](RUN_APP.md) |
| **Понять структуру проекта** | [docs/developer/ARCHITECTURE.md](docs/developer/ARCHITECTURE.md) + этот файл |
| **Начать разработку** | [docs/developer/SETUP.md](docs/developer/SETUP.md) |
| **Найти решение проблемы** | [DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md) → TROUBLESHOOTING |
| **Собрать приложение для выпуска** | [docs/developer/DEPLOYMENT.md](docs/developer/DEPLOYMENT.md) |
| **Помочь проекту** | [docs/developer/CONTRIBUTING.md](docs/developer/CONTRIBUTING.md) |
| **Использовать приложение** | [docs/user/QUICK_START.md](docs/user/QUICK_START.md) |
| **Узнать что было сделано** | [COMPLETION_SUMMARY.md](COMPLETION_SUMMARY.md) |

---

## 🔍 Поиск файла по типу

### Документация
- Для разработчиков: `docs/developer/*.md`
- Для пользователей: `docs/user/*.md`
- Главная: `*.md` в корне проекта

### Конфигурация
- VS Code: `.vscode/*.json`
- Flutter: `pubspec.yaml`, `analysis_options.yaml`
- Android: `android/app/build.gradle.kts`, `android/app/src/main/AndroidManifest.xml`
- Windows: `windows/CMakeLists.txt`, `windows/runner/main.cpp`

### Исходный код
- Приложение: `lib/**/*.dart`
- Тесты: `test/**/*.dart`
- Нативный код: `windows/**`, `android/**`

### Скрипты
- Bash: `*.sh`
- Batch: `*.bat`
- PowerShell: `*.ps1`

---

## 📝 Файлы которые были исправлены

### ✅ Исправлены

| Файл | Что исправлено |
|------|-----------------|
| **lib/widgets/frequency_response_widget.dart** | Заменены 20+ deprecated `withOpacity()` на `withValues(alpha:)` |

### ✅ Созданы

| Файл | Тип |
|------|-----|
| Все документация в `docs/` | Документация |
| Все файлы в `.vscode/` | Конфигурация |
| `check_project.bat`, `check_project.sh` | Скрипты |
| `scripts/kill_windows_exe.ps1` | Скрипт |
| `START_HERE.md`, `PROJECT_STATUS.md`, и др. | Документация |

---

## 🎯 Размер проекта

| Раздел | Примерный размер |
|--------|-----------------|
| `lib/` (исходный код) | ~50KB |
| `docs/` (документация) | ~200KB |
| `build/` (временные файлы) | Удаляется при `flutter clean` |
| `android/`, `windows/` (нативный код) | ~100KB |

---

## 💾 Важные файлы для version control

### В `.gitignore`:
- `build/` — временные файлы сборки
- `android/key.properties` — ключи подписи
- `.gradle/` — gradle кэш
- `*.iml` — IntelliJ файлы
- Обычно управляется Flutter

### Должны быть в git:
- `lib/` — исходный код ✅
- `docs/` — документация ✅
- `pubspec.yaml` — зависимости ✅
- `.vscode/`, `android/`, `windows/` — конфигурация ✅
- `README.md` и документация ✅

---

**Теперь вы знаете где всё находится! 🗺️**

Начните с [START_HERE.md](START_HERE.md) или перейдите к интересующему вас файлу из таблицы выше.

