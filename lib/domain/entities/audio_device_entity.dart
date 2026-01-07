import 'package:equatable/equatable.dart';

/// Audio Device Entity - информация об аудиоустройстве
class AudioDeviceEntity extends Equatable {
  final String id;
  final String name;
  final String type; // input, output, etc.
  final bool isActive;
  final int channels;
  final int sampleRate; // Hz
  final bool isBuiltIn;

  const AudioDeviceEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.isActive,
    required this.channels,
    required this.sampleRate,
    required this.isBuiltIn,
  });

  /// Получает информацию об устройстве в виде строки
  String get displayInfo {
    final status = isActive ? 'Active' : 'Inactive';
    return '$name ($channels ch, $sampleRate Hz) - $status';
  }

  AudioDeviceEntity copyWith({
    String? id,
    String? name,
    String? type,
    bool? isActive,
    int? channels,
    int? sampleRate,
    bool? isBuiltIn,
  }) {
    return AudioDeviceEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      channels: channels ?? this.channels,
      sampleRate: sampleRate ?? this.sampleRate,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    );
  }

  @override
  List<Object?> get props => [id, name, type, isActive, channels, sampleRate, isBuiltIn];
}

