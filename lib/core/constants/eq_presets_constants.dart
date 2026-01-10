import '../../domain/entities/eq_preset_entity.dart';

class EQPresetsConstants {
  static final Map<String, EQPresetEntity> presets = {
    'Flat': EQPresetEntity(
      name: 'Flat',
      bands: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
      description: 'Neutral flat response',
    ),
    'Tango': EQPresetEntity(
      name: 'Tango',
      bands: [1.0, 2.0, 1.0, 1.5, 2.0, 1.0, 0.5, -0.5, -1.0, 0.0],
      description: 'Enhanced midrange for tango vocals and strings',
    ),
    'Jazz': EQPresetEntity(
      name: 'Jazz',
      bands: [1.0, 2.0, 1.0, 0.0, -1.0, 1.0, 2.0, 3.0, 2.0, 1.0],
      description: 'Warm bass and bright highs for jazz',
    ),
    'Folk Argentino': EQPresetEntity(
      name: 'Folk Argentino',
      bands: [2.0, 1.0, 0.0, 1.0, 2.0, 1.0, 0.0, -1.0, -2.0, -1.0],
      description: 'Warm and earthy for Argentine folk',
    ),
    'Folk Russian': EQPresetEntity(
      name: 'Folk Russian',
      bands: [1.0, 0.0, -1.0, 0.0, 1.0, 2.0, 3.0, 2.0, 1.0, 0.0],
      description: 'Bright and crisp for Russian folk',
    ),
    'Cross-step Waltz': EQPresetEntity(
      name: 'Cross-step Waltz',
      bands: [0.0, 1.0, 2.0, 1.0, 0.0, -1.0, 0.0, 1.0, 2.0, 1.0],
      description: 'Balanced with emphasis on rhythm',
    ),
    'Bass Boost': EQPresetEntity(
      name: 'Bass Boost',
      bands: [6.0, 5.0, 3.0, 0.0, -2.0, -3.0, -2.0, 0.0, 1.0, 2.0],
      description: 'Enhanced low frequencies',
    ),
    'Treble Boost': EQPresetEntity(
      name: 'Treble Boost',
      bands: [-3.0, -2.0, -1.0, 0.0, 1.0, 3.0, 5.0, 6.0, 5.0, 4.0],
      description: 'Enhanced high frequencies',
    ),
    'Vocal': EQPresetEntity(
      name: 'Vocal',
      bands: [-2.0, -1.0, 0.0, 2.0, 3.0, 2.0, 1.0, -1.0, -2.0, -3.0],
      description: 'Optimized for vocal clarity',
    ),
  };
}

