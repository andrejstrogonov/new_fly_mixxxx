# Testing Guide for Developers

## Обзор тестирования

Проект использует три типа тестов:

1. **Unit Tests**: Тесты для отдельных функций и классов
2. **Widget Tests**: Тесты для UI компонентов
3. **Integration Tests**: Полная интеграция приложения

## Unit Tests

### Структура Unit Test

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Feature Tests', () {
    setUp(() {
      // Инициализация перед каждым тестом
    });

    tearDown(() {
      // Очистка после каждого теста
    });

    test('description of test', () {
      // Arrange: подготовка данных
      final input = 'test';

      // Act: выполнение кода
      final result = processInput(input);

      // Assert: проверка результата
      expect(result, expectedValue);
    });
  });
}
```

### Примеры Unit Tests

**Test для BaseViewModel:**

```bash
flutter test test/presentation/viewmodels/base_viewmodel_test.dart
```

**Test для Result Entity:**

```bash
flutter test test/domain/entities/result_test.dart
```

**Test для математики:**

```bash
flutter test test/frequency_response_math_test.dart
```

## Widget Tests

### Структура Widget Test

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('Widget Tests', () {
    testWidgets('Widget renders correctly', (tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: TestWidget(),
        ),
      );

      // Find and verify
      expect(find.byType(TestWidget), findsOneWidget);
    });

    testWidgets('User interaction works', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureDetector(
              onTap: () {},
              child: const Text('Tap me'),
            ),
          ),
        ),
      );

      // Simulate tap
      await tester.tap(find.text('Tap me'));
      await tester.pumpAndSettle();

      // Verify state change
      expect(find.byType(SizedBox), findsWidgets);
    });
  });
}
```

### Примеры Widget Tests

**Test для RotaryKnobWidget:**

```bash
flutter test test/widgets/rotary_knob_widget_test.dart
```

**Test для FrequencyResponseWidget:**

```bash
flutter test test/widgets/frequency_response_widget_test.dart
```

## Integration Tests

### Структура Integration Test

```dart
void main() {
  group('Integration Tests', () {
    testWidgets('Full user flow', (tester) async {
      // Load the app
      await tester.pumpWidget(const MyApp());
      
      // Interact with multiple widgets
      await tester.tap(find.byType(Button));
      await tester.pumpAndSettle();
      
      // Verify final state
      expect(find.text('Success'), findsOneWidget);
    });
  });
}
```

### Запуск Integration Tests

```bash
flutter test integration_test/
```

## MVVM Architecture Tests

### Тестирование ViewModel

```bash
flutter test test/mvvm_architecture_test.dart
```

### Что тестируется:

- Состояния ViewModel (loading, success, error, idle)
- Управление ошибками
- Обработка Result<T>
- Уведомление слушателей (listeners)
- Разделение ответственности (separation of concerns)

## Частые утверждения (Assertions)

```dart
// Проверка наличия виджета
expect(find.byType(MyWidget), findsOneWidget);
expect(find.byType(Text), findsWidgets);
expect(find.byType(Button), findsNothing);

// Проверка текста
expect(find.text('Hello'), findsOneWidget);
expect(find.byWidgetPredicate((w) => w is Text && w.data == 'Test'), findsOneWidget);

// Проверка свойств
final widget = tester.widget<Text>(find.byType(Text));
expect(widget.data, 'Expected Text');

// Проверка состояния
final state = tester.state<MyWidgetState>(find.byType(MyWidget));
expect(state.value, expectedValue);

// Проверка типов данных
expect(value, isA<String>());
expect(value, isA<List<int>>());

// Проверка значений
expect(value, equals(5));
expect(value, isNot(6));
expect(value, greaterThan(0));
expect(value, lessThanOrEqualTo(10));
expect(value, isNull);
expect(value, isNotNull);
```

## Mockable Для тестирования

### Создание Mock объектов

```dart
import 'package:mockito/mockito.dart';

class MockAudioRepository extends Mock implements AudioRepository {}

// Использование
test('mock repository', () {
  final mockRepo = MockAudioRepository();
  
  // Setup behavior
  when(mockRepo.loadTrack(any))
    .thenAnswer((_) async => Track(...));
  
  // Test code
  final track = await mockRepo.loadTrack('id');
  
  // Verify
  verify(mockRepo.loadTrack('id')).called(1);
});
```

## Покрытие кода (Code Coverage)

### Сбор покрытия

```bash
flutter test --coverage
```

### Генерация отчета

```bash
# На macOS/Linux
lcov --list coverage/lcov.info

# Или используйте HTML отчет
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Минимальное покрытие

Цель: минимум 80% покрытия критического кода

## Тестирование производительности

### Widget Performance Test

```dart
testWidgets('Widget performance', (tester) async {
  final watch = Stopwatch()..start();
  
  await tester.pumpWidget(const MyApp());
  
  watch.stop();
  print('Build time: ${watch.elapsedMilliseconds}ms');
  
  expect(watch.elapsedMilliseconds, lessThan(1000)); // < 1 sec
});
```

### Memory Leak Test

```dart
test('Memory leak test', () async {
  final vm = AudioViewModel(...);
  
  vm.setLoading();
  vm.setSuccess();
  vm.setError('Error');
  
  vm.dispose();
  
  // Verify no lingering references
  expect(vm.state, ViewModelState.idle);
});
```

## Continuous Integration / Continuous Deployment (CI/CD)

### GitHub Actions Example

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test --coverage
      - uses: codecov/codecov-action@v2
```

## Лучшие практики тестирования

1. **AAA Pattern**: Arrange, Act, Assert
2. **Isolate Tests**: каждый тест должен быть независимым
3. **Descriptive Names**: названия должны описывать что тестируется
4. **No Test Interdependence**: тесты не должны зависить друг от друга
5. **Mock External Dependencies**: мокируйте сетевые запросы и БД
6. **Test Edge Cases**: тестируйте граничные случаи
7. **Avoid Sleep**: не используйте `Future.delayed` в тестах
8. **Use Finders Correctly**: правильно используйте `find` для поиска виджетов
9. **Clean Up**: всегда очищайте ресурсы в `tearDown`
10. **Document Tests**: документируйте сложные тестовые сценарии

## Troubleshooting Tests

### Тест зависает

**Решение**: используйте `pumpAndSettle()` вместо `pump()`

```dart
await tester.pumpAndSettle(); // Ждет до завершения всех анимаций
```

### "No material library found"

**Решение**: оберните widget в MaterialApp

```dart
await tester.pumpWidget(
  MaterialApp(home: YourWidget())
);
```

### "setState called after dispose"

**Решение**: используйте `mounted` проверку

```dart
if (mounted) {
  setState(() {});
}
```

## Дополнительные ресурсы

- [Flutter Testing Documentation](https://flutter.dev/docs/testing)
- [Testing Best Practices](https://flutter.dev/docs/testing/best-practices)
- [Widget Testing Guide](https://flutter.dev/docs/testing/widget-test-introduction)

