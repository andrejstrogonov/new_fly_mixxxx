import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../providers/audio_provider.dart';
import 'dart:io';

class TrackLoaderWidget extends StatefulWidget {
  const TrackLoaderWidget({super.key});

  @override
  State<TrackLoaderWidget> createState() => _TrackLoaderWidgetState();
}

class _TrackLoaderWidgetState extends State<TrackLoaderWidget> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Track Loader',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              // Current Playing Tracks Section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1a1a1a),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.deepPurple.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Now Playing',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildNowPlayingCard(
                            context,
                            deckNumber: 1,
                            audioProvider: audioProvider,
                            queue: audioProvider.queue1,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildNowPlayingCard(
                            context,
                            deckNumber: 2,
                            audioProvider: audioProvider,
                            queue: audioProvider.queue2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Decks section with queues
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildDeckLoader(
                      context,
                      audioProvider,
                      deckNumber: 1,
                      queue: audioProvider.queue1,
                      onAddTrack: () => _selectAndAddTrack(context, audioProvider, 1),
                      onRemoveTrack: (index) => audioProvider.removeTrackFromQueue1(index),
                      onPlayTrack: (index) => audioProvider.playTrackFromQueue1(index),
                      onClearQueue: () => audioProvider.clearQueue1(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDeckLoader(
                      context,
                      audioProvider,
                      deckNumber: 2,
                      queue: audioProvider.queue2,
                      onAddTrack: () => _selectAndAddTrack(context, audioProvider, 2),
                      onRemoveTrack: (index) => audioProvider.removeTrackFromQueue2(index),
                      onPlayTrack: (index) => audioProvider.playTrackFromQueue2(index),
                      onClearQueue: () => audioProvider.clearQueue2(),
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

  Widget _buildNowPlayingCard(
    BuildContext context, {
    required int deckNumber,
    required AudioProvider audioProvider,
    required List<Track> queue,
  }) {
    final currentIndex = deckNumber == 1
        ? audioProvider.currentTrackIndex1
        : audioProvider.currentTrackIndex2;

    final currentTrack = currentIndex >= 0 && currentIndex < queue.length
        ? queue[currentIndex]
        : null;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deck $deckNumber',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 6),
          if (currentTrack != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentTrack.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (currentTrack.duration != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    _formatDuration(currentTrack.duration!),
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 10,
                    ),
                  ),
                ],
              ],
            )
          else
            const Text(
              'No track loaded',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDeckLoader(
    BuildContext context,
    AudioProvider audioProvider, {
    required int deckNumber,
    required List<Track> queue,
    required VoidCallback onAddTrack,
    required Function(int) onRemoveTrack,
    required Function(int) onPlayTrack,
    required VoidCallback onClearQueue,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Deck $deckNumber Queue (${queue.length}/${AudioProvider.maxQueueSize})',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              if (queue.isNotEmpty)
                SizedBox(
                  width: 24,
                  height: 24,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.clear_all, size: 16),
                    onPressed: onClearQueue,
                    tooltip: 'Clear queue',
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          // Queue list
          if (queue.isEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: const Text(
                'No tracks in queue',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
            )
          else
            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: queue.length,
                itemBuilder: (context, index) {
                  final track = queue[index];
                  final isCurrentTrack = deckNumber == 1
                      ? audioProvider.currentTrackIndex1 == index
                      : audioProvider.currentTrackIndex2 == index;

                  return _buildQueueItem(
                    track,
                    index,
                    isCurrentTrack,
                    onPlay: () => onPlayTrack(index),
                    onRemove: () => onRemoveTrack(index),
                  );
                },
              ),
            ),
          const SizedBox(height: 8),
          // Add track button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: queue.length < AudioProvider.maxQueueSize
                  ? onAddTrack
                  : null,
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Add Track'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.withOpacity(0.3),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Add folder button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _selectAndAddFolder(context, audioProvider, deckNumber),
              icon: const Icon(Icons.folder_open),
              label: const Text('Add Folder'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.deepPurple,
                side: const BorderSide(color: Colors.deepPurple),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQueueItem(
    Track track,
    int index,
    bool isCurrentTrack, {
    required VoidCallback onPlay,
    required VoidCallback onRemove,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isCurrentTrack
            ? Colors.deepPurple.withOpacity(0.3)
            : Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: isCurrentTrack
            ? Border.all(color: Colors.deepPurple, width: 1)
            : null,
      ),
      child: Row(
        children: [
          Text(
            '${index + 1}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isCurrentTrack ? Colors.deepPurple : Colors.white,
                    fontSize: 11,
                    fontWeight: isCurrentTrack ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (track.duration != null)
                  Text(
                    _formatDuration(track.duration!),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 9,
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            padding: const EdgeInsets.all(4),
            iconSize: 16,
            icon: const Icon(Icons.play_arrow),
            color: Colors.deepPurple,
            onPressed: onPlay,
          ),
          IconButton(
            padding: const EdgeInsets.all(4),
            iconSize: 16,
            icon: const Icon(Icons.close),
            color: Colors.red,
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }

  Future<void> _selectAndAddTrack(
    BuildContext context,
    AudioProvider audioProvider,
    int deckNumber,
  ) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        final track = Track(
          id: file.name,
          name: file.name,
          path: file.path!,
        );

        if (deckNumber == 1) {
          final added = audioProvider.addTrackToQueue1(track);
          if (!added && mounted) {
            _showSnackBar('Queue is full (max 4 tracks)');
          }
        } else {
          final added = audioProvider.addTrackToQueue2(track);
          if (!added && mounted) {
            _showSnackBar('Queue is full (max 4 tracks)');
          }
        }
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error selecting track: $e');
      }
    }
  }

  Future<void> _selectAndAddFolder(
    BuildContext context,
    AudioProvider audioProvider,
    int deckNumber,
  ) async {
    try {
      final folderPath = await FilePicker.platform.getDirectoryPath();

      if (folderPath != null) {
        final directory = Directory(folderPath);
        final entities = directory.listSync();

        final audioFiles = entities
            .whereType<File>()
            .where((file) {
              final ext = file.path.toLowerCase();
              return ext.endsWith('.mp3') ||
                  ext.endsWith('.wav') ||
                  ext.endsWith('.flac') ||
                  ext.endsWith('.m4a') ||
                  ext.endsWith('.aac');
            })
            .toList();

        if (audioFiles.isEmpty) {
          if (mounted) {
            _showSnackBar('No audio files found in this folder');
          }
          return;
        }

        int addedCount = 0;
        for (final file in audioFiles) {
          if ((deckNumber == 1 && audioProvider.queue1.length >= AudioProvider.maxQueueSize) ||
              (deckNumber == 2 && audioProvider.queue2.length >= AudioProvider.maxQueueSize)) {
            break;
          }

          final track = Track(
            id: file.path,
            name: file.path.split(Platform.pathSeparator).last,
            path: file.path,
          );

          final added = deckNumber == 1
              ? audioProvider.addTrackToQueue1(track)
              : audioProvider.addTrackToQueue2(track);

          if (added) addedCount++;
        }

        if (mounted) {
          _showSnackBar('Added $addedCount tracks to Deck $deckNumber');
        }
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error loading folder: $e');
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }
}

