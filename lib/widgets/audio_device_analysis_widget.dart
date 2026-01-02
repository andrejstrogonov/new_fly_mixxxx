import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_device_analyzer.dart';

class AudioDeviceAnalysisWidget extends StatelessWidget {
  const AudioDeviceAnalysisWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
      ),
      child: Consumer<AudioDeviceAnalyzer>(
        builder: (context, analyzer, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Audio Device Analysis',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: analyzer.isAnalyzing
                        ? null
                        : () => analyzer.analyzeAudioDevices(),
                    icon: analyzer.isAnalyzing
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.deepPurple,
                              ),
                            ),
                          )
                        : const Icon(Icons.refresh),
                    label: Text(analyzer.isAnalyzing ? 'Scanning...' : 'Scan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Status
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1a1a1a),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status: ${analyzer.status}',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (analyzer.errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Error: ${analyzer.errorMessage}',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 11,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // System Info
              if (analyzer.systemInfo != null) ...[
                Text(
                  'System Information',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _InfoCard(
                      label: 'CPU Load',
                      value:
                          '${analyzer.systemInfo!.cpuLoad.toStringAsFixed(1)}%',
                      color: Colors.orange,
                    ),
                    _InfoCard(
                      label: 'Memory',
                      value:
                          '${analyzer.systemInfo!.memoryUsage.toStringAsFixed(1)}%',
                      color: Colors.cyan,
                    ),
                    _InfoCard(
                      label: 'Buffer Size',
                      value: '${analyzer.systemInfo!.bufferSize} samples',
                      color: Colors.lightGreen,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],

              // Devices List
              Text(
                'Connected Devices (${analyzer.devices.length})',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 8),
              if (analyzer.devices.isEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: const Text(
                    'No devices detected. Click Scan to analyze.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                )
              else
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    itemCount: analyzer.devices.length,
                    itemBuilder: (context, index) {
                      final device = analyzer.devices[index];
                      return _AudioDeviceCard(device: device);
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _InfoCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF1a1a1a),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AudioDeviceCard extends StatelessWidget {
  final AudioDevice device;

  const _AudioDeviceCard({required this.device});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: device.isActive ? Colors.green.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          device.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: device.isActive ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            device.isActive ? 'Active' : 'Idle',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${device.type.toUpperCase()} • ${device.channels}ch • ${device.sampleRate} Hz',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                device.type.contains('input')
                    ? Icons.mic
                    : Icons.speaker_group,
                color: Colors.deepPurple,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _DeviceMetric(
                label: 'Latency',
                value: '${device.latency.toStringAsFixed(1)} ms',
              ),
              _DeviceMetric(
                label: 'Bit Depth',
                value: '${device.bitDepth}-bit',
              ),
              _DeviceMetric(
                label: 'Driver',
                value: device.driver,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeviceMetric extends StatelessWidget {
  final String label;
  final String value;

  const _DeviceMetric({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

