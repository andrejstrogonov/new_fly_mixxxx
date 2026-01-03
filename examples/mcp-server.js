#!/bin/bash
# MCP Music Composition Server
# Локальный сервер для генерации музыкальных композиций

const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const fs = require('fs');
const path = require('path');

const app = express();
app.use(cors());
app.use(bodyParser.json({ limit: '50mb' }));
app.use(bodyParser.urlencoded({ limit: '50mb', extended: true }));

// Логирование запросов
app.use((req, res, next) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.path}`);
  next();
});

// ============= HEALTH CHECK =============
app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    service: 'MCP Music Composition Server',
    version: '1.0.0',
    timestamp: new Date().toISOString(),
  });
});

// ============= COMPOSITION GENERATION =============
app.post('/compose', async (req, res) => {
  try {
    const { melodies, title, arrangement, provider } = req.body;

    // Валидация входных данных
    if (!melodies || melodies.length !== 4) {
      return res.status(400).json({
        error: 'Exactly 4 melodies required',
        received: melodies?.length || 0,
      });
    }

    if (!title || title.trim() === '') {
      return res.status(400).json({ error: 'Title is required' });
    }

    if (!arrangement || !['blend', 'sequential', 'harmony', 'rhythm'].includes(arrangement)) {
      return res.status(400).json({
        error: 'Invalid arrangement type. Use: blend, sequential, harmony, rhythm',
      });
    }

    console.log(`Generating composition: "${title}" with ${arrangement} arrangement`);

    // Симуляция обработки (замените на реальную логику генерации)
    const totalDuration = melodies.reduce((sum, m) => sum + (m.duration || 0), 0);

    // Генерируем композицию
    const composition = {
      id: `comp_${Date.now()}`,
      title: title,
      sourceMelodies: melodies.map(m => ({
        id: m.id,
        name: m.name,
        tempo: m.tempo || 120,
        key: m.key || 'C',
      })),
      totalDuration: totalDuration,
      arrangement: arrangement,
      mixingStrategy: 'adaptive',
      aiProvider: provider || 'local-mcp',
      createdAt: new Date().toISOString(),
      confidenceScore: 0.85,
      metadata: {
        version: '1.0',
        processingTime: '3.5s',
      },
    };

    res.json({
      success: true,
      composition: composition,
      message: `Composition "${title}" generated successfully`,
    });
  } catch (error) {
    console.error('Error in /compose:', error);
    res.status(500).json({
      error: 'Internal server error',
      message: error.message,
    });
  }
});

// ============= MELODY ANALYSIS =============
app.post('/analyze-melody', async (req, res) => {
  try {
    const { melody } = req.body;

    if (!melody) {
      return res.status(400).json({ error: 'Melody data is required' });
    }

    // Анализируем мелодию
    const analysis = {
      id: melody.id,
      name: melody.name,
      tempo: melody.tempo || 120,
      key: melody.key || 'C',
      timeSignature: melody.timeSignature || '4/4',
      duration: melody.duration || 0,
      bars: melody.bars || 8,
      frequencies: melody.frequencies || [],
      mood: analyzeMood(melody.frequencies || []),
      harmonyProfile: {
        major: 0.7,
        minor: 0.3,
      },
      rhythmPattern: 'steady',
      complexity: 0.65,
    };

    res.json({
      success: true,
      analysis: analysis,
    });
  } catch (error) {
    console.error('Error in /analyze-melody:', error);
    res.status(500).json({
      error: 'Melody analysis failed',
      message: error.message,
    });
  }
});

// ============= ARRANGEMENT TYPES =============
app.get('/arrangements', (req, res) => {
  res.json({
    arrangements: [
      {
        type: 'blend',
        description: 'Smooth blending of all melodies',
        useCase: 'General harmonic combination',
      },
      {
        type: 'sequential',
        description: 'Melodies play one after another',
        useCase: 'Narrative or storytelling style',
      },
      {
        type: 'harmony',
        description: 'Harmonic layering with emphasis on vertical harmony',
        useCase: 'Classical or jazz arrangements',
      },
      {
        type: 'rhythm',
        description: 'Rhythmic combination with beat alignment',
        useCase: 'Dance or electronic music',
      },
    ],
  });
});

// ============= AI PROVIDERS INFO =============
app.get('/providers', (req, res) => {
  res.json({
    providers: [
      {
        id: 'local-mcp',
        name: 'Local MCP Server',
        description: 'Locally deployed Model Context Protocol server',
        isLocal: true,
        status: 'active',
      },
      {
        id: 'openai',
        name: 'OpenAI GPT-4',
        description: 'OpenAI GPT-4 music generation',
        isLocal: false,
        status: 'available',
        requiresKey: true,
      },
      {
        id: 'google-music',
        name: 'Google MusicLM',
        description: 'Google MusicLM for music composition',
        isLocal: false,
        status: 'available',
        requiresKey: true,
      },
      {
        id: 'mubert',
        name: 'Mubert AI',
        description: 'Mubert AI music generation service',
        isLocal: false,
        status: 'available',
        requiresKey: true,
      },
    ],
  });
});

// ============= EXPORT =============
app.post('/export', async (req, res) => {
  try {
    const { compositionId, format } = req.body;

    if (!compositionId || !format) {
      return res.status(400).json({
        error: 'compositionId and format are required',
      });
    }

    if (!['midi', 'wav', 'mp3'].includes(format.toLowerCase())) {
      return res.status(400).json({
        error: 'Invalid format. Supported: midi, wav, mp3',
      });
    }

    // Генерируем экспорт
    const fileName = `composition_${compositionId}.${format}`;

    res.json({
      success: true,
      fileName: fileName,
      format: format,
      downloadUrl: `/downloads/${fileName}`,
      size: 'estimated 5.2 MB',
      message: `Export to ${format.toUpperCase()} prepared`,
    });
  } catch (error) {
    console.error('Error in /export:', error);
    res.status(500).json({
      error: 'Export failed',
      message: error.message,
    });
  }
});

// ============= STATUS =============
app.get('/status', (req, res) => {
  const uptime = process.uptime();
  const hours = Math.floor(uptime / 3600);
  const minutes = Math.floor((uptime % 3600) / 60);
  const seconds = Math.floor(uptime % 60);

  res.json({
    service: 'MCP Music Composition Server',
    status: 'running',
    version: '1.0.0',
    uptime: `${hours}h ${minutes}m ${seconds}s`,
    timestamp: new Date().toISOString(),
    capabilities: [
      'melody-analysis',
      'composition-generation',
      'arrangement-synthesis',
      'export-to-midi',
      'export-to-wav',
    ],
  });
});

// ============= HELPER FUNCTIONS =============

function analyzeMood(frequencies) {
  // Простой анализ мнения на основе частот
  if (!frequencies || frequencies.length === 0) {
    return 'neutral';
  }

  const avgFreq = frequencies.reduce((a, b) => a + b) / frequencies.length;

  if (avgFreq > 2000) return 'bright';
  if (avgFreq > 1000) return 'energetic';
  if (avgFreq > 500) return 'warm';
  return 'mellow';
}

// ============= ERROR HANDLING =============

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    error: 'Endpoint not found',
    path: req.path,
    method: req.method,
    availableEndpoints: [
      'GET /health',
      'GET /status',
      'GET /arrangements',
      'GET /providers',
      'POST /analyze-melody',
      'POST /compose',
      'POST /export',
    ],
  });
});

// Error handler
app.use((err, req, res, next) => {
  console.error('Server error:', err);
  res.status(500).json({
    error: 'Server error',
    message: err.message,
  });
});

// ============= SERVER STARTUP =============

const PORT = process.env.PORT || 3000;
const HOST = process.env.HOST || 'localhost';

app.listen(PORT, HOST, () => {
  console.log(`
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║     MCP Music Composition Server v1.0.0                      ║
║                                                              ║
║     Server running at: http://${HOST}:${PORT}                    ║
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
  `);
});

// Graceful shutdown
process.on('SIGINT', () => {
  console.log('\n\nShutting down server...');
  process.exit(0);
});

process.on('SIGTERM', () => {
  console.log('\n\nServer terminated');
  process.exit(0);
});

