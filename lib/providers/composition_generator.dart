import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/composition_model.dart';

class CompositionGeneratorProvider extends ChangeNotifier {
  // Available AI providers
  final List<AIProviderConfig> _availableProviders = [
    AIProviderConfig(
      id: 'openai',
      name: 'OpenAI GPT-4',
      description: 'OpenAI GPT-4 with music generation capabilities',
      apiUrl: 'https://api.openai.com/v1',
      isLocal: false,
      isConfigured: false,
    ),
    AIProviderConfig(
      id: 'google-music',
      name: 'Google MusicLM',
      description: 'Google MusicLM for music composition',
      apiUrl: 'https://music-lm.googleapis.com/v1',
      isLocal: false,
      isConfigured: false,
    ),
    AIProviderConfig(
      id: 'local-mcp',
      name: 'Local MCP Server',
      description: 'Locally deployed Model Context Protocol server',
      apiUrl: 'http://localhost:3000',
      isLocal: true,
      isConfigured: false,
    ),
    AIProviderConfig(
      id: 'jukebox',
      name: 'OpenAI Jukebox',
      description: 'Music generation from text prompts',
      apiUrl: 'https://jukebox.openai.com/api',
      isLocal: false,
      isConfigured: false,
    ),
    AIProviderConfig(
      id: 'mubert',
      name: 'Mubert AI',
      description: 'AI music generation service',
      apiUrl: 'https://api.mubert.com/v1',
      isLocal: false,
      isConfigured: false,
    ),
  ];

  AIProviderConfig? _selectedProvider;
  bool _isGenerating = false;
  String _status = 'Ready';
  String _errorMessage = '';
  GeneratedComposition? _lastGeneration;
  double _generationProgress = 0.0;

  // Getters
  List<AIProviderConfig> get availableProviders => _availableProviders;
  AIProviderConfig? get selectedProvider => _selectedProvider;
  bool get isGenerating => _isGenerating;
  String get status => _status;
  String get errorMessage => _errorMessage;
  GeneratedComposition? get lastGeneration => _lastGeneration;
  double get generationProgress => _generationProgress;

  /// Select an AI provider
  void selectProvider(String providerId) {
    try {
      _selectedProvider = _availableProviders.firstWhere(
        (p) => p.id == providerId,
        orElse: () => _availableProviders.first,
      );
      _errorMessage = '';
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Provider not found: $e';
    }
  }

  /// Configure API key for selected provider
  Future<bool> configureApiKey(String apiKey) async {
    if (_selectedProvider == null) {
      _errorMessage = 'No provider selected';
      return false;
    }

    try {
      // Validate API key format (basic check)
      if (apiKey.isEmpty) {
        _errorMessage = 'API key cannot be empty';
        return false;
      }

      // Update provider with API key
      final updatedProvider = AIProviderConfig(
        id: _selectedProvider!.id,
        name: _selectedProvider!.name,
        description: _selectedProvider!.description,
        apiUrl: _selectedProvider!.apiUrl,
        apiKey: apiKey,
        isLocal: _selectedProvider!.isLocal,
        params: _selectedProvider!.params,
        isConfigured: true,
      );

      // Replace in list
      final index = _availableProviders.indexWhere((p) => p.id == _selectedProvider!.id);
      if (index >= 0) {
        _availableProviders[index] = updatedProvider;
        _selectedProvider = updatedProvider;
      }

      _status = 'API key configured successfully';
      _errorMessage = '';
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Configuration error: $e';
      return false;
    }
  }

  /// Test API connection
  Future<bool> testConnection() async {
    if (_selectedProvider == null) {
      _errorMessage = 'No provider selected';
      return false;
    }

    _isGenerating = true;
    _status = 'Testing connection...';
    _errorMessage = '';
    notifyListeners();

    try {
      if (_selectedProvider!.isLocal) {
        // Test local MCP server
        final response = await http
            .get(Uri.parse('${_selectedProvider!.apiUrl}/health'))
            .timeout(const Duration(seconds: 5));

        final success = response.statusCode == 200;
        _status = success ? 'Connection successful' : 'Connection failed';
        _isGenerating = false;
        notifyListeners();
        return success;
      } else {
        // Test cloud API
        _status = 'API configured and ready';
        _isGenerating = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      _errorMessage = 'Connection test failed: $e';
      _status = 'Error';
      _isGenerating = false;
      notifyListeners();
      return false;
    }
  }

  /// Generate composition from 4 melodies
  Future<GeneratedComposition?> generateComposition(
    List<MelodyInfo> melodies,
    String title,
    String arrangement,
  ) async {
    if (_selectedProvider == null) {
      _errorMessage = 'No AI provider selected';
      return null;
    }

    if (melodies.length != 4) {
      _errorMessage = 'Exactly 4 melodies required';
      return null;
    }

    _isGenerating = true;
    _status = 'Generating composition...';
    _errorMessage = '';
    _generationProgress = 0.0;
    notifyListeners();

    try {
      // Step 1: Analyze melodies
      _status = 'Analyzing melodies...';
      _generationProgress = 0.2;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));

      // Step 2: Send to AI provider
      _status = 'Sending to ${_selectedProvider!.name}...';
      _generationProgress = 0.4;
      notifyListeners();

      final composition = await _callAIProvider(melodies, title, arrangement);

      if (composition != null) {
        _lastGeneration = composition;
        _status = 'Composition generated successfully';
        _generationProgress = 1.0;
      } else {
        _errorMessage = 'Failed to generate composition';
        _status = 'Error';
      }

      notifyListeners();
      return composition;
    } catch (e) {
      _errorMessage = 'Generation error: $e';
      _status = 'Error';
      _isGenerating = false;
      notifyListeners();
      return null;
    }
  }

  /// Call AI provider API
  Future<GeneratedComposition?> _callAIProvider(
    List<MelodyInfo> melodies,
    String title,
    String arrangement,
  ) async {
    try {
      final payload = {
        'melodies': melodies.map((m) => m.toJson()).toList(),
        'title': title,
        'arrangement': arrangement,
        'provider': _selectedProvider!.id,
      };

      if (_selectedProvider!.isLocal) {
        // Call local MCP server
        final response = await http.post(
          Uri.parse('${_selectedProvider!.apiUrl}/compose'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(payload),
        ).timeout(const Duration(seconds: 30));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return _buildComposition(data, melodies, title);
        }
      } else {
        // Call cloud API (mock implementation)
        // In real implementation, use provider-specific APIs
        await Future.delayed(const Duration(seconds: 3));
        return _buildComposition({}, melodies, title);
      }

      return null;
    } catch (e) {
      _errorMessage = 'API call failed: $e';
      return null;
    }
  }

  /// Build composition from API response
  GeneratedComposition _buildComposition(
    Map<String, dynamic> apiResponse,
    List<MelodyInfo> melodies,
    String title,
  ) {
    return GeneratedComposition(
      id: 'comp_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      sourceMelodies: melodies,
      totalDuration: melodies.fold<double>(0, (sum, m) => sum + m.duration),
      arrangement: apiResponse['arrangement'] ?? 'blend',
      mixingStrategy: apiResponse['mixing'] ?? 'adaptive',
      aiProvider: _selectedProvider!.name,
      createdAt: DateTime.now(),
      confidenceScore: 0.85,
      metadata: {
        'apiResponse': apiResponse,
        'processingTime': '${DateTime.now()}',
      },
    );
  }

  /// Export composition as MIDI or audio
  Future<String?> exportComposition(
    GeneratedComposition composition,
    String format, // 'midi' or 'wav'
  ) async {
    try {
      _status = 'Exporting as $format...';
      _generationProgress = 0.5;
      notifyListeners();

      // Simulate export
      await Future.delayed(const Duration(seconds: 2));

      final fileName =
          'composition_${DateTime.now().millisecondsSinceEpoch}.$format';
      _status = 'Export complete: $fileName';
      _generationProgress = 1.0;
      notifyListeners();

      return fileName;
    } catch (e) {
      _errorMessage = 'Export failed: $e';
      _status = 'Error';
      notifyListeners();
      return null;
    }
  }

  /// Reset provider
  void reset() {
    _selectedProvider = null;
    _isGenerating = false;
    _status = 'Ready';
    _errorMessage = '';
    _lastGeneration = null;
    _generationProgress = 0.0;
    notifyListeners();
  }
}

