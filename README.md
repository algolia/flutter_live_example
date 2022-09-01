# Algolia Helpers for Flutter Playground

1. Install [flutter](https://docs.flutter.dev/get-started/install)
2. Clone the project
3. Run an emulator (Android/iOS) and/or get the list of available devices
```shell
flutter devices
```
4. You will get the list of devices, example:
```shell
sdk gphone64 x86 64 (mobile) • emulator-5554 • android-x64    • Android 13 (API 33) (emulator)
macOS (desktop)              • macos         • darwin-x64     • macOS 12.5.1 21G83 darwin-x64
Chrome (web)                 • chrome        • web-javascript • Google Chrome 104.0.5112.101
```
5. Run the Flutter app using a device id (second column above), for example:
```shell
# for Android
flutter run -d emulator-5554
# For web
flutter run -d chrome
# For macos
flutter run -d macos
```
To run with maximum performance, add `--release` flag, example:
```shell
flutter run -d macos --release
```
