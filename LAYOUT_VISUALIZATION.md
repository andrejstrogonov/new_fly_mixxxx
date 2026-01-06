# 🎨 Визуальная схема нового Layout - Fly Mixxx

## Иерархия компонентов

```
MixerScreen
│
├── AppBar
│   └── "Fly Mixxx - DJ Mixer"
│
└── Body (Consumer<AudioProvider>)
    │
    ├── CONDITIONAL LAYOUT (зависит от screenWidth)
    │   │
    │   ├── isLargeScreen (> 1200px)
    │   │   └── LARGE SCREEN LAYOUT
    │   │
    │   ├── isMediumScreen (800-1200px)
    │   │   └── MEDIUM SCREEN LAYOUT
    │   │
    │   └── else (<800px)
    │       └── SMALL SCREEN LAYOUT
    │
    └── FloatingActionButton
        └── Music Note Icon
```

## LARGE SCREEN LAYOUT (> 1200px) - НОУТБУК / БОЛЬШОЙ ПЛАНШЕТ

```
┌──────────────────────────────────────────────────────────────────────┐
│                        🎵 Fly Mixxx - DJ Mixer                      │
├──────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │                    TRACK LOADER                             │   │
│  │  ┌──────────────────────────────────────────────────────┐   │   │
│  │  │ Now Playing:                                         │   │   │
│  │  │  Deck 1: 🎵 "song_name.mp3" (3:24)                │   │   │
│  │  │  Deck 2: 🎵 "another_song.mp3" (4:15)             │   │   │
│  │  └──────────────────────────────────────────────────────┘   │   │
│  │  ┌──────────────────┐ ┌──────────────────┐                │   │
│  │  │ Deck 1 Queue (0) │ │ Deck 2 Queue (0) │                │   │
│  │  │ [Empty]          │ │ [Empty]          │                │   │
│  │  │ [+Add Track]     │ │ [+Add Track]     │                │   │
│  │  └──────────────────┘ └──────────────────┘                │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                       │
│  ┌─────────────────────────┬─────────────────────────────────────┐ │
│  │  LEFT COLUMN (DECKS)    │   RIGHT COLUMN (CONTROLS)          │ │
│  ├─────────────────────────┼─────────────────────────────────────┤ │
│  │ ┌─────────┐┌─────────┐  │ ┌──────────────────────────────┐   │ │
│  │ │ DECK 1  ││ DECK 2  │  │ │   MIXER CONTROLS             │   │ │
│  │ │━━━━━━━━━││━━━━━━━━━│  │ │ ┌──────────────────────────┐ │   │ │
│  │ │◆ Playing││◆ Stop   │  │ │ │ Crossfader: ═════●═════  │ │   │ │
│  │ │Progress:││Progress:│  │ │ │ Master Vol: ═══●═════    │ │   │ │
│  │ │[======●]││[═══════]│  │ │ │                          │ │   │ │
│  │ │ 1:24/  ││ 0:00/  │  │ │ │ BPM:    [─────●─────]     │ │   │ │
│  │ │  3:24  ││  3:15  │  │ │ │ Tempo:  [─────●─────]     │ │   │ │
│  │ │        ││        │  │ │ │                          │ │   │ │
│  │ │[Play] ││[Pause] │  │ │ │ Deck Volumes:              │ │   │ │
│  │ │[Stop] ││[Stop]  │  │ │ │ Deck 1: [──●──] 65%        │ │   │ │
│  │ └─────────┘└─────────┘  │ │ Deck 2: [─●───] 45%        │ │   │ │
│  │                          │ └──────────────────────────┘ │   │ │
│  └─────────────────────────┴─────────────────────────────────┘   │
│                                                                       │
│  ┌──────────────────────────┬──────────────────────────────────┐   │
│  │   LEFT (EQUALIZER)       │   RIGHT (FREQUENCY RESPONSE)   │   │
│  ├──────────────────────────┼──────────────────────────────────┤   │
│  │  10-Band Equalizer       │   Frequency Response (АЧХ)      │   │
│  │  ▼60Hz  ▲250Hz  ▼2kHz   │   [Graph with Magnitude/Phase] │   │
│  │  [═●══] [═●══] [═●══]   │   ┌────────────────────────┐   │   │
│  │  ...                     │   │▲                      │   │   │
│  │                          │   │ │    /\  /\          │   │   │
│  │  EQ Presets Carousel     │   │ │   /  \/  \         │   │   │
│  │  ◄ Rock | Pop ► ♫        │   │ │  /        \        │   │   │
│  │                          │   │ │/          \       │   │   │
│  │                          │   │─┴──────────────┴──  │   │   │
│  │                          │   └────────────────────┘   │   │
│  └──────────────────────────┴──────────────────────────────┘   │
│                                                                       │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │              Audio Device Analysis / Composition Generator    │   │
│  └──────────────────────────────────────────────────────────────┘   │
│                                                                       │
└──────────────────────────────────────────────────────────────────────┘
```

## MEDIUM SCREEN LAYOUT (800-1200px) - ПЛАНШЕТ

```
┌────────────────────────────────────────────┐
│     🎵 Fly Mixxx - DJ Mixer                │
├────────────────────────────────────────────┤
│ ┌───────────────────────────────────────┐  │
│ │          TRACK LOADER                 │  │
│ │ Now Playing: Deck 1/2 Info            │  │
│ │ Queue Lists for Deck 1 and Deck 2     │  │
│ └───────────────────────────────────────┘  │
│                                             │
│ ┌──────────────┬──────────────────────┐   │
│ │ DECK 1       │  MIXER CONTROLS:     │   │
│ │ Progress     │  - Crossfader        │   │
│ │ [====●====]  │  - Master Volume     │   │
│ │ Time/Dur     │  - BPM               │   │
│ │ Play/Stop    │  - Tempo             │   │
│ │              │  - Deck Volumes      │   │
│ ├──────────────┤                      │   │
│ │ DECK 2       │                      │   │
│ │ Progress     │                      │   │
│ │ [===●=====]  │                      │   │
│ │ Time/Dur     │                      │   │
│ │ Play/Stop    │                      │   │
│ └──────────────┴──────────────────────┘   │
│                                             │
│ ┌────────────────────────────────────────┐ │
│ │         EQUALIZER & EQ PRESETS        │ │
│ │    ▼60Hz  ▲250Hz  ▼2kHz ...          │ │
│ │    [═●══] [═●══] [═●══]              │ │
│ │  ◄ Rock | Pop ► ♫                    │ │
│ └────────────────────────────────────────┘ │
│                                             │
│ ┌────────────────────────────────────────┐ │
│ │    FREQUENCY RESPONSE (АЧХ & ФЧХ)     │ │
│ │ [Graph visualization]                  │ │
│ └────────────────────────────────────────┘ │
│                                             │
│ ┌────────────────────────────────────────┐ │
│ │  Audio Analysis / Composition Generator│ │
│ └────────────────────────────────────────┘ │
│                                             │
└────────────────────────────────────────────┘
```

## SMALL SCREEN LAYOUT (<800px) - СМАРТФОН

```
┌──────────────────────────┐
│  🎵 Fly Mixxx - DJ Mixer │
├──────────────────────────┤
│                          │
│ ┌──────────────────────┐ │
│ │   TRACK LOADER       │ │
│ │ Now Playing Info     │ │
│ │ Queue Lists          │ │
│ └──────────────────────┘ │
│                          │
│ ┌───────────┬──────────┐ │
│ │ DECK 1    │ DECK 2   │ │
│ │Progress   │Progress  │ │
│ │[====●═]   │[═══●══]  │ │
│ │Play/Stop  │Play/Stop │ │
│ └───────────┴──────────┘ │
│                          │
│ ┌──────────────────────┐ │
│ │ MIXER CONTROLS       │ │
│ │ Crossfader: [──●──]  │ │
│ │ Master Vol: [─●────] │ │
│ │ BPM:        [──●──]  │ │
│ │ Tempo:      [──●──]  │ │
│ │ Deck 1 Vol: [──●──]  │ │
│ │ Deck 2 Vol: [──●──]  │ │
│ └──────────────────────┘ │
│                          │
│ ┌──────────────────────┐ │
│ │   EQUALIZER          │ │
│ │   ▼60Hz  ▲250Hz ...  │ │
│ │   [═●══] [═●══] ...  │ │
│ │   ◄ Presets ►        │ │
│ └──────────────────────┘ │
│                          │
│ (rest scrolls below)     │
│                          │
└──────────────────────────┘
```

## Поток данных (Data Flow)

```
AudioProvider (State Management)
│
├── Track Loader Data:
│   ├── queue1, queue2
│   ├── currentTrackIndex1, currentTrackIndex2
│   └── Track info (name, duration)
│
├── Playback State:
│   ├── isPlaying1, isPlaying2
│   ├── position1, position2
│   ├── duration1, duration2
│   └── Callbacks: playPause(), stop(), seek()
│
└── Mixer Parameters:
    ├── volume1, volume2
    ├── crossfaderPosition
    ├── masterVolume
    ├── bpm, tempoMultiplier
    └── Callbacks: setVolume(), setCrossfader(), etc.

↓

Widgets consume this data:
│
├── TrackLoaderWidget
│   ├── Displays: Current track info
│   └── Actions: Add/Remove tracks, Play track from queue
│
├── DeckWidget (x2)
│   ├── Displays: Progress bar, time, play controls
│   └── Actions: Play/Pause/Stop
│
├── MixerControlsWidget
│   ├── Displays: All mixer parameters
│   └── Actions: Adjust Volume, Crossfader, BPM, etc.
│
└── Other Widgets
    ├── EqualizerWidget
    ├── EQPresetCarouselWidget
    └── FrequencyResponseWidget
```

## Управление Screen Sizing

```
Flutter Widget Tree
│
└── MixerScreen (StatefulWidget)
    │
    └── build(context)
        │
        ├── MediaQuery.of(context).size.width
        │   ├── screenWidth > 1200
        │   │   └── isLargeScreen = true
        │   │       └── Two-column layout (Decks + Controls)
        │   │
        │   └── screenWidth ≤ 1200
        │       └── Conditional flow continues
        │
        ├── screenWidth > 800
        │   └── isMediumScreen = true
        │       └── Vertical deck layout with controls
        │
        └── screenWidth ≤ 800
            └── Default small screen layout
                └── All elements stacked vertically

```

## Сравнение Before/After

| Компонент | Before | After |
|-----------|--------|-------|
| **Volume Controls** | В каждом DeckWidget | В MixerControlsWidget |
| **Playing Track Info** | В DeckWidget | В TrackLoaderWidget |
| **Layout на ноутбуке** | Все в колонку (много скрола) | 2 колонки (меньше скрола) |
| **DeckWidget размер** | Большой (много элементов) | Маленький (только controls) |
| **Адаптивность** | Одинаков для всех экранов | Разные для phone/tablet/laptop |
| **Информативность** | Разбросано | Организованно по функциям |

## Ключевые улучшения

✨ **Чистота кода** - каждый компонент отвечает за одну функцию
✨ **UX** - меньше скролла на больших экранах
✨ **Мобильность** - оптимизировано для всех размеров
✨ **Удобство** - все параметры микшера в одном месте
✨ **Масштабируемость** - легко добавить новые компоненты

