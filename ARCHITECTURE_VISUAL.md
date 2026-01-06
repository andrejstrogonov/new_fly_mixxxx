# 🎪 EQ Preset Carousel - Visual Architecture

## Component Structure

```
┌─────────────────────────────────────────────────────────────────────┐
│                       MixerScreen (Stateful)                        │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │  AppBar: "Fly Mixxx - DJ Mixer"                           │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                       │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │  SingleChildScrollView                                      │   │
│  │  ┌───────────────────────────────────────────────────────┐ │   │
│  │  │  TrackLoaderWidget                                  │ │   │
│  │  └───────────────────────────────────────────────────────┘ │   │
│  │  ┌────────────────┐  ┌────────────────┐                   │   │
│  │  │ DeckWidget 1   │  │ DeckWidget 2   │                   │   │
│  │  └────────────────┘  └────────────────┘                   │   │
│  │  ┌───────────────────────────────────────────────────────┐ │   │
│  │  │  MixerControlsWidget                                │ │   │
│  │  └───────────────────────────────────────────────────────┘ │   │
│  │  ┌───────────────────────────────────────────────────────┐ │   │
│  │  │  EqualizerWidget (10-Band)                          │ │   │
│  │  └───────────────────────────────────────────────────────┘ │   │
│  │  ┌───────────────────────────────────────────────────────┐ │   │
│  │  │  ✨ EQPresetCarouselWidget (NEW!)                    │ │   │
│  │  │  ┌─────────────────────────────────────────────────┐ │ │   │
│  │  │  │ Header: "EQ Presets (Genres)" + Badge          │ │ │   │
│  │  │  │ ┌───────────────────────────────────────────┐  │ │ │   │
│  │  │  │ │ PageView.builder (Carousel)             │  │ │ │   │
│  │  │  │ │ ┌─────────────────────────────────────┐ │  │ │ │   │
│  │  │  │ │ │ Card 1 (Flat)      [Currently]    │ │  │ │ │   │
│  │  │  │ │ │ ┌───────────────────────────────┐ │ │  │ │ │   │
│  │  │  │ │ │ │ Genre: Flat                 │ │ │  │ │ │   │
│  │  │  │ │ │ │ Neutral flat response       │ │ │  │ │ │   │
│  │  │  │ │ │ │ [Active Badge]              │ │ │  │ │ │   │
│  │  │  │ │ │ └───────────────────────────────┘ │ │  │ │ │   │
│  │  │  │ │ │ Card 2 (Tango)                   │ │  │ │ │   │
│  │  │  │ │ │ Card 3 (Jazz)                    │ │  │ │ │   │
│  │  │  │ │ │ ... 6 more cards                 │ │  │ │ │   │
│  │  │  │ │ └─────────────────────────────────┘ │  │ │ │   │
│  │  │  │ ┌───────────────────────────────────────────┐  │ │ │   │
│  │  │  │ │ Navigation Dots (9 clickable)          │  │ │ │   │
│  │  │  │ │ ● ○ ○ ○ ○ ○ ○ ○ ○                       │  │ │ │   │
│  │  │  │ └───────────────────────────────────────────┘  │ │ │   │
│  │  │  └─────────────────────────────────────────────────┘ │ │   │
│  │  │  ┌─────────────────────────────────────────────────┐ │ │   │
│  │  │  │  FrequencyResponseWidget                       │ │ │   │
│  │  │  └─────────────────────────────────────────────────┘ │ │   │
│  │  │  ┌─────────────────────────────────────────────────┐ │ │   │
│  │  │  │  AudioDeviceAnalysisWidget                    │ │ │   │
│  │  │  └─────────────────────────────────────────────────┘ │ │   │
│  │  │  ┌─────────────────────────────────────────────────┐ │ │   │
│  │  │  │  CompositionGeneratorWidget                   │ │ │   │
│  │  │  └─────────────────────────────────────────────────┘ │ │   │
│  │  │  ┌─────────────────────────────────────────────────┐ │ │   │
│  │  │  │  Info Section: About Fly Mixxx               │ │ │   │
│  │  │  └─────────────────────────────────────────────────┘ │ │   │
│  │  └───────────────────────────────────────────────────────┘ │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                       │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │  FAB: DJ Features                                          │   │
│  └─────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Carousel Animation & Interaction Flow

### User Interaction → Animation → State Update

```
┌─────────────────────────────────────────────────────────────┐
│                     User Action                             │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Left Swipe          │    Right Swipe      │    Click Dot    │
│  ─────────           │    ──────────       │    ──────────    │
│  Next Genre          │    Prev Genre       │    Jump to Genre│
│                                                              │
└─────────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│               PageController.onPageChanged()               │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Get selected preset name                               │
│  2. Call audioProvider.applyPreset(presetName)            │
│  3. Provider updates eqBands with preset values           │
│  4. notifyListeners() triggered                           │
│                                                              │
└─────────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│            AnimatedBuilder Reaction (60 FPS)              │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  PageController.page → interpolate animation value       │
│                                                              │
│  For each card:                                            │
│  ┌──────────────────────────────────────────────────────┐ │
│  │ value = index - (page ?? currentIndex)              │ │
│  │ rotationY = value × 65 degrees                       │ │
│  │ scale = 1 - (abs(value) × 0.3)                      │ │
│  │                                                      │ │
│  │ Transform:                                           │ │
│  │  - Matrix4: rotate on Y axis                         │ │
│  │  - Scale: center scale for focus effect             │ │
│  └──────────────────────────────────────────────────────┘ │
│                                                              │
│  Current card: scale 1.0, no rotation                      │
│  Adjacent cards: scale 0.7, rotation 65°                   │
│  Others: scale 0.4, full rotation                          │
│                                                              │
└─────────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│               Audio State Update                            │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  AudioProvider._eqBands updated with:                      │
│  [band0, band1, band2, band3, band4, band5,              │
│   band6, band7, band8, band9]                            │
│                                                              │
│  Frequencies applied:                                      │
│  60Hz, 150Hz, 400Hz, 1kHz, 2.4kHz, 6kHz,                │
│  15kHz, 20kHz, 30kHz, 40kHz                              │
│                                                              │
└─────────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│           Consumer<AudioProvider> Rebuild                  │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. FrequencyResponseWidget updates charts                │
│  2. EqualizerWidget shows new band values                 │
│  3. AudioPlayer applies EQ in real-time                   │
│  4. Current preset badge updates                          │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Data Flow Architecture

```
                         User Interaction
                                │
                                ▼
                    ┌─────────────────────┐
                    │  EQPresetCarousel   │
                    │     Widget State    │
                    │  - PageController   │
                    │  - currentIndex     │
                    └─────────────────────┘
                                │
                                ▼
                    ┌─────────────────────┐
                    │  AudioProvider      │
                    │  (ChangeNotifier)   │
                    │                     │
                    │  Getters:           │
                    │  • eqBands[]        │
                    │  • eqPresets{}      │
                    │  • currentPreset    │
                    │                     │
                    │  Methods:           │
                    │  • applyPreset()    │
                    │  • setEqBand()      │
                    │  • resetEqualizer() │
                    │  • getPreset()      │
                    │  • getAvailable()   │
                    └─────────────────────┘
                                │
                  ┌─────────────┼─────────────┐
                  ▼             ▼             ▼
        ┌──────────────────────────────────────────┐
        │         Consumer Widgets                 │
        ├──────────────────────────────────────────┤
        │ • EqualizerWidget    (reads eqBands)    │
        │ • FrequencyResponse  (reads eqBands)    │
        │ • AudioDevice        (uses eqBands)     │
        │ • OtherWidgets...                       │
        └──────────────────────────────────────────┘
                  │
                  ▼
        ┌──────────────────────────────────────────┐
        │         Audio Processing                │
        ├──────────────────────────────────────────┤
        │ • Apply EQ to audio stream              │
        │ • Real-time frequency adjustment        │
        │ • Audio output to speakers/headphones   │
        └──────────────────────────────────────────┘
```

---

## Carousel Card Design

```
┌──────────────────────────────────────────┐
│     EQ Preset Card (Inactive)           │
├──────────────────────────────────────────┤
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Jazz                              │ │
│  │  Warm bass and bright highs for    │ │
│  │  jazz                              │ │
│  └────────────────────────────────────┘ │
│                                          │
│  Colors:                                │
│  • Background: rgba(99, 26, 255, 0.2)  │
│  • Border: rgba(99, 26, 255, 0.2)      │
│  • Text: #4a4a4a (light gray)          │
│                                          │
└──────────────────────────────────────────┘

┌──────────────────────────────────────────┐
│     EQ Preset Card (Active)             │
├──────────────────────────────────────────┤
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Tango                             │ │
│  │  Enhanced midrange for tango       │ │
│  │  vocals and strings                │ │
│  │                                    │ │
│  │           [Active]                 │ │
│  └────────────────────────────────────┘ │
│                                          │
│  Colors:                                │
│  • Background: rgba(99, 26, 255, 0.8)  │
│  • Border: #631aff (deep purple)       │
│  • Text: #ffffff (white)               │
│  • Shadow: box-shadow with glow        │
│  • Scale: 1.0 (full size)              │
│                                          │
│  ✨ 3D Transform Applied               │
│  ✨ Smooth Animation                   │
│                                          │
└──────────────────────────────────────────┘
```

---

## State Management Flow

```
┌─────────────────────────────────────────────────────────┐
│            EQPresetCarouselWidget                      │
│            (Stateful Widget)                           │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  State Variables:                                       │
│  • PageController _pageController                      │
│  • List<String> _presetNames                           │
│  • int _currentIndex                                   │
│                                                         │
│  Lifecycle:                                             │
│  initState()                                            │
│    └─ _pageController = PageController(...)           │
│    └─ _presetNames = audioProvider.getAvailable()     │
│    └─ _currentIndex = initial preset index            │
│                                                         │
│  build()                                                │
│    └─ Consumer<AudioProvider>                          │
│       └─ Header                                         │
│       └─ PageView.builder                              │
│       └─ Navigation Dots                               │
│                                                         │
│  dispose()                                              │
│    └─ _pageController.dispose()                        │
│                                                         │
│  onPageChanged(int index)                              │
│    └─ setState(_currentIndex = index)                  │
│    └─ audioProvider.applyPreset(_presetNames[index])  │
│                                                         │
└─────────────────────────────────────────────────────────┘
        │
        └─────────── Listens to ───────────────┐
                                                │
                    ┌──────────────────────────┘
                    ▼
        ┌─────────────────────────────────────┐
        │    AudioProvider                    │
        │    (ChangeNotifier)                 │
        ├─────────────────────────────────────┤
        │                                     │
        │  Private:                           │
        │  • List<double> _eqBands            │
        │  • String _currentPreset            │
        │  • Map eqPresets (static)           │
        │                                     │
        │  Public Methods:                    │
        │  • applyPreset(String name)        │
        │    └─ Updates _currentPreset       │
        │    └─ Updates _eqBands from preset │
        │    └─ notifyListeners()            │
        │                                     │
        │  • getAvailablePresets()           │
        │    └─ Returns presets.keys.toList()│
        │                                     │
        │  • getPreset(String name)          │
        │    └─ Returns EQPreset or null    │
        │                                     │
        └─────────────────────────────────────┘
```

---

## Animation Timeline

```
┌──────────┬──────────┬──────────┬──────────┬──────────┐
│  t=0ms   │  t=1ms   │  t=2ms   │  t=3ms   │  t=16ms  │
├──────────┼──────────┼──────────┼──────────┼──────────┤
│                                                       │
│ Swipe    Page moves Animate    Continue   Frame      │
│ detected by 1/60th  rotation & until      complete   │
│          scroll     scale      page=1     60 FPS     │
│          distance             lands      (next tick) │
│                                                       │
│ State:   State:   State:      State:     State:      │
│ ─────    ─────    ─────       ─────      ─────       │
│ value=0  value≈0.1 value≈0.5  value≈0.9 value=1.0   │
│ scale=1  scale≈0.8 scale≈0.5  scale≈0.7 scale=0.7   │
│ rotation rotation≈ rotation≈   rotation≈ rotation=65 │
│ =0°      19°      65°         62°        °           │
│                                                       │
└──────────┴──────────┴──────────┴──────────┴──────────┘
     ▼         ▼         ▼          ▼         ▼
   Center   Rotating   Peak       Landing   Settled
   Card     In         Animation  Position  Position
```

---

**Architecture Diagram Created:** January 6, 2026  
**Visual Components:** Complete  
**Status:** Ready for Reference ✅

