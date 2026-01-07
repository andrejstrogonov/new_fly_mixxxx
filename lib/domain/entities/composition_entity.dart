import 'package:equatable/equatable.dart';

/// Composition Entity - сгенерированная композиция
class CompositionEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<String> melody; // MIDI notes или другое представление
  final Duration duration;
  final String genre;
  final DateTime createdAt;
  final String? modelName; // Какая нейросеть использовалась

  const CompositionEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.melody,
    required this.duration,
    required this.genre,
    required this.createdAt,
    this.modelName,
  });

  /// Получает количество нот в мелодии
  int get noteCount => melody.length;

  /// Получает сложность композиции (по количеству нот)
  String get complexity {
    if (noteCount < 10) return 'Simple';
    if (noteCount < 30) return 'Moderate';
    return 'Complex';
  }

  CompositionEntity copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? melody,
    Duration? duration,
    String? genre,
    DateTime? createdAt,
    String? modelName,
  }) {
    return CompositionEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      melody: melody ?? this.melody,
      duration: duration ?? this.duration,
      genre: genre ?? this.genre,
      createdAt: createdAt ?? this.createdAt,
      modelName: modelName ?? this.modelName,
    );
  }

  @override
  List<Object?> get props => [id, title, description, melody, duration, genre, createdAt, modelName];
}

