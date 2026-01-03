# CI — рекомендации

Пример шагов в CI (GitHub Actions):
- Установка Flutter
- `flutter pub get`
- `flutter analyze`
- `flutter test`
- (опционально) сборка релиза для артефактов

Рекомендации

- Добавьте проверку ссылок в документации и spell-check (опционально)
- Для Windows билдов используйте self-hosted runner с Visual Studio или GitHub-hosted Windows runner

