/// Пресеты эквалайзера для разных жанров
class EQPresetsConstants {
  static const Map<String, List<double>> presetsMap = {
    'Flat': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Bass Boost': [8, 6, 4, 2, 0, -2, -4, -3, -2, -1],
    'Treble Boost': [-1, -2, -3, -4, -2, 0, 2, 4, 6, 8],
    'Pop': [0, 1, 3, 2, 0, -1, -2, 0, 2, 4],
    'Rock': [4, 2, 1, 0, -1, -2, 0, 2, 4, 3],
    'Hip-Hop': [6, 4, 1, -1, 0, 2, 2, 1, 2, 3],
    'Electronic': [2, 3, 2, 0, -1, 1, 3, 4, 4, 3],
    'Jazz': [2, 1, 0, -1, 0, 1, 2, 3, 3, 2],
    'Classical': [1, 0, -1, -2, 0, 1, 2, 3, 2, 1],
    'Dance': [5, 4, 2, 0, -1, 0, 2, 4, 5, 6],
  };

  static const Map<String, String> presetsDescriptions = {
    'Flat': 'No EQ applied',
    'Bass Boost': 'Enhanced bass frequencies',
    'Treble Boost': 'Enhanced treble frequencies',
    'Pop': 'Optimized for pop music',
    'Rock': 'Optimized for rock music',
    'Hip-Hop': 'Optimized for hip-hop music',
    'Electronic': 'Optimized for electronic music',
    'Jazz': 'Optimized for jazz music',
    'Classical': 'Optimized for classical music',
    'Dance': 'Optimized for dance music',
  };

  static List<String> get availablePresets => presetsMap.keys.toList();

  static List<double> getPresetValues(String presetName) {
    return presetsMap[presetName] ?? presetsMap['Flat']!;
  }

  static String getPresetDescription(String presetName) {
    return presetsDescriptions[presetName] ?? 'Unknown preset';
  }
}

