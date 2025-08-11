# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter exchange rate application (환율 변환기) that provides real-time currency conversion. The app features onboarding, currency selection, rate conversion, and a custom number keyboard interface.

## Development Commands

### Running the App
```bash
# Run on connected device/emulator
flutter run

# Run with specific device
flutter devices  # List available devices
flutter run -d [device_id]

# Run in release mode
flutter run --release
```

### Building the App
```bash
# Build APK for Android
flutter build apk

# Build for iOS (macOS only)
flutter build ios

# Build for Windows
flutter build windows
```

### Code Quality & Testing
```bash
# Analyze code for issues
flutter analyze

# Run tests
flutter test

# Run a specific test
flutter test test/[test_file.dart]

# Format code
dart format lib/
```

### Dependency Management
```bash
# Get dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade

# Clean build cache
flutter clean
```

## Architecture

### State Management
The app uses **Provider** for state management with three main providers:
- **ExchangeRateProvider**: Manages exchange rates, currency conversions, and user input
- **ThemeProvider**: Handles app theming and dark/light mode
- **OnboardingProvider**: Manages onboarding state and initial currency setup

### Data Flow
1. **API Service** (`ExchangeRateService`) fetches rates from exchangerate-api.com
2. **Providers** manage state and business logic
3. **Screens** consume provider state and handle UI
4. **Persistence** via SharedPreferences for favorites, currencies, and amounts

### Key Features Implementation

#### Exchange Rate Calculation
- Base currency is USD by default
- Supports cross-currency conversion through USD intermediary
- Real-time rate updates with error handling and retry mechanism

#### Custom Number Keyboard
- Located in `main.dart` (_buildNumberKeyboard)
- Handles digit input, decimal points, backspace
- Special keys for clear, update rates, and settings

#### Currency Selection
- Reorderable currency list
- Country flags display using `country_flags` package
- Currency replacement functionality

## Important Files & Their Roles

- `lib/main.dart`: Entry point, home screen with currency list and number keyboard
- `lib/services/exchange_rate_service.dart`: API integration for fetching exchange rates
- `lib/providers/exchange_rate_provider.dart`: Core business logic for currency conversion
- `lib/utils/currency_utils.dart`: Currency formatting and country code mapping
- `lib/screens/onboarding_screen.dart`: Initial setup flow for new users

## API Information

The app uses the Exchange Rate API (exchangerate-api.com/v4):
- Base URL: `https://api.exchangerate-api.com/v4/latest/[CURRENCY]`
- No API key required for basic usage
- Returns rates relative to the base currency

## Known Issues & Considerations

1. **Print Statements**: Debug print statements exist in production code (should be removed or use proper logging)
2. **Deprecated APIs**: Uses deprecated `withOpacity` method (should use `withValues()`)
3. **Widget Keys**: Missing keys in public widget constructors
4. **Error Handling**: The app has comprehensive error handling with retry mechanism

## Testing Approach

The app currently has minimal test coverage. When adding tests:
1. Use the existing `test/widget_test.dart` as a starting point
2. Focus on testing providers and services first
3. Mock API responses for exchange rate service tests