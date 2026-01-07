# 🏗️ MVVM и Clean Architecture - Путеводитель по рефакторингу

## 📋 Содержание

1. [Архитектура](#архитектура)
2. [Структура папок](#структура-папок)
3. [Слои приложения](#слои-приложения)
4. [Примеры использования](#примеры-использования)
5. [Best Practices](#best-practices)

---

## 🏛️ Архитектура

Приложение следует **MVVM (Model-View-ViewModel)** паттерну с **Clean Architecture** принципами:

```
┌─────────────────────────────────────────────────┐
│              PRESENTATION LAYER                  │
│  (UI - Screens, Widgets, ViewModels)            │
├─────────────────────────────────────────────────┤
│              DOMAIN LAYER                        │
│  (Business Logic - UseCases, Entities)          │
├─────────────────────────────────────────────────┤
│              DATA LAYER                          │
│  (Repository Implementations, DataSources)      │
├─────────────────────────────────────────────────┤
│              CORE & SERVICES LAYER               │
│  (Constants, Exceptions, Utils, Logging, DI)    │
└─────────────────────────────────────────────────┘
```

---

## 📁 Структура папок

```
lib/
├── core/                              # Общие компоненты
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── audio_constants.dart
│   │   ├── eq_presets_constants.dart
│   │   └── ui_constants.dart
│   ├── exceptions/
│   │   ├── app_exception.dart
│   │   ├── audio_exception.dart
│   │   ├── file_exception.dart
│   │   ├── network_exception.dart
│   │   └── validation_exception.dart
│   ├── extensions/
│   │   ├── duration_extension.dart
│   │   ├── string_extension.dart
│   │   └── double_extension.dart
│   └── utils/
│       └── logger.dart
│
├── data/                              # Слой данных
│   ├── datasources/
│   │   ├── local/
│   │   └── remote/
│   ├── models/
│   └── repositories/
│
├── domain/                            # Слой бизнес-логики
│   ├── entities/
│   │   ├── result.dart
│   │   ├── track_entity.dart
│   │   ├── eq_preset_entity.dart
│   │   ├── frequency_response_entity.dart
│   │   ├── audio_device_entity.dart
│   │   ├── composition_entity.dart
│   │   └── mixer_state_entity.dart
│   ├── repositories/
│   │   ├── audio_repository.dart
│   │   ├── track_repository.dart
│   │   ├── equalizer_repository.dart
│   │   ├── composition_repository.dart
│   │   ├── device_analyzer_repository.dart
│   │   └── frequency_response_repository.dart
│   └── usecases/
│       ├── base_usecase.dart
│       ├── audio/
│       │   ├── load_track_usecase.dart
│       │   ├── play_audio_usecase.dart
│       │   ├── pause_audio_usecase.dart
│       │   ├── stop_audio_usecase.dart
│       │   └── seek_audio_usecase.dart
│       ├── equalizer/
│       ├── mixer/
│       ├── track/
│       ├── composition/
│       └── device/
│
├── presentation/                      # UI слой (MVVM)
│   ├── viewmodels/
│   │   ├── base_viewmodel.dart
│   │   ├── audio_viewmodel.dart
│   │   ├── equalizer_viewmodel.dart
│   │   ├── mixer_viewmodel.dart
│   │   ├── track_loader_viewmodel.dart
│   │   ├── composition_viewmodel.dart
│   │   ├── device_analyzer_viewmodel.dart
│   │   └── frequency_response_viewmodel.dart
│   ├── screens/
│   │   └── mixer_screen.dart
│   └── widgets/
│       ├── deck_widget.dart
│       ├── mixer_controls_widget.dart
│       └── ... (остальные UI виджеты)
│
├── services/                          # Сервисы
│   ├── service_locator.dart
│   └── error_handler_service.dart
│
└── main.dart
```

---

## 🧬 Слои приложения

### 1️⃣ CORE LAYER (Ядро)

**Назначение:** Общие компоненты, не зависящие от бизнес-логики

**Включает:**
- **Constants:** App, Audio, EQ Presets, UI constants
- **Exceptions:** AppException, AudioException, FileException, NetworkException, ValidationException
- **Extensions:** DurationExtension, StringExtension, DoubleExtension
- **Utils:** Logger, Device Info Utils

**Особенности:**
- ✅ Не должны иметь зависимостей от других слоев (кроме Flutter)
- ✅ Переиспользуются во всем приложении
- ✅ Легко тестировать

**Пример:**
```dart
// core/constants/app_constants.dart
class AppConstants {
  static const String appName = 'Fly Mixxx - DJ Mixer';
  static const int maxQueueSize = 4;
}

// core/extensions/duration_extension.dart
extension DurationExtension on Duration {
  String toFormattedString() => '${inMinutes}:${(inSeconds % 60).toString().padLeft(2, '0')}';
}

// core/utils/logger.dart
Logger.info('Track loaded successfully');
```

---

### 2️⃣ DOMAIN LAYER (Бизнес-логика)

**Назначение:** Чистая бизнес-логика, независимая от платформы и фреймворка

**Включает:**
- **Entities:** Основные классы данных (pure Dart классы)
- **Repositories (Abstract):** Интерфейсы, определяющие контракт
- **UseCases:** Бизнес-операции, каждый UseCase = одна операция

**Особенности:**
- ✅ Не знает ничего о Flutter, HTTP, БД и т.д.
- ✅ Зависит только от Core слоя
- ✅ Легко покрыть юнит-тестами
- ✅ Переиспользуемо в разных проектах (например, в CLI утилите)

**Пример Entity:**
```dart
// domain/entities/track_entity.dart
class TrackEntity extends Equatable {
  final String id;
  final String name;
  final String path;
  final Duration? duration;

  const TrackEntity({...});

  String get displayName => name.length > 30 ? '${name.substring(0, 27)}...' : name;

  @override
  List<Object?> get props => [id, name, path, duration];
}
```

**Пример Repository (Abstract):**
```dart
// domain/repositories/audio_repository.dart
abstract class AudioRepository {
  Future<Result<void>> loadTrack(TrackEntity track, {required int playerNumber});
  Future<Result<void>> play({required int playerNumber});
  Future<Result<void>> pause({required int playerNumber});
}
```

**Пример UseCase:**
```dart
// domain/usecases/audio/play_audio_usecase.dart
class PlayAudioUseCase extends UseCase<void, PlayAudioParams> {
  final AudioRepository audioRepository;

  PlayAudioUseCase({required this.audioRepository});

  @override
  Future<Result<void>> call(PlayAudioParams params) async {
    if (params.playerNumber < 1 || params.playerNumber > 2) {
      return Failure(message: 'Invalid player number');
    }
    return await audioRepository.play(playerNumber: params.playerNumber);
  }
}
```

---

### 3️⃣ DATA LAYER (Данные)

**Назначение:** Конкретная реализация работы с данными

**Включает:**
- **Models:** Data Transfer Objects (DTO) для сериализации JSON/SQL
- **DataSources:** Local (SharedPreferences, SQLite) и Remote (HTTP, API)
- **Repositories (Concrete):** Реализация абстрактных репозиториев из Domain

**Особенности:**
- ✅ Знает о HTTP, БД, файловой системе
- ✅ Преобразует данные из внешних источников в Domain Entities
- ✅ Реализует Repository интерфейсы из Domain слоя
- ✅ Может быть легко заменен на Mock для тестирования

**Пример Model:**
```dart
// data/models/track_model.dart
class TrackModel extends TrackEntity {
  const TrackModel({...});

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(...);
  }

  Map<String, dynamic> toJson() => {...};
}
```

**Пример Repository реализации:**
```dart
// data/repositories/audio_repository_impl.dart
class AudioRepositoryImpl implements AudioRepository {
  final AudioLocalDataSource localDataSource;
  final AudioRemoteDataSource remoteDataSource;

  AudioRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Result<void>> loadTrack(TrackEntity track, {required int playerNumber}) async {
    try {
      // Сначала проверяем локальные данные
      final localTrack = await localDataSource.getTrack(track.id);
      // Затем загружаем через плеер
      await _player.load(localTrack.path);
      return Success(null);
    } catch (e) {
      return Failure(message: 'Failed to load track: $e');
    }
  }
}
```

---

### 4️⃣ PRESENTATION LAYER (UI - MVVM)

**Назначение:** Интерфейс пользователя

**Включает:**
- **ViewModels:** Логика представления (не UI)
- **Screens:** Полные экраны (страницы)
- **Widgets:** Переиспользуемые UI компоненты

**Особенности:**
- ✅ ViewModels не знают о Flutter UI
- ✅ Widgets слушают изменения в ViewModel через Provider
- ✅ Вся бизнес-логика в UseCase/ViewModel, не в Widget
- ✅ Легко тестировать и переиспользовать

**Пример ViewModel:**
```dart
// presentation/viewmodels/audio_viewmodel.dart
class AudioViewModel extends BaseViewModel {
  final PlayAudioUseCase playAudioUseCase;
  final LoadTrackUseCase loadTrackUseCase;

  bool _isPlaying = false;
  TrackEntity? _currentTrack;

  bool get isPlaying => _isPlaying;
  TrackEntity? get currentTrack => _currentTrack;

  Future<void> playDeck1() async {
    setLoading();
    final result = await playAudioUseCase(PlayAudioParams(playerNumber: 1));
    
    result.fold(
      (failure) => setError(failure.message),
      (_) {
        _isPlaying = true;
        setSuccess();
        notifyListeners();
      },
    );
  }
}
```

**Пример Widget:**
```dart
// presentation/widgets/deck_widget.dart
class DeckWidget extends StatelessWidget {
  final AudioViewModel viewModel;

  const DeckWidget({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Column(
          children: [
            Text(viewModel.currentTrack?.displayName ?? 'No track'),
            ElevatedButton(
              onPressed: () => viewModel.playDeck1(),
              child: Text(viewModel.isPlaying ? 'Pause' : 'Play'),
            ),
          ],
        );
      },
    );
  }
}
```

---

### 5️⃣ SERVICES LAYER (Сервисы)

**Назначение:** Вспомогательные сервисы

**Включает:**
- **ServiceLocator:** Dependency Injection (GetIt)
- **ErrorHandlerService:** Централизованная обработка ошибок
- **LoggerService:** Обертка логирования

**Пример:**
```dart
// services/service_locator.dart
ServiceLocator.registerSingleton<PlayAudioUseCase>(
  PlayAudioUseCase(audioRepository: ServiceLocator.get()),
);

// Использование:
final playUseCase = ServiceLocator.get<PlayAudioUseCase>();
```

---

## 💡 Примеры использования

### Сценарий 1: Загрузка и воспроизведение трека

**Flow:**
```
Widget (DeckWidget) 
  → ViewModel.playDeck1() 
  → PlayAudioUseCase() 
  → AudioRepository.play() 
  → AudioDataSource / JustAudio library
```

**Код:**
```dart
// 1. В Widget слушаем ViewModel
class DeckWidget extends StatelessWidget {
  final AudioViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) => ElevatedButton(
        onPressed: () => viewModel.playDeck1(),
        child: Text(viewModel.isPlaying1 ? 'Pause' : 'Play'),
      ),
    );
  }
}

// 2. ViewModel вызывает UseCase
class AudioViewModel extends BaseViewModel {
  Future<void> playDeck1() async {
    setLoading();
    final result = await playAudioUseCase(PlayAudioParams(playerNumber: 1));
    result.fold(
      (failure) => setError(failure.message),
      (_) {
        _isPlaying1 = true;
        notifyListeners();
      },
    );
  }
}

// 3. UseCase валидирует и вызывает Repository
class PlayAudioUseCase extends UseCase<void, PlayAudioParams> {
  @override
  Future<Result<void>> call(PlayAudioParams params) async {
    if (params.playerNumber < 1 || params.playerNumber > 2) {
      return Failure(message: 'Invalid player number');
    }
    return await audioRepository.play(playerNumber: params.playerNumber);
  }
}

// 4. Repository выполняет бизнес-логику
class AudioRepositoryImpl implements AudioRepository {
  @override
  Future<Result<void>> play({required int playerNumber}) async {
    try {
      await _audioPlayer[playerNumber].play();
      return Success(null);
    } catch (e) {
      return Failure(message: 'Failed to play: $e');
    }
  }
}
```

---

### Сценарий 2: Применение EQ пресета

**Flow:**
```
Widget (EqualizerWidget)
  → ViewModel.applyPreset("Rock")
  → ApplyEQPresetUseCase()
  → EqualizerRepository.applyPreset()
  → DataSource / Audio Filter
```

---

## ✨ Best Practices

### 1. **Разделение ответственности**

```dart
// ❌ ПЛОХО: Бизнес-логика в Widget
ElevatedButton(
  onPressed: () {
    audioPlayer.play();
    isPlaying = true;
    setState(() {});
  },
)

// ✅ ХОРОШО: Логика в ViewModel
ElevatedButton(
  onPressed: () => viewModel.play(),
)
```

### 2. **Валидация в UseCase**

```dart
// ✅ Валидация в UseCase
class PlayAudioUseCase extends UseCase<void, PlayAudioParams> {
  @override
  Future<Result<void>> call(PlayAudioParams params) async {
    if (params.playerNumber < 1 || params.playerNumber > 2) {
      return Failure(message: 'Invalid player number');
    }
    return await audioRepository.play(playerNumber: params.playerNumber);
  }
}
```

### 3. **Использование Result для обработки ошибок**

```dart
// ✅ Правильная обработка ошибок
result.fold(
  (failure) {
    Logger.error(failure.message);
    showErrorSnackbar(context, failure.message);
  },
  (success) {
    showSuccessSnackbar(context, 'Operation successful');
  },
);
```

### 4. **Логирование на разных уровнях**

```dart
Logger.debug('Debug information');       // Только при разработке
Logger.info('Track loaded');              // Информационные сообщения
Logger.warning('High memory usage');      // Предупреждения
Logger.error('Failed to load track');     // Ошибки
```

### 5. **Использование Extensions для удобства**

```dart
// ✅ Extensions в core/extensions/
Duration duration = Duration(seconds: 125);
print(duration.toFormattedString()); // "2:05"

String filePath = "/path/to/song.mp3";
print(filePath.fileExtension);        // "mp3"
print(filePath.isAudioFile);          // true

double value = 50.0;
print(value.percentToRatio());        // 0.5
```

### 6. **Dependency Injection для тестирования**

```dart
// ✅ Легко создавать Mock для тестов
class MockAudioRepository implements AudioRepository {
  @override
  Future<Result<void>> play({required int playerNumber}) async {
    return Success(null);
  }
}

// В тесте:
final mockRepo = MockAudioRepository();
final useCase = PlayAudioUseCase(audioRepository: mockRepo);
final result = await useCase(PlayAudioParams(playerNumber: 1));
```

---

## 📊 Когда что использовать

| Компонент | Когда использовать | Пример |
|-----------|-------------------|---------|
| **Entity** | Для модели домена | `TrackEntity`, `EQPresetEntity` |
| **Model** | Для JSON/DB сериализации | `TrackModel.fromJson()` |
| **UseCase** | Для одной бизнес-операции | `PlayAudioUseCase` |
| **Repository** | Для работы с данными | `AudioRepository` |
| **ViewModel** | Для логики UI | `AudioViewModel` |
| **Widget** | Только для отображения | `DeckWidget` |
| **Extension** | Для удобных методов | `DurationExtension` |
| **Constant** | Для неизменяемых значений | `AudioConstants.eqBandCount` |

---

## 🧪 Тестирование

### Юнит-тест для UseCase

```dart
test('PlayAudioUseCase returns Success when audio plays', () async {
  // Arrange
  final mockRepository = MockAudioRepository();
  final useCase = PlayAudioUseCase(audioRepository: mockRepository);
  
  // Act
  final result = await useCase(PlayAudioParams(playerNumber: 1));
  
  // Assert
  expect(result, isA<Success>());
});

test('PlayAudioUseCase returns Failure for invalid player', () async {
  // Arrange
  final mockRepository = MockAudioRepository();
  final useCase = PlayAudioUseCase(audioRepository: mockRepository);
  
  // Act
  final result = await useCase(PlayAudioParams(playerNumber: 0));
  
  // Assert
  expect(result, isA<Failure>());
  expect(result.fold((f) => f.code, (_) => null), 'INVALID_PLAYER');
});
```

---

## 🚀 Миграция существующего кода

1. **Шаг 1:** Создать Entity классы для существующих Models
2. **Шаг 2:** Создать абстрактные Repository интерфейсы
3. **Шаг 3:** Создать UseCase для каждой операции
4. **Шаг 4:** Создать ViewModel с UseCase
5. **Шаг 5:** Обновить Widgets для использования ViewModel
6. **Шаг 6:** Создать реализации Repository в Data слое

---

**Дата:** 7 января 2026  
**Версия:** 1.0.0 MVVM Refactoring

