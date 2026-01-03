# Fly Mixxx - Installation & Build Checklist

## Pre-Installation Requirements

### System Requirements

#### Windows
- [ ] Windows 10 or later
- [ ] At least 2GB RAM
- [ ] 500MB free disk space
- [ ] Administrator access for installation

#### Android
- [ ] Android 5.0 (API 21) or later
- [ ] At least 1GB RAM
- [ ] 200MB free storage space
- [ ] USB debugging enabled (for development)

### Software Requirements

#### All Platforms
- [ ] Flutter SDK 3.10.4 or higher
- [ ] Dart SDK 3.10.4 or higher
- [ ] Git (for version control)

#### Windows Development
- [ ] Visual Studio 2022 or Build Tools
- [ ] C++ development tools
- [ ] Windows SDK

#### Android Development
- [ ] Android SDK (API 21+)
- [ ] Android NDK
- [ ] Java Development Kit (JDK) 11+
- [ ] Android Studio (optional but recommended)

## Installation Steps

### Step 1: Verify Flutter Installation

```bash
flutter --version
dart --version
flutter doctor
```

**Checklist:**
- [ ] Flutter version is 3.10.4 or higher
- [ ] Dart version is 3.10.4 or higher
- [ ] All required components are installed

### Step 2: Clone/Download Project

```bash
cd C:\Users\strog\StudioProjects
# Project is already at: new_fly_mixxxx
```

**Checklist:**
- [ ] Project directory exists
- [ ] All files are present
- [ ] No permission issues

### Step 3: Install Dependencies

```bash
cd C:\Users\strog\StudioProjects\new_fly_mixxxx
flutter pub get
```

**Checklist:**
- [ ] Command completes without errors
- [ ] `pubspec.lock` file is created/updated
- [ ] All packages are downloaded

### Step 4: Verify Project Structure

```bash
# Check main files exist
ls lib/main.dart
ls lib/providers/audio_provider.dart
ls lib/screens/mixer_screen.dart
ls lib/widgets/
```

**Checklist:**
- [ ] main.dart exists
- [ ] audio_provider.dart exists
- [ ] mixer_screen.dart exists
- [ ] All widget files exist (3 files)

### Step 5: Run Code Analysis

```bash
flutter analyze
```

**Checklist:**
- [ ] No errors reported
- [ ] No critical warnings
- [ ] Code quality is acceptable

## Building for Windows

### Prerequisites
- [ ] Visual Studio 2022 or Build Tools installed
- [ ] C++ development tools installed
- [ ] Windows SDK installed

### Build Steps

```bash
cd C:\Users\strog\StudioProjects\new_fly_mixxxx

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build for Windows
flutter build windows --release
```

**Checklist:**
- [ ] Build completes without errors
- [ ] Executable is created at: `build\windows\runner\Release\new_fly_mixxxx.exe`
- [ ] File size is reasonable (>50MB)

### Testing Windows Build

```bash
# Run in debug mode
flutter run -d windows

# Or run the built executable
.\build\windows\runner\Release\new_fly_mixxxx.exe
```

**Checklist:**
- [ ] Application launches successfully
- [ ] UI displays correctly
- [ ] All controls are responsive
- [ ] Audio playback works (if audio file available)

## Building for Android

### Prerequisites
- [ ] Android SDK installed
- [ ] Android NDK installed
- [ ] JDK 11+ installed
- [ ] Android device or emulator available

### Build Steps

```bash
cd C:\Users\strog\StudioProjects\new_fly_mixxxx

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build APK
flutter build apk --release
```

**Checklist:**
- [ ] Build completes without errors
- [ ] APK is created at: `build\app\outputs\flutter-apk\app-release.apk`
- [ ] File size is reasonable (>30MB)

### Testing Android Build

```bash
# Connect device or start emulator
adb devices

# Install APK
adb install build\app\outputs\flutter-apk\app-release.apk

# Or use Flutter
flutter run -d android
```

**Checklist:**
- [ ] Application installs successfully
- [ ] Application launches on device
- [ ] UI displays correctly
- [ ] All controls are responsive
- [ ] Permissions are requested (storage)

## Feature Verification Checklist

### Deck Controls
- [ ] Play button works
- [ ] Pause button works
- [ ] Stop button works
- [ ] Progress bar displays correctly
- [ ] Seek functionality works
- [ ] Volume slider works
- [ ] Duration display is correct

### Mixer Controls
- [ ] Crossfader slider works
- [ ] Master volume slider works
- [ ] BPM slider works (60-240 range)
- [ ] Tempo slider works (0.5x-2.0x range)
- [ ] All values display correctly

### Equalizer
- [ ] All 10 sliders are visible
- [ ] Each slider adjusts independently
- [ ] Values display correctly (-12dB to +12dB)
- [ ] Reset button works
- [ ] Frequency labels are correct

### UI/UX
- [ ] Dark theme displays correctly
- [ ] All text is readable
- [ ] Buttons are clickable
- [ ] Layout is responsive
- [ ] No visual glitches

## Audio File Testing

### Supported Formats
- [ ] MP3 files play correctly
- [ ] WAV files play correctly
- [ ] FLAC files play correctly (if available)
- [ ] OGG files play correctly (if available)

### Audio Quality
- [ ] No distortion at normal volume
- [ ] No audio dropouts
- [ ] Smooth playback
- [ ] Correct duration display

## Performance Testing

### Windows
- [ ] CPU usage is <10% at idle
- [ ] Memory usage is <100MB
- [ ] No lag when adjusting controls
- [ ] Smooth UI animations

### Android
- [ ] App launches in <3 seconds
- [ ] No lag when adjusting controls
- [ ] Battery drain is acceptable
- [ ] No memory leaks

## Troubleshooting Checklist

### Build Issues
- [ ] Run `flutter clean` if build fails
- [ ] Delete `pubspec.lock` and run `flutter pub get`
- [ ] Check Flutter version with `flutter --version`
- [ ] Run `flutter doctor` to verify setup

### Runtime Issues
- [ ] Check device permissions (Android)
- [ ] Verify audio file format is supported
- [ ] Check device volume settings
- [ ] Restart application if frozen

### Audio Issues
- [ ] Verify audio file is not corrupted
- [ ] Check file path is correct
- [ ] Ensure sufficient storage space
- [ ] Try different audio file

## Documentation Review

- [ ] README.md is readable
- [ ] SETUP_GUIDE.md is complete
- [ ] QUICK_REFERENCE.md is helpful
- [ ] TANGO_PRESETS.md is accurate
- [ ] DEVELOPER_GUIDE.md is clear
- [ ] PROJECT_SUMMARY.md is comprehensive

## Final Verification

### Windows Release
- [ ] Executable runs standalone
- [ ] No dependencies missing
- [ ] All features work correctly
- [ ] Ready for distribution

### Android Release
- [ ] APK installs on device
- [ ] All permissions work
- [ ] All features work correctly
- [ ] Ready for Play Store submission

## Post-Installation

### First Run
1. [ ] Launch application
2. [ ] Grant permissions (Android)
3. [ ] Load audio file
4. [ ] Test playback
5. [ ] Test mixing controls
6. [ ] Test equalizer

### Customization (Optional)
- [ ] Modify theme colors
- [ ] Adjust EQ presets
- [ ] Configure BPM ranges
- [ ] Add custom presets

### Deployment
- [ ] Create installer (Windows)
- [ ] Sign APK (Android)
- [ ] Upload to distribution platform
- [ ] Create release notes

## Support Resources

### Documentation
- README.md - Feature overview
- SETUP_GUIDE.md - Installation guide
- QUICK_REFERENCE.md - User guide
- DEVELOPER_GUIDE.md - Development guide

### Troubleshooting
- Flutter Documentation: https://flutter.dev/docs
- just_audio Package: https://pub.dev/packages/just_audio
- Provider Package: https://pub.dev/packages/provider

### Getting Help
- Check documentation first
- Review error messages carefully
- Search for similar issues
- Consult Flutter community

## Sign-Off

- [ ] All prerequisites met
- [ ] Installation completed successfully
- [ ] All features verified
- [ ] Documentation reviewed
- [ ] Ready for use/distribution

---

**Fly Mixxx** - Installation & Build Checklist v1.0
Date: _______________
Completed By: _______________
