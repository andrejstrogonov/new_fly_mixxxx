# 📖 Индекс Документации Fly Mixxx

## 🎯 Быстрая Навигация

### Я хочу...

| Задача | Документ |
|--------|----------|
| **Установить и запустить приложение** | [RUN_APP.md](../RUN_APP.md) |
| **Начать разработку** | [docs/developer/SETUP.md](docs/developer/SETUP.md) |
| **Понять архитектуру проекта** | [docs/developer/ARCHITECTURE.md](docs/developer/ARCHITECTURE.md) |
| **Решить проблему при разработке** | [docs/developer/TROUBLESHOOTING.md](docs/developer/TROUBLESHOOTING.md) |
| **Собрать приложение для выпуска** | [docs/developer/DEPLOYMENT.md](docs/developer/DEPLOYMENT.md) |
| **Помочь проекту (вклад)** | [docs/developer/CONTRIBUTING.md](docs/developer/CONTRIBUTING.md) |
| **Использовать приложение как пользователь** | [docs/user/QUICK_START.md](docs/user/QUICK_START.md) |
| **Узнать как пользоваться приложением** | [docs/user/USAGE.md](docs/user/USAGE.md) |
| **Решить проблему как пользователь** | [docs/user/TROUBLESHOOTING.md](docs/user/TROUBLESHOOTING.md) |
| **Узнать что было сделано** | [COMPLETION_SUMMARY.md](COMPLETION_SUMMARY.md) |

## 📁 Полная структура документации

### Главные документы
- 📄 **[README.md](../README.md)** — Обзор проекта и основная информация
- 📄 **[RUN_APP.md](../RUN_APP.md)** — Как запустить приложение (все способы)
- 📄 **[COMPLETION_SUMMARY.md](COMPLETION_SUMMARY.md)** — Что было выполнено

### 👨‍💻 Документация для Разработчиков (`docs/developer/`)

```
docs/developer/
├── README.md              # Обзор документации для разработчиков
├── SETUP.md              # Настройка окружения и первый запуск
├── ARCHITECTURE.md       # Структура и организация кода
├── CONTRIBUTING.md       # Как вносить вклад в проект
├── TROUBLESHOOTING.md    # Решение типичных проблем разработки
└── DEPLOYMENT.md         # Сборка и развёртывание приложения
```

**Рекомендуемый порядок чтения:**
1. [SETUP.md](docs/developer/SETUP.md) — Настроить окружение
2. [ARCHITECTURE.md](docs/developer/ARCHITECTURE.md) — Понять структуру
3. [RUN_APP.md](../RUN_APP.md) — Запустить приложение
4. [CONTRIBUTING.md](docs/developer/CONTRIBUTING.md) — Начать разработку
5. [TROUBLESHOOTING.md](docs/developer/TROUBLESHOOTING.md) — Решить проблемы
6. [DEPLOYMENT.md](docs/developer/DEPLOYMENT.md) — Когда готово к выпуску

### 👥 Документация для Пользователей (`docs/user/`)

```
docs/user/
├── README.md              # Что это за приложение
├── QUICK_START.md         # Как установить и запустить
├── USAGE.md              # Как пользоваться приложением
└── TROUBLESHOOTING.md    # Решение проблем
```

**Рекомендуемый порядок чтения:**
1. [README.md](docs/user/README.md) — О приложении
2. [QUICK_START.md](docs/user/QUICK_START.md) — Установка
3. [USAGE.md](docs/user/USAGE.md) — Основные функции
4. [TROUBLESHOOTING.md](docs/user/TROUBLESHOOTING.md) — Если что-то не работает

## 🔍 Поиск по темам

### Установка и Запуск
- [RUN_APP.md](../RUN_APP.md) — Все способы запуска
- [docs/developer/SETUP.md](docs/developer/SETUP.md) — Подробная подготовка для разработчиков
- [docs/user/QUICK_START.md](docs/user/QUICK_START.md) — Простой старт для пользователей

### Разработка
- [docs/developer/ARCHITECTURE.md](docs/developer/ARCHITECTURE.md) — Как организован код
- [docs/developer/CONTRIBUTING.md](docs/developer/CONTRIBUTING.md) — Как помочь проекту
- [RUN_APP.md](../RUN_APP.md) раздел "Конфигурация для разработки"

### Решение Проблем
- [docs/developer/TROUBLESHOOTING.md](docs/developer/TROUBLESHOOTING.md) — 30+ решений для разработчиков
- [docs/user/TROUBLESHOOTING.md](docs/user/TROUBLESHOOTING.md) — Решения для пользователей
- [RUN_APP.md](../RUN_APP.md) раздел "Решение типичных проблем"

### Сборка и Выпуск
- [docs/developer/DEPLOYMENT.md](docs/developer/DEPLOYMENT.md) — Полный процесс сборки
  - Windows EXE и MSI
  - Android APK и AAB
  - Версионирование
  - CI/CD примеры

### Запуск в разных средах
- **VS Code**: [RUN_APP.md](../RUN_APP.md) раздел "Вариант Б"
- **Android Studio**: [RUN_APP.md](../RUN_APP.md) раздел "Вариант В"
- **Командная строка**: [RUN_APP.md](../RUN_APP.md) раздел "Вариант А"

## 🛠️ Полезные скрипты и конфигурации

| Файл | Назначение |
|------|-----------|
| `.vscode/launch.json` | 5 конфигураций для VS Code |
| `.vscode/settings.json` | Параметры форматирования в VS Code |
| `scripts/kill_windows_exe.ps1` | Завершение процесса на Windows |
| `check_project.bat` | Проверка проекта (Windows) |
| `check_project.sh` | Проверка проекта (Linux/Mac) |
| `pubspec.yaml` | Конфигурация зависимостей |
| `analysis_options.yaml` | Правила статического анализа |

## 📱 Платформы

### Windows
- Поддерживаемые версии: Windows 10 x64 и новее
- Требования: Visual C++ Redistributable
- Сборка: [docs/developer/DEPLOYMENT.md](docs/developer/DEPLOYMENT.md)

### Android
- Поддерживаемые версии: Android 5.0+ (API 21+)
- Требования: 100MB свободного места
- Сборка: [docs/developer/DEPLOYMENT.md](docs/developer/DEPLOYMENT.md)

## 🎓 Дополнительные ресурсы

- [Flutter документация](https://flutter.dev/docs)
- [Dart язык программирования](https://dart.dev)
- [Provider state management](https://pub.dev/packages/provider)
- [Just Audio пакет](https://pub.dev/packages/just_audio)
- [FL Chart графики](https://pub.dev/packages/fl_chart)

## 💡 Советы для навигации

1. **Используйте Ctrl+F** в вашем браузере/редакторе для поиска по документу
2. **Откройте ссылки в новой вкладке** (Ctrl+Click) для удобства
3. **Прочитайте в рекомендуемом порядке** чтобы лучше понять проект
4. **Возвращайтесь к этому файлу** когда потеряетесь в документации

## 🆘 Если вы не нашли ответ

1. **Посмотрите в разделе TROUBLESHOOTING** соответствующей документации
2. **Выполните `flutter doctor -v`** для диагностики
3. **Создайте Issue** в репозитории GitHub с подробным описанием
4. **Приложите** вывод `flutter doctor -v` и полное сообщение об ошибке

## 📝 Версия документации

Документация актуальна для:
- **Flutter**: >= 3.0.0
- **Dart**: >= 3.0.0
- **Fly Mixxx**: версия 1.0.0+

Последнее обновление: 2026-01-03

---

**Спасибо за использование Fly Mixxx! 🎵**

Если у вас есть предложения по улучшению документации, создайте Issue или Pull Request.

