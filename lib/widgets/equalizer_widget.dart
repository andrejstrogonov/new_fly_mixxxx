import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';

class EqualizerWidget extends StatelessWidget {
  const EqualizerWidget({super.key});

  static const List<String> bandLabels = [
    '60Hz',
    '150Hz',
    '400Hz',
    '1kHz',
    '2.4kHz',
    '6kHz',
    '15kHz',
    '20kHz',
    '30kHz',
    '40kHz'
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audioProvider, _) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2a2a2a),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '10-Band Equalizer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => audioProvider.resetEqualizer(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    10,
                    (index) => _buildEqBand(
                      context,
                      index,
                      audioProvider,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEqBand(
    BuildContext context,
    int index,
    AudioProvider audioProvider,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: RotatedBox(
              quarterTurns: 3,
              child: Slider(
                value: audioProvider.eqBands[index],
                min: -12,
                max: 12,
                divisions: 24,
                onChanged: (value) {
                  audioProvider.setEqBand(index, value);
                },
                activeColor: Colors.deepPurple,
                inactiveColor: Colors.grey.withOpacity(0.3),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            bandLabels[index],
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
          Text(
            '${audioProvider.eqBands[index].toStringAsFixed(1)}dB',
            style: const TextStyle(
              fontSize: 9,
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
