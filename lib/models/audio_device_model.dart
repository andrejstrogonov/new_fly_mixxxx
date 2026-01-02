/// Model for audio device analysis
class AudioDevice {
  final String id;
  final String name;
  final String type; // input, output, both
  final int channels;
  final int sampleRate;
  final int bitDepth;
  final bool isActive;
  final double latency; // in ms
  final String driver;
  final String status;

  AudioDevice({
    required this.id,
    required this.name,
    required this.type,
    required this.channels,
    required this.sampleRate,
    required this.bitDepth,
    required this.isActive,
    required this.latency,
    required this.driver,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'channels': channels,
      'sampleRate': sampleRate,
      'bitDepth': bitDepth,
      'isActive': isActive,
      'latency': latency,
      'driver': driver,
      'status': status,
    };
  }

  factory AudioDevice.fromJson(Map<String, dynamic> json) {
    return AudioDevice(
      id: json['id'] as String? ?? 'unknown',
      name: json['name'] as String? ?? 'Unknown Device',
      type: json['type'] as String? ?? 'unknown',
      channels: json['channels'] as int? ?? 2,
      sampleRate: json['sampleRate'] as int? ?? 48000,
      bitDepth: json['bitDepth'] as int? ?? 24,
      isActive: json['isActive'] as bool? ?? false,
      latency: (json['latency'] as num? ?? 0).toDouble(),
      driver: json['driver'] as String? ?? 'unknown',
      status: json['status'] as String? ?? 'unknown',
    );
  }

  @override
  String toString() {
    return 'AudioDevice(name: $name, type: $type, sampleRate: $sampleRate Hz, '
        'channels: $channels, latency: ${latency.toStringAsFixed(2)} ms)';
  }
}

/// Audio system information
class AudioSystemInfo {
  final List<AudioDevice> devices;
  final AudioDevice? defaultInput;
  final AudioDevice? defaultOutput;
  final String systemName;
  final double cpuLoad;
  final double memoryUsage;
  final int bufferSize;

  AudioSystemInfo({
    required this.devices,
    this.defaultInput,
    this.defaultOutput,
    required this.systemName,
    required this.cpuLoad,
    required this.memoryUsage,
    required this.bufferSize,
  });

  Map<String, dynamic> toJson() {
    return {
      'devices': devices.map((d) => d.toJson()).toList(),
      'defaultInput': defaultInput?.toJson(),
      'defaultOutput': defaultOutput?.toJson(),
      'systemName': systemName,
      'cpuLoad': cpuLoad,
      'memoryUsage': memoryUsage,
      'bufferSize': bufferSize,
    };
  }
}

