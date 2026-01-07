import 'package:equatable/equatable.dart';

/// EQ Preset Entity - предустановка эквалайзера
class EQPresetEntity extends Equatable {
  final String name;
  final List<double> bands; // 10 значений от -12 до +12 dB
  final String description;
  final bool isCustom;
  final DateTime? createdAt;

  const EQPresetEntity({
    required this.name,
    required this.bands,
    required this.description,
    this.isCustom = false,
    this.createdAt,
  }) : assert(bands.length == 10, 'EQ preset must have exactly 10 bands');

  /// Проверяет, все ли значения нулевые (Flat)
  bool get isFlat => bands.every((value) => value == 0.0);

  /// Получает максимальное значение усиления
  double get maxGain => bands.reduce((a, b) => a > b ? a : b);

  /// Получает минимальное значение ослабления
  double get minGain => bands.reduce((a, b) => a < b ? a : b);

  EQPresetEntity copyWith({
    String? name,
    List<double>? bands,
    String? description,
    bool? isCustom,
    DateTime? createdAt,
  }) {
    return EQPresetEntity(
      name: name ?? this.name,
      bands: bands ?? this.bands,
      description: description ?? this.description,
      isCustom: isCustom ?? this.isCustom,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [name, bands, description, isCustom, createdAt];
}

