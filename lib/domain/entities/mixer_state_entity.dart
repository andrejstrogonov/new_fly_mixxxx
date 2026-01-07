import 'package:equatable/equatable.dart';

/// Mixer State Entity - состояние миксера
class MixerStateEntity extends Equatable {
  final double volume1; // Дек 1 громкость (0-100)
  final double volume2; // Дек 2 громкость (0-100)
  final double crossfader; // Кроссфейдер (0-100, 50 = middle)
  final double masterVolume; // Мастер громкость (0-100)
  final List<double> eqBands; // 10-полосный EQ
  final bool isBassBoost; // Усилитель басса
  final DateTime lastModified;

  const MixerStateEntity({
    required this.volume1,
    required this.volume2,
    required this.crossfader,
    required this.masterVolume,
    required this.eqBands,
    this.isBassBoost = false,
    required this.lastModified,
  });

  /// Получает текущий вывод (левый = Дек1, правый = Дек2)
  double get deck1Output {
    // Crossfader: 0 = только дек 1, 50 = оба, 100 = только дек 2
    final ratio = (100 - crossfader) / 100;
    return (volume1 / 100) * ratio;
  }

  double get deck2Output {
    final ratio = crossfader / 100;
    return (volume2 / 100) * ratio;
  }

  /// Получает общий выходной сигнал с учетом мастер громкости
  double get masterOutput => (deck1Output + deck2Output) / 2 * (masterVolume / 100);

  MixerStateEntity copyWith({
    double? volume1,
    double? volume2,
    double? crossfader,
    double? masterVolume,
    List<double>? eqBands,
    bool? isBassBoost,
    DateTime? lastModified,
  }) {
    return MixerStateEntity(
      volume1: volume1 ?? this.volume1,
      volume2: volume2 ?? this.volume2,
      crossfader: crossfader ?? this.crossfader,
      masterVolume: masterVolume ?? this.masterVolume,
      eqBands: eqBands ?? this.eqBands,
      isBassBoost: isBassBoost ?? this.isBassBoost,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  @override
  List<Object?> get props => [
    volume1,
    volume2,
    crossfader,
    masterVolume,
    eqBands,
    isBassBoost,
    lastModified,
  ];
}

