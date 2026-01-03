# Примеры использования и расширения Fly Mixxx

## 📁 Структура папки

```
examples/
├── mcp-server.js          # Локальный MCP сервер
├── package.json           # Зависимости для Node.js
├── README.md              # Этот файл
└── advanced-configurations/
    └── (примеры для расширенной конфигурации)
```

## 🚀 Локальный MCP Сервер

### Что такое MCP?

**MCP** (Model Context Protocol) - это протокол для работы с моделями машинного обучения и системами генерации контента.

**Локальный MCP сервер** для Fly Mixxx позволяет:
- Генерировать музыкальные композиции локально (без облака)
- Анализировать музыкальные мелодии
- Работать полностью оффлайн
- Не платить за API запросы

### Быстрый старт (3 минуты)

#### 1. Установка Node.js

Скачайте и установите Node.js (версия 14+) с https://nodejs.org/

#### 2. Установка зависимостей

```bash
# Перейдите в папку examples
cd C:\Users\strog\StudioProjects\new_fly_mixxxx\examples

# Установите зависимости
npm install
```

#### 3. Запуск сервера

```bash
npm start
```

Вы должны увидеть:

```
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║     MCP Music Composition Server v1.0.0                      ║
║                                                              ║
║     Server running at: http://localhost:3000                 ║
║                                                              ║
║     Available Endpoints:                                     ║
║     • GET  /health         - Health check                    ║
║     • GET  /status         - Server status                   ║
║     • GET  /arrangements   - Available arrangements          ║
║     • GET  /providers      - Available AI providers           ║
║     • POST /analyze-melody - Analyze melody                  ║
║     • POST /compose        - Generate composition            ║
║     • POST /export         - Export composition              ║
║                                                              ║
║     To stop the server, press Ctrl+C                         ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
```

#### 4. Подтверждение работы сервера

Откройте браузер и перейдите на:
```
http://localhost:3000/health
```

Должны увидеть ответ с информацией о сервере.

#### 5. Использование в Fly Mixxx

1. Откройте Fly Mixxx приложение
2. В разделе **AI Composition Generator**
3. Выберите **"Local MCP Server"** из списка провайдеров
4. Сервер должен автоматически подключиться

---

## 📡 API Endpoints

### Проверка здоровья сервера

```http
GET http://localhost:3000/health
```

**Ответ:**
```json
{
  "status": "healthy",
  "service": "MCP Music Composition Server",
  "version": "1.0.0",
  "timestamp": "2024-01-03T12:34:56.789Z"
}
```

### Статус сервера

```http
GET http://localhost:3000/status
```

**Ответ:**
```json
{
  "service": "MCP Music Composition Server",
  "status": "running",
  "version": "1.0.0",
  "uptime": "2h 30m 15s",
  "timestamp": "2024-01-03T12:34:56.789Z",
  "capabilities": [
    "melody-analysis",
    "composition-generation",
    "arrangement-synthesis",
    "export-to-midi",
    "export-to-wav"
  ]
}
```

### Список доступных аранжировок

```http
GET http://localhost:3000/arrangements
```

**Ответ:**
```json
{
  "arrangements": [
    {
      "type": "blend",
      "description": "Smooth blending of all melodies",
      "useCase": "General harmonic combination"
    },
    {
      "type": "sequential",
      "description": "Melodies play one after another",
      "useCase": "Narrative or storytelling style"
    },
    {
      "type": "harmony",
      "description": "Harmonic layering with emphasis on vertical harmony",
      "useCase": "Classical or jazz arrangements"
    },
    {
      "type": "rhythm",
      "description": "Rhythmic combination with beat alignment",
      "useCase": "Dance or electronic music"
    }
  ]
}
```

### Список доступных AI провайдеров

```http
GET http://localhost:3000/providers
```

**Ответ:**
```json
{
  "providers": [
    {
      "id": "local-mcp",
      "name": "Local MCP Server",
      "description": "Locally deployed Model Context Protocol server",
      "isLocal": true,
      "status": "active"
    }
  ]
}
```

### Анализ мелодии

```http
POST http://localhost:3000/analyze-melody
Content-Type: application/json

{
  "melody": {
    "id": "melody_1",
    "name": "My Melody",
    "tempo": 120,
    "key": "C",
    "timeSignature": "4/4",
    "duration": 8.5,
    "bars": 8,
    "frequencies": [440, 494, 523]
  }
}
```

**Ответ:**
```json
{
  "success": true,
  "analysis": {
    "id": "melody_1",
    "name": "My Melody",
    "tempo": 120,
    "key": "C",
    "timeSignature": "4/4",
    "duration": 8.5,
    "bars": 8,
    "frequencies": [440, 494, 523],
    "mood": "bright",
    "harmonyProfile": {
      "major": 0.7,
      "minor": 0.3
    },
    "rhythmPattern": "steady",
    "complexity": 0.65
  }
}
```

### Генерация композиции

```http
POST http://localhost:3000/compose
Content-Type: application/json

{
  "melodies": [
    {
      "id": "mel1",
      "name": "Melody 1",
      "tempo": 120,
      "key": "C",
      "duration": 8
    },
    {
      "id": "mel2",
      "name": "Melody 2",
      "tempo": 120,
      "key": "C",
      "duration": 8
    },
    {
      "id": "mel3",
      "name": "Melody 3",
      "tempo": 120,
      "key": "C",
      "duration": 8
    },
    {
      "id": "mel4",
      "name": "Melody 4",
      "tempo": 120,
      "key": "C",
      "duration": 8
    }
  ],
  "title": "My Composition",
  "arrangement": "harmony",
  "provider": "local-mcp"
}
```

**Ответ:**
```json
{
  "success": true,
  "composition": {
    "id": "comp_1704282896789",
    "title": "My Composition",
    "sourceMelodies": [
      {
        "id": "mel1",
        "name": "Melody 1",
        "tempo": 120,
        "key": "C"
      }
    ],
    "totalDuration": 32,
    "arrangement": "harmony",
    "mixingStrategy": "adaptive",
    "aiProvider": "local-mcp",
    "createdAt": "2024-01-03T12:34:56.789Z",
    "confidenceScore": 0.85,
    "metadata": {
      "version": "1.0",
      "processingTime": "3.5s"
    }
  }
}
```

### Экспорт композиции

```http
POST http://localhost:3000/export
Content-Type: application/json

{
  "compositionId": "comp_1704282896789",
  "format": "midi"
}
```

**Ответ:**
```json
{
  "success": true,
  "fileName": "composition_comp_1704282896789.midi",
  "format": "midi",
  "downloadUrl": "/downloads/composition_comp_1704282896789.midi",
  "size": "estimated 5.2 MB",
  "message": "Export to MIDI prepared"
}
```

---

## 🔧 Развитие и расширение

### Добавление пользовательских алгоритмов

Вы можете расширить MCP сервер, добавив:

1. **Собственные алгоритмы генерации** в функцию `/compose`
2. **Интеграцию с другими AI моделями** (TensorFlow, PyTorch и т.д.)
3. **Сохранение истории композиций** в базу данных
4. **Веб-интерфейс управления** для сервера

### Примеры расширений

#### Интеграция с TensorFlow.js

```javascript
const tf = require('@tensorflow/tfjs');

app.post('/analyze-with-ai', async (req, res) => {
  try {
    const { melodyData } = req.body;
    
    // Загружаем предобученную модель
    const model = await tf.loadLayersModel('file://model/model.json');
    
    // Обрабатываем мелодию
    const predictions = model.predict(tf.tensor2d([melodyData]));
    
    res.json({
      success: true,
      predictions: predictions.dataSync()
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

#### Сохранение в базу данных

```javascript
const sqlite3 = require('sqlite3');
const db = new sqlite3.Database(':memory:');

app.post('/save-composition', (req, res) => {
  const { title, arrangement, data } = req.body;
  
  db.run(
    'INSERT INTO compositions (title, arrangement, data, createdAt) VALUES (?, ?, ?, ?)',
    [title, arrangement, JSON.stringify(data), new Date().toISOString()],
    function(err) {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
      res.json({ success: true, id: this.lastID });
    }
  );
});
```

---

## 🐛 Решение проблем

### Сервер не запускается

**Проблема:** `Port 3000 already in use`

**Решение:**
```bash
# Используйте другой порт
PORT=3001 npm start
```

### Ошибка при подключении к серверу из Fly Mixxx

**Проблема:** `Connection refused`

**Решение:**
1. Убедитесь, что сервер запущен
2. Проверьте `http://localhost:3000/health` в браузере
3. Используйте IP адрес `http://127.0.0.1:3000` если localhost не работает

### Composition не генерируется

**Проблема:** `400 Bad Request`

**Решение:**
1. Убедитесь, что вы отправляете ровно 4 мелодии
2. Проверьте, что все обязательные поля заполнены
3. Используйте правильный тип аранжировки

---

## 📚 Полезные ссылки

- [Express.js документация](https://expressjs.com/)
- [Node.js Best Practices](https://nodejs.org/en/docs/)
- [CORS информация](https://enable-cors.org/)
- [REST API дизайн](https://restfulapi.net/)

---

## 📝 Лицензия

Этот проект лицензирован под MIT License.

---

**Успешной работы с Fly Mixxx! 🎵**

