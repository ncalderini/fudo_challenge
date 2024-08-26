## Fudo Challenge

This is a Flutter project that you can open, run, and test on your local machine.

### Prerequisites

Before getting started, make sure you have the following installed:

- Flutter SDK
- Dart SDK
- Android Studio (for Android)
- Xcode (for iOS)

### Getting Started

1. Clone this repository to your local machine:

    ```
    git clone https://github.com/ncalderini/fudo_challenge.git
    ```

2. Open the project in your preferred IDE or text editor.

3. Install the project dependencies by running the following command in the project directory:

    ```
    flutter pub get
    ```

### Running the App

To run the app on your connected device or emulator, use the following command:

```
flutter run
```

### Installing an APK File on Android

To install an APK file on your Android device, follow these steps:

1. Enable installation from unknown sources:
    - Open the **Settings** app on your Android device.
    - Navigate to **Security** or **Privacy** settings.
    - Enable the **Unknown sources** option. This allows you to install apps from sources other than the Google Play Store.

2. Transfer the APK file to your Android device:
    - Connect your Android device to your computer using a USB cable.
    - Download APK from https://t.ly/Sa1Rl
    - On your computer, locate the APK file you want to install.
    - Copy the APK file to your Android device's internal storage or SD card.

3. Install the APK file:
    - On your Android device, open a file manager app.
    - Navigate to the location where you copied the APK file.
    - Tap on the APK file to start the installation process.
    - Follow the on-screen instructions to complete the installation.

### Installing an APK File using ADB

To install an APK file on your Android device using ADB (Android Debug Bridge), follow these steps:

1. Connect your Android device to your computer using a USB cable.

2. Download APK from https://t.ly/Sa1Rl

3. Open a command prompt or terminal window on your computer.

4. Install the APK file by running the following command:

    ```
    adb install [path_to_apk]/fudo_challenge.apk
    ```

### Running Tests

To run the tests for this project, use the following command:

```
flutter test
```
