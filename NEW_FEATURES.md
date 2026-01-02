# 🎵 Fly Mixxx - Новые Фичи

## ✨ Добавленные функции

### 1. 📊 Анализ звукового оборудования (Audio Device Analysis)

Полная система анализа и мониторинга доступного аудиооборудования.

#### Возможности:
- **Сканирование устройств** - автоматическое обнаружение подключенных аудиоустройств
- **Детальная информация о устройствах**:
  - Имя и тип (входное, выходное, двусторонее)
  - Количество каналов
  - Частота дискретизации (Sample Rate)
  - Разрядность (Bit Depth)
  - Задержка (Latency) в миллисекундах
  - Драйвер (WASAPI, DirectSound, ASIO, MME)
  - Статус подключения

- **Системная информация**:
  - Использование CPU
  - Использование памяти
  - Размер буфера
  - Статистика под/переполнения (Xruns)

- **Тестирование подключения** - проверка работоспособности устройств

#### Использование:
```dart
// Получить анализатор из context
final analyzer = context.read<AudioDeviceAnalyzer>();

// Запустить сканирование
await analyzer.analyzeAudioDevices();

// Получить список устройств
List<AudioDevice> devices = analyzer.devices;

// Тестировать устройство
bool testResult = await analyzer.testAudioDevice(deviceId);

// Получить метрики буфера
Map<String, dynamic> metrics = await analyzer.getBufferMetrics();
```

#### Модели данных:
```dart
class AudioDevice {
  final String id;
  final String name;
  final String type;        // 'input', 'output', 'both'
  final int channels;
  final int sampleRate;
  final int bitDepth;
  final bool isActive;
  final double latency;     // ms
  final String driver;
  final String status;
}

class AudioSystemInfo {
  final List<AudioDevice> devices;
  final AudioDevice? defaultInput;
  final AudioDevice? defaultOutput;
  final String systemName;
  final double cpuLoad;
  final double memoryUsage;
  final int bufferSize;
}
```

---

### 2. 🤖 Генератор танцевальной композиции (Composition Generator)

AI-powered создание новых танцевальных композиций из 4 исходных мелодий.

#### Поддерживаемые AI провайдеры:

1. **OpenAI GPT-4** (облачный)
   - URL: https://api.openai.com/v1
   - Требует API ключ OpenAI

2. **Google MusicLM** (облачный)
   - URL: https://music-lm.googleapis.com/v1
   - Требует API ключ Google

3. **Local MCP Server** (локальный)
   - URL: http://localhost:3000
   - Развертывается на локальной машине
   - Не требует API ключа

4. **OpenAI Jukebox** (облачный)
   - URL: https://jukebox.openai.com/api
   - Генерация музыки из текстовых подсказок

5. **Mubert AI** (облачный)
   - URL: https://api.mubert.com/v1
   - Сервис AI генерации музыки

#### Возможности:

- **Выбор провайдера** - выбрать предпочитаемый AI сервис
- **Конфигурация API** - установить API ключ для облачных сервисов
- **Тестирование подключения** - проверить связь с провайдером
- **Анализ мелодий** - автоматический анализ 4 входных мелодий
- **Создание композиции**:
  - Стили аранжировки: Blend, Layer, Interleave
  - Настройка параметров микширования
  - Отслеживание прогресса в реальном времени
- **Экспорт результатов** - сохранение как MIDI или WAV

#### Использование:

```dart
// Получить генератор
final generator = context.read<CompositionGeneratorProvider>();

// Выбрать провайдер
generator.selectProvider('local-mcp');

// Настроить API (только для облачных сервисов)
await generator.configureApiKey('your-api-key');

// Тестировать подключение
bool connected = await generator.testConnection();

// Создать композицию из 4 мелодий
GeneratedComposition? composition = await generator.generateComposition(
  [melody1, melody2, melody3, melody4],
  'My New Composition',
  'blend',  // arrangement style
);

// Экспортировать результат
String? fileName = await generator.exportComposition(
  composition,
  'midi',  // или 'wav'
);
```

#### Модели данных:

```dart
class MelodyInfo {
  final String id;
  final String name;
  final String filePath;
  final double tempo;         // BPM
  final String key;           // C, D, E, etc
  final double duration;      // seconds
  final int bars;
  final List<double> frequencies;  // dominant frequencies
  final String mood;          // happy, sad, energetic, calm
}

class GeneratedComposition {
  final String id;
  final String title;
  final List<MelodyInfo> sourceMelodies;
  final double totalDuration;
  final String arrangement;   // blend, layer, interleave
  final String mixingStrategy;
  final String aiProvider;
  final DateTime createdAt;
  final double confidenceScore;
  final Map<String, dynamic> metadata;
}

class AIProviderConfig {
  final String id;
  final String name;
  final String description;
  final String apiUrl;
  final String? apiKey;
  final bool isLocal;
  final Map<String, dynamic> params;
  final bool isConfigured;
}
```

---

## 🏗️ Архитектура

### Новые файлы:

```
lib/
├── models/
│   ├── audio_device_model.dart          # AudioDevice, AudioSystemInfo
│   └── composition_model.dart           # MelodyInfo, GeneratedComposition, AIProviderConfig
├── providers/
│   ├── audio_device_analyzer.dart       # AudioDeviceAnalyzer (ChangeNotifier)
│   └── composition_generator.dart       # CompositionGeneratorProvider (ChangeNotifier)
└── widgets/
    ├── audio_device_analysis_widget.dart    # UI для анализа оборудования
    └── composition_generator_widget.dart    # UI для генерации композиций
```

### Интеграция в UI:

Оба виджета автоматически добавлены на главный экран `mixer_screen.dart` между стандартными компонентами и секцией "About".

---

## 🚀 Развертывание Local MCP Server

Для использования локального MCP сервера:

### 1. Установка Node.js
```bash
# Windows
# Скачать с https://nodejs.org/

# Или через chocolatey
choco install nodejs
```

### 2. Создание MCP сервера

```bash
# Создать папку проекта
mkdir mcp-server && cd mcp-server

# Инициализировать проект
npm init -y

# Установить зависимости
npm install express body-parser cors
```

### 3. Создать server.js

```javascript
const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

// Composition generation endpoint
app.post('/compose', (req, res) => {
  const { melodies, title, arrangement } = req.body;
  
  // Ваша логика генерации композиции здесь
  // ...
  
  res.json({
    composition: {
      title: title,
      arrangement: arrangement,
      duration: 120,
    }
  });
});

app.listen(3000, () => {
  console.log('MCP Server listening on port 3000');
});
```

### 4. Запуск сервера

```bash
npm start
# Или прямо
node server.js
```

---

## 📡 API примеры

### Анализ оборудования

```dart
final analyzer = AudioDeviceAnalyzer();

// Сканировать устройства
await analyzer.analyzeAudioDevices();

// Результаты
print('Найдено устройств: ${analyzer.devices.length}');
for (var device in analyzer.devices) {
  print('${device.name} - ${device.sampleRate} Hz, ${device.channels} каналов');
}

// Системная информация
if (analyzer.systemInfo != null) {
  print('CPU Load: ${analyzer.systemInfo!.cpuLoad}%');
  print('Memory: ${analyzer.systemInfo!.memoryUsage}%');
}
```

### Генерация композиции

```dart
final generator = CompositionGeneratorProvider();

// Выбрать локальный MCP сервер
generator.selectProvider('local-mcp');

// Тестировать подключение
bool ok = await generator.testConnection();
if (!ok) {
  print('MCP Server недоступен!');
  return;
}

// Создать 4 мелодии
final melodies = [
  MelodyInfo(id: '1', name: 'Lead', filePath: 'lead.wav', tempo: 120, 
             key: 'C', duration: 30, bars: 16, mood: 'energetic'),
  MelodyInfo(id: '2', name: 'Bass', filePath: 'bass.wav', tempo: 120,
             key: 'C', duration: 30, bars: 16, mood: 'deep'),
  MelodyInfo(id: '3', name: 'Pad', filePath: 'pad.wav', tempo: 120,
             key: 'C', duration: 30, bars: 16, mood: 'atmospheric'),
  MelodyInfo(id: '4', name: 'Drums', filePath: 'drums.wav', tempo: 120,
             key: 'C', duration: 30, bars: 16, mood: 'rhythmic'),
];

// Генерировать композицию
final composition = await generator.generateComposition(
  melodies,
  'New Tango Remix',
  'blend'
);

if (composition != null) {
  print('Композиция создана: ${composition.title}');
  print('Провайдер: ${composition.aiProvider}');
  print('Уверенность: ${(composition.confidenceScore * 100).toStringAsFixed(0)}%');
  
  // Экспортировать
  final midiFile = await generator.exportComposition(composition, 'midi');
  print('Сохранено: $midiFile');
}
```

---

## 🔧 Конфигурация провайдеров

### OpenAI GPT-4

```dart
// Получить API ключ с https://platform.openai.com/api-keys
generator.selectProvider('openai');
await generator.configureApiKey('sk-...');
```

### Local MCP Server

```dart
// Убедитесь, что сервер запущен на localhost:3000
generator.selectProvider('local-mcp');
await generator.testConnection();  // Это должно вернуть true
```

### Google MusicLM

```dart
// Требует Google Cloud API ключ
generator.selectProvider('google-music');
await generator.configureApiKey('YOUR_GOOGLE_API_KEY');
```

---

## 📊 Мониторинг и диагностика

### Проверка состояния

```dart
// Из AudioDeviceAnalyzer
print(analyzer.status);           // Current operation status
print(analyzer.errorMessage);     // Last error if any
print(analyzer.isAnalyzing);      // Is scanning in progress

// Из CompositionGeneratorProvider
print(generator.status);          // Current status
print(generator.generationProgress); // 0.0 to 1.0
print(generator.isGenerating);    // Is generation in progress
```

### Логирование

Все операции логируются через печать в консоль и сохраняют статус в провайдере.

---

## ⚙️ Требования

### Для анализа оборудования:
- Windows 10+
- Audio drivers установлены

### Для облачных AI провайдеров:
- Интернет соединение
- API ключ провайдера

### Для локального MCP сервера:
- Node.js 14+
- localhost доступен на порту 3000

---

## 🎯 Примеры использования в UI

Обе фичи полностью интегрированы в главный экран:

```dart
// Audio Device Analysis Widget
const AudioDeviceAnalysisWidget()

// Composition Generator Widget  
const CompositionGeneratorWidget()
```

Они появляются автоматически при открытии приложения в секции ниже эквалайзера.

---

## 📝 Версия

- **Версия проекта**: 1.0.0+1
- **Дата добавления**: 2 января 2026
- **Статус**: ✅ Готово к использованию

---

## 🔗 Ссылки

- [OpenAI API Docs](https://platform.openai.com/docs)
- [Google MusicLM](https://research.google.com/musiclm/)
- [Model Context Protocol](https://modelcontextprotocol.io/)
- [Mubert API](https://mubert.com/api)


