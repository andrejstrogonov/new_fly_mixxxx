import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';

class PresetsWidget extends StatelessWidget {
  const PresetsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audioProvider, _) {
        List<String> presets = audioProvider.getAvailablePresets();

        return Container(
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
                'EQ Presets',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Current: ${audioProvider.currentPreset}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              // Preset buttons grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: presets.length,
                itemBuilder: (context, index) {
                  String presetName = presets[index];
                  bool isActive = audioProvider.currentPreset == presetName;
                  EQPreset? preset = audioProvider.getPreset(presetName);

                  return _buildPresetButton(
                    context,
                    presetName,
                    preset?.description ?? '',
                    isActive,
                    () => audioProvider.applyPreset(presetName),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPresetButton(
    BuildContext context,
    String name,
    String description,
    bool isActive,
    VoidCallback onPressed,
  ) {
    return Tooltip(
      message: description,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive
              ? Colors.deepPurple
              : Colors.deepPurple.withValues(alpha: 0.3),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isActive ? Colors.deepPurple : Colors.transparent,
              width: 2,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            if (isActive)
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(Icons.check, size: 12),
              ),
          ],
        ),
      ),
    );
  }
}
