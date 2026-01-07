import 'package:equatable/equatable.dart';

/// Frequency Response Entity - частотная характеристика
class FrequencyResponseEntity extends Equatable {
  final List<double> frequencies; // Hz
  final List<double> magnitude; // dB (амплитуда)
  final List<double> phase; // градусы (фаза)

  const FrequencyResponseEntity({
    required this.frequencies,
    required this.magnitude,
    required this.phase,
  }) : assert(
    frequencies.length == magnitude.length && magnitude.length == phase.length,
    'All lists must have the same length',
  );

  /// Получает минимальное значение амплитуды
  double get minMagnitude => magnitude.reduce((a, b) => a < b ? a : b);

  /// Получает максимальное значение амплитуды
  double get maxMagnitude => magnitude.reduce((a, b) => a > b ? a : b);

  /// Получает частоту с максимальной амплитудой
  double get peakFrequency {
    int maxIndex = 0;
    for (int i = 1; i < magnitude.length; i++) {
      if (magnitude[i] > magnitude[maxIndex]) {
        maxIndex = i;
      }
    }
    return frequencies[maxIndex];
  }

  FrequencyResponseEntity copyWith({
    List<double>? frequencies,
    List<double>? magnitude,
    List<double>? phase,
  }) {
    return FrequencyResponseEntity(
      frequencies: frequencies ?? this.frequencies,
      magnitude: magnitude ?? this.magnitude,
      phase: phase ?? this.phase,
    );
  }

  @override
  List<Object?> get props => [frequencies, magnitude, phase];
}

