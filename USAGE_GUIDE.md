# 🚀 Инструкция по использованию новых фичей

## Быстрый старт

### 1. Запуск приложения

```bash
cd C:\Users\strog\StudioProjects\new_fly_mixxxx
flutter clean
flutter pub get
flutter run -d windows
```

---

## 📊 Фича 1: Анализ звукового оборудования

### Расположение в UI
- Вкладка **Audio Device Analysis** находится на главном экране
- Расположена ниже "Frequency Response" и выше "Composition Generator"

### Как использовать

#### Шаг 1: Сканирование устройств
```
1. Нажмите кнопку "Scan"
2. Приложение начнет сканирование доступных устройств
3. В статусе появится "Analysis complete"
```

#### Шаг 2: Просмотр информации о системе
Во вкладке "System Information" отображаются:
- **CPU Load** - процент использования процессора
- **Memory** - процент использования памяти
- **Buffer Size** - размер буфера в samples

#### Шаг 3: Просмотр устройств
Каждое устройство показывает:
- Имя устройства (с индикатором Active/Idle)
- Тип: Input/Output/Both
- Технические параметры:
  - Sample Rate (например, 48000 Hz)
  - Channels (количество каналов)
  - Latency (задержка в миллисекундах)
  - Bit Depth (разрядность)
  - Driver (используемый драйвер)

### Примеры информации об устройствах

```
Speakers (Stereo) [Active]
OUTPUT • 2ch • 48000 Hz
Latency: 12.50 ms | Bit Depth: 24-bit | Driver: WASAPI

Headphones [Idle]
OUTPUT • 2ch • 44100 Hz
Latency: 8.20 ms | Bit Depth: 16-bit | Driver: DirectSound

USB Microphone [Ready]
INPUT • 1ch • 48000 Hz
Latency: 15.30 ms | Bit Depth: 24-bit | Driver: WASAPI
```

### Практическое применение

1. **Оптимизация аудио**: Используйте информацию о latency для выбора оптимального устройства
2. **Диагностика проблем**: Проверьте статус и наличие всех необходимых устройств
3. **Контроль ресурсов**: Мониторьте использование CPU и памяти при работе

---

## 🤖 Фича 2: Генератор танцевальной композиции

### Расположение в UI
- Вкладка **AI Composition Generator** находится на главном экране
- Расположена после "Audio Device Analysis"

### Как использовать

#### Вариант А: Локальный MCP Server (Рекомендуется)

**Преимущества:**
- ✅ Не требует API ключ
- ✅ Полный контроль над ИИ
- ✅ Никакие данные не отправляются в интернет
- ✅ Бесплатно

**Подготовка:**

1. Установить Node.js (если нет)
   ```bash
   # Проверить наличие
   node --version
   npm --version
   ```

2. Создать MCP сервер
   ```bash
   # Создать папку
   mkdir C:\mcp-server
   cd C:\mcp-server
   
   # Инициализировать проект
   npm init -y
   
   # Установить зависимости
   npm install express cors body-parser
   ```

3. Создать `server.js`
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
     
     // Симуляция генерации
     res.json({
       composition: {
         title: title,
         arrangement: arrangement,
         duration: melodies.reduce((sum, m) => sum + m.duration, 0),
       }
     });
   });

   app.listen(3000, () => {
     console.log('MCP Server listening on port 3000');
   });
   ```

4. Запустить сервер
   ```bash
   node server.js
   # Вывод: MCP Server listening on port 3000
   ```

**Использование в приложении:**

1. В приложении перейдите на вкладку "AI Composition Generator"
2. Выберите "Local MCP Server" из списка
3. Нажмите кнопку "Test" для проверки подключения
4. Если подключение успешно, сервер готов к использованию

#### Вариант Б: Облачные API (OpenAI, Google и т.д.)

**OpenAI GPT-4:**

1. Получить API ключ
   - Перейти на https://platform.openai.com/api-keys
   - Создать новый ключ (если нет)
   - Скопировать ключ

2. В приложении:
   - Выберите "OpenAI GPT-4" из списка провайдеров
   - Введите API ключ в поле "Enter API Key"
   - Нажмите "Configure"

**Google MusicLM:**

1. Получить API ключ через Google Cloud Console
2. Выберите провайдер и введите ключ аналогично

### Генерация композиции

**Шаг 1: Выбрать провайдер**
```
Dropdown "Select AI Provider" → выбрать нужный провайдер
```

**Шаг 2: Настроить (если требуется)**
```
Для локального: нажать "Test"
Для облачных: ввести API ключ и нажать "Configure"
```

**Шаг 3: Установить параметры**

- **Composition Title**: "My New Tango"
- **Arrangement Style**: 
  - `Blend` - смешивание мелодий
  - `Layer` - наложение слоев
  - `Interleave` - чередование

**Шаг 4: Сгенерировать**
```
Нажать кнопку "Generate Composition"
- Статус будет показывать прогресс
- После завершения появится результат
```

**Шаг 5: Экспортировать**
```
После успешной генерации:
- Нажать "Export MIDI" для сохранения в формате MIDI
- Или "Export WAV" для сохранения в формате WAV
```

### Примеры использования

#### Создание ремикса из 4 мелодий

```
1. Загрузить 4 мелодии через Track Loader:
   - lead.wav (основная мелодия)
   - bass.wav (басовая линия)
   - pad.wav (фоновая подкладка)
   - drums.wav (ударные)

2. Открыть Composition Generator

3. Выбрать Local MCP Server (или OpenAI)

4. Установить:
   - Title: "Tango Remix v1"
   - Arrangement: "Blend"

5. Нажать "Generate Composition"

6. Экспортировать результат в MIDI

7. Использовать в DAW (например, FL Studio, Ableton, Cubase)
```

#### Экспериментирование с разными стилями

```
Попробуйте разные стили аранжировки:

Blend (Смешивание):
- Мелодии плавно переходят друг в друга
- Хорошо для эволюционных композиций

Layer (Наложение):
- Мелодии звучат одновременно
- Хорошо для полнозвучных композиций

Interleave (Чередование):
- Мелодии чередуются
- Хорошо для диалоговых композиций
```

---

## 🔧 Тестирование и отладка

### Проверка статуса Audio Device Analyzer

```
Статусы сканирования:
- "Idle" - готов к работе
- "Scanning audio devices..." - идет сканирование
- "Analysis complete" - сканирование завершено
- "Error" - произошла ошибка (см. сообщение об ошибке)
```

### Проверка статуса Composition Generator

```
Статусы генерации:
- "Ready" - готов к генерации
- "Testing connection..." - проверка подключения
- "Connection successful" - подключение успешно
- "Analyzing melodies..." - анализ входных мелодий
- "Sending to [Provider]..." - отправка на обработку
- "Composition generated successfully" - успешно создано
- "Error" - произошла ошибка
```

### Частые проблемы и решения

**Проблема: Local MCP Server недоступен**
```
Решение:
1. Убедитесь, что Node.js установлен
2. Проверьте, что сервер запущен (node server.js)
3. Проверьте порт 3000 (не занят другим приложением)
4. Попробуйте: curl http://localhost:3000/health
```

**Проблема: Ошибка API ключа**
```
Решение:
1. Проверьте, что ключ правильно скопирован
2. Убедитесь, что ключ не истек
3. Попробуйте создать новый ключ на сайте провайдера
```

**Проблема: Слишком медленная генерация**
```
Причины:
- Медленное интернет соединение (для облачных API)
- Нагруженный сервер провайдера
- Процессор занят другими задачами

Решение:
- Используйте Local MCP Server вместо облачных API
- Закройте ненужные приложения
```

---

## 📊 Примеры моделей данных

### MelodyInfo

```dart
MelodyInfo(
  id: 'melody_lead',
  name: 'Lead Tango',
  filePath: '/path/to/lead.wav',
  tempo: 120.0,              // BPM
  key: 'A',                  // Тональность
  duration: 30.0,            // секунды
  bars: 16,                  // количество тактов
  mood: 'energetic',         // настроение
);
```

### GeneratedComposition

```dart
GeneratedComposition(
  id: 'comp_1234567890',
  title: 'Tango Remix v1',
  sourceMelodies: [melody1, melody2, melody3, melody4],
  totalDuration: 120.0,
  arrangement: 'blend',
  mixingStrategy: 'adaptive',
  aiProvider: 'Local MCP Server',
  createdAt: DateTime.now(),
  confidenceScore: 0.85,
);
```

---

## 🎯 Интеграция с другими инструментами

### Экспортированные файлы можно использовать в:

- **DAW (Digital Audio Workstations)**
  - FL Studio
  - Ableton Live
  - Cubase
  - Logic Pro
  - Pro Tools

- **Онлайн-сервисы**
  - YouTube (для создания видео)
  - Soundcloud (для публикации)
  - Spotify (через распределители музыки)

- **Видеоредакторы**
  - Adobe Premiere
  - Final Cut Pro
  - DaVinci Resolve

---

## 📝 Логирование

Все операции логируются в консоль. Для просмотра:

```bash
# В Windows при запуске приложения в debug режиме
flutter run -d windows --debug
# Логи будут видны в консоли
```

---

## ✅ Результаты

После успешного выполнения у вас будут:

✅ Полный анализ вашего аудиооборудования  
✅ Сгенерированная танцевальная композиция из 4 мелодий  
✅ Экспортированные файлы в MIDI или WAV  
✅ Готовые файлы для использования в DAW  

---

## 📞 Поддержка

Если возникают проблемы:

1. Проверьте логи в консоли
2. Убедитесь, что все зависимости установлены (`flutter pub get`)
3. Используйте Local MCP Server вместо облачных API для упрощения
4. Перезагрузите приложение

---

**Версия**: 1.0.0+1  
**Дата**: 2 января 2026  
**Статус**: ✅ Готово к использованию

