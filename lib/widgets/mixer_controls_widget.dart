import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';

class MixerControlsWidget extends StatelessWidget {
  const MixerControlsWidget({super.key});

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
              const Text(
                'Mixer Controls',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              // Crossfader
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Crossfader',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        audioProvider.crossfaderPosition < 0.5
                            ? 'Deck 1 (${((1 - audioProvider.crossfaderPosition) * 100).toStringAsFixed(0)}%)'
                            : 'Deck 2 (${(audioProvider.crossfaderPosition * 100).toStringAsFixed(0)}%)',
                        style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Slider(
                    value: audioProvider.crossfaderPosition,
                    min: 0,
                    max: 1,
                    divisions: 100,
                    onChanged: (value) {
                      audioProvider.setCrossfaderPosition(value);
                    },
                    activeColor: Colors.deepPurple,
                    inactiveColor: Colors.grey.withOpacity(0.3),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Master Volume
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Master Volume',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${(audioProvider.masterVolume * 100).toStringAsFixed(0)}%',
                        style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Slider(
                    value: audioProvider.masterVolume,
                    min: 0,
                    max: 1,
                    divisions: 100,
                    onChanged: (value) {
                      audioProvider.setMasterVolume(value);
                    },
                    activeColor: Colors.deepPurple,
                    inactiveColor: Colors.grey.withOpacity(0.3),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // BPM Control
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'BPM',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        audioProvider.bpm.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Slider(
                    value: audioProvider.bpm,
                    min: 60,
                    max: 240,
                    divisions: 180,
                    onChanged: (value) {
                      audioProvider.setBpm(value);
                    },
                    activeColor: Colors.deepPurple,
                    inactiveColor: Colors.grey.withOpacity(0.3),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Tempo/Speed Control
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tempo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${(audioProvider.tempoMultiplier * 100).toStringAsFixed(0)}%',
                        style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Slider(
                    value: audioProvider.tempoMultiplier,
                    min: 0.5,
                    max: 2.0,
                    divisions: 30,
                    onChanged: (value) {
                      audioProvider.setTempoMultiplier(value);
                    },
                    activeColor: Colors.deepPurple,
                    inactiveColor: Colors.grey.withOpacity(0.3),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Deck Volume Controls
              const Text(
                'Deck Volumes',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Deck 1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${(audioProvider.volume1 * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Slider(
                          value: audioProvider.volume1,
                          min: 0,
                          max: 1,
                          divisions: 100,
                          onChanged: (value) {
                            audioProvider.setVolume1(value);
                          },
                          activeColor: Colors.deepPurple,
                          inactiveColor: Colors.grey.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Deck 2',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${(audioProvider.volume2 * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Slider(
                          value: audioProvider.volume2,
                          min: 0,
                          max: 1,
                          divisions: 100,
                          onChanged: (value) {
                            audioProvider.setVolume2(value);
                          },
                          activeColor: Colors.deepPurple,
                          inactiveColor: Colors.grey.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
