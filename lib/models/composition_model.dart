/// Model for melody/track info
class MelodyInfo {
  final String id;
  final String name;
  final String filePath;
  final double tempo; // BPM
  final String key; // C, D, E, etc.
  final double duration; // seconds
  final int bars;
  final List<double> frequencies; // dominant frequencies
  final String mood; // happy, sad, energetic, calm, etc.

  MelodyInfo({
    required this.id,
    required this.name,
    required this.filePath,
    required this.tempo,
    required this.key,
    required this.duration,
    required this.bars,
    this.frequencies = const [],
    required this.mood,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'filePath': filePath,
      'tempo': tempo,
      'key': key,
      'duration': duration,
      'bars': bars,
      'frequencies': frequencies,
      'mood': mood,
    };
  }

  @override
  String toString() =>
      'MelodyInfo(name: $name, tempo: $tempo BPM, key: $key, mood: $mood)';
}

/// Model for generated composition
class GeneratedComposition {
  final String id;
  final String title;
  final List<MelodyInfo> sourceMelodies;
  final double totalDuration;
  final String arrangement;
  final String mixingStrategy;
  final String aiProvider;
  final DateTime createdAt;
  final double confidenceScore;
  final Map<String, dynamic> metadata;

  GeneratedComposition({
    required this.id,
    required this.title,
    required this.sourceMelodies,
    required this.totalDuration,
    required this.arrangement,
    required this.mixingStrategy,
    required this.aiProvider,
    required this.createdAt,
    required this.confidenceScore,
    this.metadata = const {},
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'sourceMelodies': sourceMelodies.map((m) => m.toJson()).toList(),
      'totalDuration': totalDuration,
      'arrangement': arrangement,
      'mixingStrategy': mixingStrategy,
      'aiProvider': aiProvider,
      'createdAt': createdAt.toIso8601String(),
      'confidenceScore': confidenceScore,
      'metadata': metadata,
    };
  }

  @override
  String toString() =>
      'GeneratedComposition(title: $title, duration: ${totalDuration}s, provider: $aiProvider)';
}

/// AI Provider configuration
class AIProviderConfig {
  final String id;
  final String name;
  final String description;
  final String apiUrl;
  final String? apiKey;
  final bool isLocal; // true for local MCP server
  final Map<String, dynamic> params;
  final bool isConfigured;

  AIProviderConfig({
    required this.id,
    required this.name,
    required this.description,
    required this.apiUrl,
    this.apiKey,
    required this.isLocal,
    this.params = const {},
    required this.isConfigured,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'apiUrl': apiUrl,
      'isLocal': isLocal,
      'params': params,
      'isConfigured': isConfigured,
    };
  }

  factory AIProviderConfig.fromJson(Map<String, dynamic> json) {
    return AIProviderConfig(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      apiUrl: json['apiUrl'] as String,
      apiKey: json['apiKey'] as String?,
      isLocal: json['isLocal'] as bool? ?? false,
      params: json['params'] as Map<String, dynamic>? ?? {},
      isConfigured: json['isConfigured'] as bool? ?? false,
    );
  }
}

