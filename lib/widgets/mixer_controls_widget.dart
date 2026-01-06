import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import 'rotary_knob_widget.dart';

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
              // Main Controls Row (Crossfader, Master Volume, BPM, Tempo)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Crossfader
                    Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: Slider(
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
                        ),
                        const Text(
                          'Crossfader',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          audioProvider.crossfaderPosition < 0.5
                              ? 'D1 (${((1 - audioProvider.crossfaderPosition) * 100).toStringAsFixed(0)}%)'
                              : 'D2 (${(audioProvider.crossfaderPosition * 100).toStringAsFixed(0)}%)',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    // Master Volume Knob
                    RotaryKnobWidget(
                      value: audioProvider.masterVolume * 100,
                      min: 0,
                      max: 100,
                      onChanged: (value) {
                        audioProvider.setMasterVolume(value / 100);
                      },
                      label: 'Master\nVol',
                      unit: '%',
                      size: 75,
                      activeColor: Colors.deepPurple,
                      inactiveColor: Colors.grey,
                    ),
                    const SizedBox(width: 16),
                    // BPM Knob
                    RotaryKnobWidget(
                      value: audioProvider.bpm,
                      min: 60,
                      max: 240,
                      onChanged: (value) {
                        audioProvider.setBpm(value);
                      },
                      label: 'BPM',
                      unit: '',
                      size: 75,
                      activeColor: Colors.deepPurple,
                      inactiveColor: Colors.grey,
                    ),
                    const SizedBox(width: 16),
                    // Tempo Knob
                    RotaryKnobWidget(
                      value: audioProvider.tempoMultiplier * 100,
                      min: 50,
                      max: 200,
                      onChanged: (value) {
                        audioProvider.setTempoMultiplier(value / 100);
                      },
                      label: 'Tempo',
                      unit: '%',
                      size: 75,
                      activeColor: Colors.deepPurple,
                      inactiveColor: Colors.grey,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Deck Volume Controls (Horizontal knobs)
              const Text(
                'Deck Volumes',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RotaryKnobWidget(
                    value: audioProvider.volume1 * 100,
                    min: 0,
                    max: 100,
                    onChanged: (value) {
                      audioProvider.setVolume1(value / 100);
                    },
                    label: 'Deck 1\nVol',
                    unit: '%',
                    size: 75,
                    activeColor: Colors.deepPurple,
                    inactiveColor: Colors.grey,
                  ),
                  RotaryKnobWidget(
                    value: audioProvider.volume2 * 100,
                    min: 0,
                    max: 100,
                    onChanged: (value) {
                      audioProvider.setVolume2(value / 100);
                    },
                    label: 'Deck 2\nVol',
                    unit: '%',
                    size: 75,
                    activeColor: Colors.deepPurple,
                    inactiveColor: Colors.grey,
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
