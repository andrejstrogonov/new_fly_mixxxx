import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import '../widgets/deck_widget.dart';
import '../widgets/mixer_controls_widget.dart';
import '../widgets/equalizer_widget.dart';
import '../widgets/eq_preset_carousel_widget.dart';
import '../widgets/frequency_response_widget.dart';

class MixerScreen extends StatelessWidget {
  const MixerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fly Mixxx - DJ Mixer'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.withOpacity(0.8),
        elevation: 0,
      ),
      body: Consumer<AudioProvider>(
        builder: (context, audioProvider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
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
                const MixerControlsWidget(),
                const SizedBox(height: 24),
                const EqualizerWidget(),
                const SizedBox(height: 24),
                const EQPresetCarouselWidget(),
                const SizedBox(height: 24),
                const FrequencyResponseWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}