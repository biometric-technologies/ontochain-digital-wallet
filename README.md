# Ingress Credit Wallet

User mobile application to store credentials and fetch loan information

## Getting Started

### Pre-requirements

* [Dart/Flutter 3.0+](https://docs.flutter.dev/get-started/install/windows)
* [Android SDK](https://developer.android.com/studio)
* [IOS SDK](https://developer.apple.com/ios/)

### Build

1. Download dependencies: `flutter packages pub get`
2. Update `lib/constants.dart` file with biometric and credit bureaus API urls
   ```
    BIOMETRIC_BUREAU_URL =...
    CREDIT_BUREAU_URL =...
   ```
3. Build debug apk:  `flutter build apk --debug`
4. Build and sign:

* [Android](https://docs.flutter.dev/deployment/android)
* [IOS](https://docs.flutter.dev/deployment/ios)

