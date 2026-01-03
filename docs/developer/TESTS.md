# TESTS

Как запускать тесты

- Юнит и виджеты:
  `flutter test`

- Интеграционные тесты (если настроены):
  `flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart`

Рекомендации

- Пишите тесты для провайдеров (AudioProvider, CompositionGenerator)
- Поддерживайте покрытие ключевой логики

