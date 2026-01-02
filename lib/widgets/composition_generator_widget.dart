import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/composition_generator.dart';
import '../models/composition_model.dart';

class CompositionGeneratorWidget extends StatefulWidget {
  const CompositionGeneratorWidget({super.key});

  @override
  State<CompositionGeneratorWidget> createState() =>
      _CompositionGeneratorWidgetState();
}

class _CompositionGeneratorWidgetState extends State<CompositionGeneratorWidget> {
  late TextEditingController _titleController;
  late TextEditingController _apiKeyController;
  String _selectedArrangement = 'blend';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: 'New Composition');
    _apiKeyController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
      ),
      child: Consumer<CompositionGeneratorProvider>(
        builder: (context, generator, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Text(
                  'AI Composition Generator',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // AI Provider Selection
                Text(
                  'Select AI Provider',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1a1a1a),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.deepPurple.withOpacity(0.3),
                    ),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox(),
                    dropdownColor: const Color(0xFF2a2a2a),
                    value: generator.selectedProvider?.id ?? 'none',
                    items: [
                      const DropdownMenuItem(
                        value: 'none',
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Choose a provider...',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      ...generator.availableProviders.map((provider) {
                        return DropdownMenuItem(
                          value: provider.id,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Icon(
                                  provider.isLocal ? Icons.router : Icons.cloud,
                                  color: Colors.deepPurple,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        provider.description,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                    onChanged: (value) {
                      if (value != null && value != 'none') {
                        generator.selectProvider(value);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // API Configuration
                if (generator.selectedProvider != null) ...[
                  Text(
                    'API Configuration',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (!generator.selectedProvider!.isLocal) ...[
                    TextField(
                      controller: _apiKeyController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter API Key',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        filled: true,
                        fillColor: const Color(0xFF1a1a1a),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.deepPurple.withOpacity(0.3),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.deepPurple.withOpacity(0.3),
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: generator.selectedProvider!.isLocal
                              ? () => generator.testConnection()
                              : () {
                                  if (_apiKeyController.text.isNotEmpty) {
                                    generator
                                        .configureApiKey(_apiKeyController.text);
                                  }
                                },
                          icon: Icon(generator.selectedProvider!.isConfigured
                              ? Icons.check_circle
                              : Icons.settings),
                          label: Text(generator.selectedProvider!.isConfigured
                              ? 'Configured'
                              : 'Configure'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () => generator.testConnection(),
                        icon: const Icon(Icons.router),
                        label: const Text('Test'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],

                // Composition Settings
                Text(
                  'Composition Settings',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Composition Title',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    filled: true,
                    fillColor: const Color(0xFF1a1a1a),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.deepPurple.withOpacity(0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.deepPurple.withOpacity(0.3),
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Arrangement Style',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _ArrangementButton(
                      label: 'Blend',
                      value: 'blend',
                      isSelected: _selectedArrangement == 'blend',
                      onPressed: () =>
                          setState(() => _selectedArrangement = 'blend'),
                    ),
                    const SizedBox(width: 8),
                    _ArrangementButton(
                      label: 'Layer',
                      value: 'layer',
                      isSelected: _selectedArrangement == 'layer',
                      onPressed: () =>
                          setState(() => _selectedArrangement = 'layer'),
                    ),
                    const SizedBox(width: 8),
                    _ArrangementButton(
                      label: 'Interleave',
                      value: 'interleave',
                      isSelected: _selectedArrangement == 'interleave',
                      onPressed: () =>
                          setState(() => _selectedArrangement = 'interleave'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Status
                if (generator.status.isNotEmpty)
                  Container(
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
                            Expanded(
                              child: Text(
                                generator.status,
                                style: const TextStyle(
                                  color: Colors.amber,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (generator.generationProgress > 0 &&
                                generator.generationProgress < 1)
                              SizedBox(
                                width: 40,
                                height: 20,
                                child: LinearProgressIndicator(
                                  value: generator.generationProgress,
                                  backgroundColor: Colors.grey[700],
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.deepPurple,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (generator.errorMessage.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Error: ${generator.errorMessage}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                const SizedBox(height: 16),

                // Generate Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: generator.isGenerating ||
                            generator.selectedProvider == null ||
                            !generator.selectedProvider!.isConfigured
                        ? null
                        : () {
                            // Demo: create 4 mock melodies
                            final melodies = [
                              MelodyInfo(
                                id: 'melody_1',
                                name: 'Lead',
                                filePath: 'lead.wav',
                                tempo: 120,
                                key: 'C',
                                duration: 30,
                                bars: 16,
                                mood: 'energetic',
                              ),
                              MelodyInfo(
                                id: 'melody_2',
                                name: 'Bass',
                                filePath: 'bass.wav',
                                tempo: 120,
                                key: 'C',
                                duration: 30,
                                bars: 16,
                                mood: 'deep',
                              ),
                              MelodyInfo(
                                id: 'melody_3',
                                name: 'Pad',
                                filePath: 'pad.wav',
                                tempo: 120,
                                key: 'C',
                                duration: 30,
                                bars: 16,
                                mood: 'atmospheric',
                              ),
                              MelodyInfo(
                                id: 'melody_4',
                                name: 'Drums',
                                filePath: 'drums.wav',
                                tempo: 120,
                                key: 'C',
                                duration: 30,
                                bars: 16,
                                mood: 'rhythmic',
                              ),
                            ];

                            generator.generateComposition(
                              melodies,
                              _titleController.text,
                              _selectedArrangement,
                            );
                          },
                    icon: generator.isGenerating
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Icon(Icons.music_note),
                    label: Text(generator.isGenerating
                        ? 'Generating...'
                        : 'Generate Composition'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),

                // Generated Composition Result
                if (generator.lastGeneration != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1a1a1a),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.green.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Composition Generated: ${generator.lastGeneration!.title}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Duration: ${generator.lastGeneration!.totalDuration.toStringAsFixed(1)}s\n'
                          'Provider: ${generator.lastGeneration!.aiProvider}\n'
                          'Confidence: ${(generator.lastGeneration!.confidenceScore * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => generator.exportComposition(
                                  generator.lastGeneration!,
                                  'midi',
                                ),
                                icon: const Icon(Icons.download),
                                label: const Text('Export MIDI'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  foregroundColor: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => generator.exportComposition(
                                  generator.lastGeneration!,
                                  'wav',
                                ),
                                icon: const Icon(Icons.download),
                                label: const Text('Export WAV'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyan,
                                  foregroundColor: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ArrangementButton extends StatelessWidget {
  final String label;
  final String value;
  final bool isSelected;
  final VoidCallback onPressed;

  const _ArrangementButton({
    required this.label,
    required this.value,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Colors.deepPurple : Colors.transparent,
          side: BorderSide(
            color: isSelected ? Colors.deepPurple : Colors.grey.withOpacity(0.3),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

