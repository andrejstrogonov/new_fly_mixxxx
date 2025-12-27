import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import '../widgets/deck_widget.dart';
import '../widgets/mixer_controls_widget.dart';
import '../widgets/equalizer_widget.dart';
import '../widgets/presets_widget.dart';
import '../widgets/frequency_response_widget.dart';

class MixerScreen extends StatefulWidget {
  const MixerScreen({super.key});

  @override
  State<MixerScreen> createState() => _MixerScreenState();
}

class _MixerScreenState extends State<MixerScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize audio provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Any initialization if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fly Mixxx - DJ Mixer'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.withValues(alpha: 0.8),
        elevation: 0,
      ),
      body: Consumer<AudioProvider>(
        builder: (context, audioProvider, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Decks Section
                  Row(
                    children: [
                      Expanded(
                        child: DeckWidget(
                          deckNumber: 1,
                          isPlaying: audioProvider.isPlaying1,
                          duration: audioProvider.duration1,
                          position: audioProvider.position1,
                          onPlayPause: () => audioProvider.playPause1(),
                          onStop: () => audioProvider.stop1(),
                          onSeek: (position) => audioProvider.seek1(position),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DeckWidget(
                          deckNumber: 2,
                          isPlaying: audioProvider.isPlaying2,
                          duration: audioProvider.duration2,
                          position: audioProvider.position2,
                          onPlayPause: () => audioProvider.playPause2(),
                          onStop: () => audioProvider.stop2(),
                          onSeek: (position) => audioProvider.seek2(position),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Mixer Controls
                  const MixerControlsWidget(),
                  const SizedBox(height: 24),
                  // Equalizer
                  const EqualizerWidget(),
                  const SizedBox(height: 24),
                  // Presets
                  const PresetsWidget(),
                  const SizedBox(height: 24),
                  // Frequency Response
                  const FrequencyResponseWidget(),
                  const SizedBox(height: 24),
                  // Info Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2a2a2a),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About Fly Mixxx',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Fly Mixxx is a professional DJ mixer application designed for mixing tango instrumentals and other music genres. Features include:',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildFeatureItem('Dual Deck System', 'Mix between two audio tracks'),
                        _buildFeatureItem('10-Band Equalizer', 'Fine-tune audio frequencies'),
                        _buildFeatureItem('Crossfader', 'Smooth transitions between decks'),
                        _buildFeatureItem('BPM Control', 'Adjust tempo and speed'),
                        _buildFeatureItem('Master Volume', 'Control overall output level'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.deepPurple,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
