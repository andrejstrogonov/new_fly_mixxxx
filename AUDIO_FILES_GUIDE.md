# Fly Mixxx - Audio File Recommendations

## Recommended Tango Instrumentals

### Classic Tango Orchestras

#### Carlos Gardel Collection
- "El Día Que Me Quieras" - Instrumental
- "Volvió una Noche" - Instrumental
- "La Cumparsita" - Instrumental
- BPM: 120-130
- Format: MP3 320kbps or FLAC

#### Astor Piazzolla
- "Libertango" - Instrumental
- "Tango Apasionado" - Instrumental
- "Adiós Nonino" - Instrumental
- BPM: 110-130
- Format: MP3 320kbps or FLAC

#### Juan D'Arienzo
- "El Choclo" - Instrumental
- "Caminito" - Instrumental
- "Tango Argentino" - Instrumental
- BPM: 125-135
- Format: MP3 320kbps or FLAC

#### Osvaldo Pugliese
- "La Yumba" - Instrumental
- "Recuerdo" - Instrumental
- "Diferente" - Instrumental
- BPM: 115-125
- Format: MP3 320kbps or FLAC

### Modern Tango Nuevo

#### Piazzolla Nuevo
- "Tango: Zero Hour" - Instrumental
- "Tango Sensations" - Instrumental
- BPM: 100-120
- Format: MP3 320kbps or FLAC

#### Contemporary Artists
- "Tango Fusion" - Various Artists
- "Modern Tango" - Contemporary Ensembles
- BPM: 100-130
- Format: MP3 320kbps or FLAC

## Audio File Quality Guidelines

### Recommended Specifications

#### For Best Quality
- **Format**: FLAC (lossless)
- **Bitrate**: 320kbps equivalent
- **Sample Rate**: 44.1kHz or 48kHz
- **Bit Depth**: 16-bit or 24-bit
- **File Size**: 5-10MB per minute

#### For Good Quality
- **Format**: MP3
- **Bitrate**: 320kbps
- **Sample Rate**: 44.1kHz
- **Bit Depth**: 16-bit
- **File Size**: 1.2-1.5MB per minute

#### For Acceptable Quality
- **Format**: OGG Vorbis
- **Bitrate**: 256-320kbps
- **Sample Rate**: 44.1kHz
- **Bit Depth**: 16-bit
- **File Size**: 1-1.2MB per minute

### Avoid These Specifications
- Bitrate below 192kbps (poor quality)
- Sample rate below 44.1kHz (audio artifacts)
- Heavily compressed formats (AAC below 256kbps)
- Very old or degraded recordings

## File Organization Structure

### Recommended Directory Layout

```
Music/
├── Tango/
│   ├── Classic/
│   │   ├── Gardel/
│   │   │   ├── El_Dia_Que_Me_Quieras.mp3
│   │   │   └── Volvio_Una_Noche.mp3
│   │   ├── Piazzolla/
│   │   │   ├── Libertango.mp3
│   │   │   └── Tango_Apasionado.mp3
│   │   ├── D'Arienzo/
│   │   │   ├── El_Choclo.mp3
│   │   │   └── Caminito.mp3
│   │   └─��� Pugliese/
│   │       ├── La_Yumba.mp3
│   │       └── Recuerdo.mp3
│   ├── Nuevo/
│   │   ├── Piazzolla_Nuevo/
│   │   │   └── Tango_Zero_Hour.mp3
│   │   └── Contemporary/
│   │       └── Modern_Tango.mp3
│   ├── Instrumental/
│   │   ├── Orchestral/
│   │   └── Ensemble/
│   └── Vocal/
│       ├── Male_Vocals/
│       └── Female_Vocals/
├── Other_Genres/
│   ├── Jazz/
│   ├── Classical/
│   └── Electronic/
└── Playlists/
    ├── Evening_Mix.txt
    ├── Dance_Mix.txt
    └── Romantic_Mix.txt
```

## Creating Playlists

### Playlist File Format (Text)

Create a `.txt` file with full paths to audio files:

```
C:\Music\Tango\Classic\Gardel\El_Dia_Que_Me_Quieras.mp3
C:\Music\Tango\Classic\Piazzolla\Libertango.mp3
C:\Music\Tango\Classic\D'Arienzo\El_Choclo.mp3
C:\Music\Tango\Classic\Pugliese\La_Yumba.mp3
```

### Playlist Organization Tips

1. **By Tempo**:
   - Slow Tango (100-110 BPM)
   - Medium Tango (120-130 BPM)
   - Fast Tango (140-150 BPM)

2. **By Era**:
   - Golden Age (1920-1950)
   - Modern Era (1950-1980)
   - Contemporary (1980-present)

3. **By Mood**:
   - Romantic
   - Energetic
   - Melancholic
   - Festive

4. **By Instrument Focus**:
   - Bandoneon Emphasis
   - Violin Emphasis
   - Piano Emphasis
   - Full Orchestra

## Audio File Conversion

### Converting to MP3 320kbps

Using FFmpeg:
```bash
ffmpeg -i input.wav -b:a 320k output.mp3
```

### Converting to FLAC

Using FFmpeg:
```bash
ffmpeg -i input.mp3 -c:a flac output.flac
```

### Batch Conversion

Windows batch script:
```batch
@echo off
for %%f in (*.wav) do (
    ffmpeg -i "%%f" -b:a 320k "%%~nf.mp3"
)
```

## Audio File Testing

### Before Using in Fly Mixxx

1. **Verify Format**:
   - Check file extension
   - Verify with media player
   - Confirm bitrate

2. **Check Quality**:
   - Listen for artifacts
   - Check for distortion
   - Verify duration

3. **Test Playback**:
   - Load in Fly Mixxx
   - Play from start
   - Play from middle
   - Seek to end

4. **Verify Metadata**:
   - Check title
   - Check artist
   - Check duration
   - Check bitrate

## Recommended Audio Players for Testing

### Windows
- VLC Media Player (free)
- Foobar2000 (free)
- MediaInfo (free, for file info)

### Android
- VLC for Android (free)
- Poweramp (paid)
- Neutron Music Player (paid)

## Audio File Troubleshooting

### Issue: File Won't Play
- **Solution**: Check format is supported
- Try converting to MP3 320kbps
- Verify file is not corrupted

### Issue: Audio Distortion
- **Solution**: Check file quality
- Reduce volume in Fly Mixxx
- Try different audio file

### Issue: Playback Stutters
- **Solution**: Check device storage
- Close other applications
- Try lower bitrate file

### Issue: Seek Doesn't Work
- **Solution**: Check file format
- Try different file
- Restart application

## Recommended Mixing Combinations

### Classic Tango Mix
1. "El Día Que Me Quieras" - Gardel (120 BPM)
2. "Libertango" - Piazzolla (115 BPM)
3. "El Choclo" - D'Arienzo (130 BPM)
4. "La Yumba" - Pugliese (120 BPM)

### Tango Nuevo Mix
1. "Tango: Zero Hour" - Piazzolla (110 BPM)
2. "Tango Apasionado" - Piazzolla (120 BPM)
3. "Modern Tango" - Contemporary (115 BPM)

### Romantic Tango Mix
1. "Volvió una Noche" - Gardel (115 BPM)
2. "Recuerdo" - Pugliese (110 BPM)
3. "Adiós Nonino" - Piazzolla (105 BPM)

### Energetic Tango Mix
1. "Caminito" - D'Arienzo (135 BPM)
2. "Tango Argentino" - D'Arienzo (140 BPM)
3. "La Cumparsita" - Gardel (130 BPM)

## Audio File Sources

### Legal Sources
- **Spotify**: Streaming service with tango collection
- **Apple Music**: Streaming service with tango collection
- **YouTube Music**: Streaming service with tango collection
- **Bandcamp**: Independent artists and labels
- **Archive.org**: Public domain recordings

### Purchasing Options
- **iTunes**: Digital downloads
- **Amazon Music**: Digital downloads
- **Bandcamp**: Direct from artists
- **CD Stores**: Physical media

### Free/Open Source
- **Free Music Archive**: Creative Commons music
- **Incompetech**: Royalty-free music
- **ccMixter**: Creative Commons remixes

## Copyright and Licensing

### Important Notes
- Respect copyright laws in your jurisdiction
- Only use music you have rights to
- For commercial use, obtain proper licenses
- Credit artists when required

### Licensing Options
- **Personal Use**: For private listening
- **Commercial Use**: For public performances
- **Streaming**: For online distribution
- **Synchronization**: For video/film use

## Audio File Maintenance

### Backup Strategy
1. Keep original files on external drive
2. Maintain organized folder structure
3. Use cloud backup for important files
4. Test backups regularly

### File Organization Tips
1. Use consistent naming convention
2. Include artist and title in filename
3. Organize by genre and era
4. Create playlists for quick access

### Metadata Management
1. Add ID3 tags to MP3 files
2. Include artist, title, album
3. Add genre and year information
4. Use consistent formatting

## Performance Optimization

### For Smooth Playback
- Use SSD for music storage
- Keep files on local drive
- Avoid network storage
- Maintain adequate free space

### For Better Sound
- Use high-quality files (320kbps+)
- Avoid heavily compressed formats
- Use external audio interface
- Minimize background noise

---

**Fly Mixxx** - Audio File Recommendations v1.0
