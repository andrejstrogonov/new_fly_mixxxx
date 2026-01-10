# Fly Mixxx - Clean MVVM Architecture

## Architecture Overview

This application follows **MVVM (Model-View-ViewModel)** architecture with **Clean Code** principles:

```
lib/
├── main.dart                           # App entry point
├── core/                              # Core utilities and constants
│   ├── constants/                     # App constants
│   ├── exceptions/                    # Custom exceptions
│   ├── extensions/                    # Dart extensions
│   └── utils/                         # Utility classes
├── domain/                            # Business logic layer
│   ├── entities/                      # Business entities
│   ├── repositories/                  # Repository interfaces
│   └── usecases/                      # Use cases
├── presentation/                      # UI layer
│   ├── screens/                       # Screen widgets
│   └── viewmodels/                    # ViewModels (state management)
├── services/                          # Services and DI
├── utils/                             # Utility functions
└── widgets/                           # Reusable UI components
```

## Key Components

### ViewModels
- **MixerViewModel**: Handles all mixer-related state and business logic
- **BaseViewModel**: Base class with common ViewModel functionality

### Dependency Injection
- **ServiceLocator**: Manages dependencies using GetIt package

### Clean Code Principles
- Single Responsibility Principle
- Dependency Inversion
- Separation of Concerns
- MVVM Pattern

## Benefits

1. **Maintainable**: Clear separation of concerns
2. **Testable**: Business logic separated from UI
3. **Scalable**: Easy to add new features
4. **Clean**: Follows SOLID principles
5. **Reactive**: State management with Provider

## Usage

The app uses Provider for state management with ViewModels:

```dart
Consumer<MixerViewModel>(
  builder: (context, viewModel, _) {
    return YourWidget(
      data: viewModel.someData,
      onAction: () => viewModel.performAction(),
    );
  },
)
```

## Getting Started

1. Run `flutter pub get`
2. Run `flutter run`

The app will initialize the ServiceLocator and provide ViewModels to the widget tree.