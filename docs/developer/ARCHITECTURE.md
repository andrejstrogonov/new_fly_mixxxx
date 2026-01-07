# Руководство для разработчиков

## Архитектура проекта

Проект следует архитектурному паттерну **MVVM** (Model-View-ViewModel) с элементами **Clean Architecture**.

### Структура проекта

```
lib/
├── core/                 # Базовые утилиты и константы
│   ├── constants/       # Константы приложения
│   ├── exceptions/      # Исключения
│   ├── extensions/      # Расширения для типов
│   └── utils/          # Утилиты (logger, etc.)
│
├── domain/             # Бизнес-логика (независима от Framework)
│   ├── entities/       # Сущности (Track, EQPreset, etc.)
│   ├── repositories/   # Интерфейсы репозиториев
│   └── usecases/       # Use cases для бизнес-логики
│
├── data/               # Реализация репозиториев
│   ├── datasources/    # Локальные и удаленные источники данных
│   └── repositories/   # Реализация интерфейсов
│
├── presentation/       # UI слой
│   ├── screens/        # Экраны приложения
│   ├── viewmodels/     # ViewModel для управления состоянием
│   └── widgets/        # Переиспользуемые компоненты
│
├── providers/          # Provider для Dependency Injection
├── services/           # Сервисы (service locator, error handler)
└── main.dart          # Entry point
```

## MVVM Архитектура

### ViewModel

Все ViewModels наследуют `BaseViewModel`:

```dart
class AudioViewModel extends BaseViewModel {
  // Состояние
  TrackEntity? _currentTrack;
  
  // Getters для UI
  TrackEntity? get currentTrack => _currentTrack;
  
  // Методы для бизнес-логики
  Future<void> loadTrack(TrackEntity track) async {
    setLoading();
    try {
      final result = await useCase.execute(params);
      handleResult(result, onSuccess: (data) {
        _currentTrack = data;
        setSuccess();
        notifyListeners();
      });
    } catch (e) {
      setError(e.toString());
    }
  }
}
```

### Состояния ViewModel

ViewModelState имеет 4 состояния:

- **idle**: начальное состояние
- **loading**: выполняется асинхронная операция
- **success**: операция успешна
- **error**: произошла ошибка

### Result Pattern

Для обработки результатов используется `Result<T>`:

```dart
// Success
final result = Result<Track>.success(track);

// Failure
final result = Result<Track>.failure(
  Failure(message: 'Error loading track', code: 'LOAD_ERROR')
);

// Обработка
result.fold(
  (failure) => print('Error: ${failure.message}'),
  (track) => print('Success: ${track.name}'),
);
```

## Использование Provider

```dart
// Регистрируем ViewModel в providers
providers: [
  ChangeNotifierProvider(
    create: (_) => AudioViewModel(...),
  ),
]

// Используем в UI
Consumer<AudioViewModel>(
  builder: (context, viewModel, _) {
    if (viewModel.isLoading) {
      return CircularProgressIndicator();
    }
    if (viewModel.isError) {
      return Text('Error: ${viewModel.errorMessage}');
    }
    return Text('Track: ${viewModel.currentTrack?.name}');
  },
)
```

## Тестирование

### Unit Tests

Тесты для ViewModel:

```dart
test('ViewModel loading state', () {
  final vm = AudioViewModel(...);
  vm.setLoading();
  expect(vm.isLoading, true);
  expect(vm.isSuccess, false);
});
```

### Widget Tests

Тесты для UI компонентов:

```dart
testWidgets('RotaryKnobWidget renders', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: RotaryKnobWidget(...)
  ));
  
  expect(find.byType(RotaryKnobWidget), findsOneWidget);
});
```

### Integration Tests

Полная интеграция приложения на платформе.

## Запуск тестов

```bash
# Unit tests
flutter test test/presentation/viewmodels/base_viewmodel_test.dart

# Widget tests
flutter test test/widgets/rotary_knob_widget_test.dart

# Все тесты
flutter test
```

## Запуск приложения

### Development

```bash
# Windows
flutter run -d windows

# Android
flutter run -d android-emulator

# iOS
flutter run -d ios
```

### Production

```bash
# Windows build
flutter build windows

# Android build
flutter build apk
flutter build appbundle

# iOS build
flutter build ios
```

## Frequency Response Widget

Виджет отображает три графика:

1. **АЧХ (Амплитудно-частотная характеристика)**: амплитуда в dB
2. **ФЧХ (Фазо-частотная характеристика)**: фаза в градусах
3. **Диаграмма Боде**: объединенный график АЧХ и ФЧХ

### Математика

Логарифмическая шкала частот (20Hz - 20kHz):

```dart
double logMin = log(20.0) / log(10.0);
double logMax = log(20000.0) / log(10.0);
double freq = pow(10, logFreq);
```

dB преобразование:

```dart
double linearToDb(double value) => 20 * log(value) / log(10);
double dbToLinear(double dbValue) => pow(10, dbValue / 20);
```

## Rotary Knob Widget

Интерактивный круглый регулятор (как в Mixxx).

### Использование

```dart
RotaryKnobWidget(
  value: 50,
  min: 0,
  max: 100,
  label: 'Volume',
  unit: '%',
  onChanged: (value) {
    // Handle value change
  },
)
```

### Взаимодействие

- **Drag**: изменение значения путем перетягивания
- **Display**: показание текущего значения

## Часто встречающиеся проблемы

### LNK1168: не удается открыть exe для записи

**Решение**: процесс приложения еще работает. Убейте процесс:

```powershell
taskkill /F /IM new_fly_mixxxx.exe
```

### RenderFlex children have non-zero flex but incoming height constraints are unbounded

**Решение**: используйте `mainAxisSize: MainAxisSize.min` и `Flexible` вместо `Expanded` в Column внутри ScrollView.

### UnmodifiableUint8ListView ошибка в win32 пакете

**Решение**: обновите win32 пакет в pubspec.yaml:

```yaml
win32: ^5.15.0
```

Затем выполните:

```bash
flutter clean
flutter pub get
```

## Dependency Injection (GetIt)

Service Locator для управления зависимостями:

```dart
// Регистрация
final getIt = GetIt.instance;
getIt.registerSingleton<AudioRepository>(AudioRepositoryImpl());

// Использование
final repo = getIt<AudioRepository>();
```

## Логирование

Используется `Logger` из пакета `logger`:

```dart
viewModel.log('Operation started');
viewModel.logError('Error occurred', error: exception);
```

## Лучшие практики

1. **Разделение ответственности**: отделяйте UI от бизнес-логики
2. **Immutability**: старайтесь делать данные неизменяемыми
3. **Type Safety**: используйте типизацию везде где возможно
4. **Error Handling**: всегда обрабатывайте ошибки
5. **Testing**: пишите тесты для критического кода
6. **Documentation**: документируйте сложные алгоритмы

## Дополнительные ресурсы

- [Flutter MVVM Architecture](https://flutter.dev)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Provider Package Documentation](https://pub.dev/packages/provider)

