import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/mixer_viewmodel.dart';
import '../../widgets/deck_widget.dart';
import '../../widgets/mixer_controls_widget.dart';
import '../../widgets/equalizer_widget.dart';
import '../../widgets/eq_preset_carousel_widget.dart';
import '../../widgets/frequency_response_widget.dart';
import '../../widgets/track_loader_widget.dart';
import '../../widgets/audio_device_analysis_widget.dart';
import '../../widgets/composition_generator_widget.dart';

class MixerScreen extends StatefulWidget {
  const MixerScreen({super.key});

  @override
  State<MixerScreen> createState() => _MixerScreenState();
}

class _MixerScreenState extends State<MixerScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 1200;
    final isMediumScreen = screenWidth > 800;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fly Mixxx - DJ Mixer'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.withOpacity(0.8),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'DJ Features',
        child: const Icon(Icons.music_note),
      ),
      body: Consumer<MixerViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.isError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${viewModel.errorMessage}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.setIdle(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (isLargeScreen) {
            return _buildLargeScreenLayout(viewModel);
          } else if (isMediumScreen) {
            return _buildMediumScreenLayout(viewModel);
          } else {
            return _buildSmallScreenLayout(viewModel);
          }
        },
      ),
    );
  }

  Widget _buildLargeScreenLayout(MixerViewModel viewModel) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TrackLoaderWidget(),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: DeckWidget(
                          deckNumber: 1,
                          isPlaying: viewModel.isPlaying1,
                          duration: viewModel.duration1,
                          position: viewModel.position1,
                          onPlayPause: () => viewModel.playPauseDeck1(),
                          onStop: () => viewModel.stopDeck1(),
                          onSeek: (position) => viewModel.seekDeck1(position),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DeckWidget(
                          deckNumber: 2,
                          isPlaying: viewModel.isPlaying2,
                          duration: viewModel.duration2,
                          position: viewModel.position2,
                          onPlayPause: () => viewModel.playPauseDeck2(),
                          onStop: () => viewModel.stopDeck2(),
                          onSeek: (position) => viewModel.seekDeck2(position),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                const Expanded(
                  flex: 1,
                  child: MixerControlsWidget(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const EqualizerWidget(),
                      const SizedBox(height: 24),
                      const EQPresetCarouselWidget(),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                const Expanded(
                  child: FrequencyResponseWidget(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const AudioDeviceAnalysisWidget(),
            const SizedBox(height: 24),
            const CompositionGeneratorWidget(),
            const SizedBox(height: 24),
            _buildAboutSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildMediumScreenLayout(MixerViewModel viewModel) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TrackLoaderWidget(),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      DeckWidget(
                        deckNumber: 1,
                        isPlaying: viewModel.isPlaying1,
                        duration: viewModel.duration1,
                        position: viewModel.position1,
                        onPlayPause: () => viewModel.playPauseDeck1(),
                        onStop: () => viewModel.stopDeck1(),
                        onSeek: (position) => viewModel.seekDeck1(position),
                      ),
                      const SizedBox(height: 16),
                      DeckWidget(
                        deckNumber: 2,
                        isPlaying: viewModel.isPlaying2,
                        duration: viewModel.duration2,
                        position: viewModel.position2,
                        onPlayPause: () => viewModel.playPauseDeck2(),
                        onStop: () => viewModel.stopDeck2(),
                        onSeek: (position) => viewModel.seekDeck2(position),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                const Expanded(
                  child: MixerControlsWidget(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const EqualizerWidget(),
            const SizedBox(height: 24),
            const EQPresetCarouselWidget(),
            const SizedBox(height: 24),
            const FrequencyResponseWidget(),
            const SizedBox(height: 24),
            const AudioDeviceAnalysisWidget(),
            const SizedBox(height: 24),
            const CompositionGeneratorWidget(),
            const SizedBox(height: 24),
            _buildAboutSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallScreenLayout(MixerViewModel viewModel) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TrackLoaderWidget(),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: DeckWidget(
                    deckNumber: 1,
                    isPlaying: viewModel.isPlaying1,
                    duration: viewModel.duration1,
                    position: viewModel.position1,
                    onPlayPause: () => viewModel.playPauseDeck1(),
                    onStop: () => viewModel.stopDeck1(),
                    onSeek: (position) => viewModel.seekDeck1(position),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DeckWidget(
                    deckNumber: 2,
                    isPlaying: viewModel.isPlaying2,
                    duration: viewModel.duration2,
                    position: viewModel.position2,
                    onPlayPause: () => viewModel.playPauseDeck2(),
                    onStop: () => viewModel.stopDeck2(),
                    onSeek: (position) => viewModel.seekDeck2(position),
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
            const SizedBox(height: 24),
            const AudioDeviceAnalysisWidget(),
            const SizedBox(height: 24),
            const CompositionGeneratorWidget(),
            const SizedBox(height: 24),
            _buildAboutSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
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
            'Professional DJ mixer with MVVM architecture',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}