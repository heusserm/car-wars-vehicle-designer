# Car Wars Vehicle Designer

A cross-platform (Android + iOS) companion app for designing vehicles for
**Car Wars** (Steve Jackson Games), built with Flutter. It walks through the
vehicle construction rules from the *Car Wars Compendium, 2nd Edition* and
earlier editions — body, chassis, suspension, power plant, tires, armor and
weapons — and shows you live totals for cost, weight, available space and
performance as you build.

## Features

- **Home** — entry point with navigation to your garage and the designer.
- **My Vehicles** — list of saved vehicle designs.
- **Vehicle Detail** — read-only view of a saved design.
- **Design New Vehicle** — the core designer:
  - Body type (Subcompact through Van), chassis strength, and suspension,
    each pulled from the rulebook's price/weight/space/armor tables.
  - Electric power plants (Small–Thundercat) or gas engines with a
    configurable gas tank type and size.
  - Tires (Standard through Plasticore).
  - Six-sided armor allocation (Front/Back/Left/Right/Top/Underbody).
  - A weapons loadout builder covering the small/large-bore projectile,
    rocket, laser and flamethrower charts.
  - A live summary: total cost, spaces used vs. available, weight vs. max
    load, handling class, acceleration and top speed — computed with the
    same formulas as the tabletop rules.

Dropped weapons (gas/liquid/solid) and hand dischargers aren't in the
weapon list yet; the rest of the construction rules are implemented.

## Tech Stack

- [Flutter](https://flutter.dev) / Dart, Material 3
- No backend — saved vehicles are persisted locally on-device via
  `shared_preferences` (no account, no sync, no server)

## Prerequisites

| Tool | Purpose | Install |
|---|---|---|
| Xcode | iOS builds/simulator | Mac App Store |
| Homebrew | Package manager used for the rest | [brew.sh](https://brew.sh) |
| Flutter SDK | Build/run the app | `brew install --cask flutter` |
| CocoaPods | iOS plugin dependencies | `brew install cocoapods` |
| Android Studio + SDK | Android builds/emulator | [developer.android.com/studio](https://developer.android.com/studio) |

If any of this is already on your machine, skip ahead — `flutter doctor`
(below) will tell you what's still missing. The rest of this section is a
complete walkthrough for a **brand-new Mac with nothing installed**.

### 1. Xcode

Install Xcode from the Mac App Store (needed for iOS builds and the iOS
Simulator — this is a multi-GB download, so kick it off first and do the
rest while it installs). Once installed, accept the license and confirm the
command-line tools point at it:

```bash
sudo xcodebuild -license accept
xcode-select -p        # should print /Applications/Xcode.app/Contents/Developer
```

### 2. Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the "Next steps" it prints at the end (it usually asks you to add
Homebrew to your shell's PATH — do that before continuing).

### 3. Flutter

```bash
brew install --cask flutter
flutter --version
```

### 4. CocoaPods (iOS plugin support)

```bash
brew install cocoapods
```

### 5. Android Studio + SDK

```bash
brew install --cask android-studio
```

Launch Android Studio once so it finishes its own first-run setup (it
installs the Android SDK to `~/Library/Android/sdk` by default). Newer
Android Studio installs do **not** bundle the standalone SDK command-line
tools, which Flutter requires — install them separately:

```bash
mkdir -p ~/Library/Android/sdk/cmdline-tools
curl -o /tmp/cmdline-tools.zip -L \
  "https://dl.google.com/android/repository/commandlinetools-mac-11076708_latest.zip"
unzip -q /tmp/cmdline-tools.zip -d /tmp/cmdline-tools-extract
mv /tmp/cmdline-tools-extract/cmdline-tools ~/Library/Android/sdk/cmdline-tools/latest
rm -rf /tmp/cmdline-tools.zip /tmp/cmdline-tools-extract
```

(Check [developer.android.com/studio#command-line-tools-only](https://developer.android.com/studio#command-line-tools-only)
for the current package URL if that one 404s — Google revs the version
number periodically.)

Add the SDK to your shell profile (`~/.zshrc` or `~/.bash_profile`,
whichever your shell actually loads — run `echo $SHELL` if unsure):

```bash
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"
```

Open a new terminal (to pick up the exports), then accept the SDK
licenses:

```bash
flutter doctor --android-licenses    # answer 'y' to each
```

### 6. iOS Simulator platform

If `flutter doctor` (next step) reports something like *"iOS 26.5 is not
installed"* under Xcode, it means only the Android/watchOS simulator
runtimes shipped with your Xcode version — the iOS one is a separate,
~8+ GB download:

```bash
xcodebuild -downloadPlatform iOS
```

This can take a while depending on your connection; grab a coffee.

### 7. Verify

```bash
flutter doctor -v
```

Resolve any remaining `[!]` or `[✗]` lines — `flutter doctor` tells you
exactly what command to run for each one.

## Building & Running

Clone the repo, then fetch dependencies:

```bash
cd CarWarsVehicleDesigner
flutter pub get
```

List available targets (simulators, emulators, connected devices):

```bash
flutter devices
```

Run on any of them in debug mode (hot reload enabled):

```bash
flutter run -d <device-id>
```

### iOS Simulator

```bash
open -a Simulator                 # boot a simulator if none is running
flutter run -d "iPhone 16"        # or whatever's listed in `flutter devices`
```

### Android Emulator

```bash
$ANDROID_HOME/emulator/emulator -list-avds     # see available AVDs
$ANDROID_HOME/emulator/emulator -avd <avd-name> &
flutter run -d emulator-5554
```

## Installing on a Physical Device Without an App Store

You don't need the Play Store or App Store to try this app on your own
device — both platforms support **sideloading** a debug/dev build directly.

### Android (sideload via adb)

1. On the phone: **Settings → About phone** → tap *Build number* 7 times to
   enable Developer Options, then **Settings → Developer options** → enable
   *USB debugging*.
2. Connect the phone via USB and accept the "Allow USB debugging?" prompt.
3. Confirm it's detected:
   ```bash
   flutter devices
   ```
4. Install and run directly:
   ```bash
   flutter run -d <your-device-id>
   ```
   Or build an APK and install it manually:
   ```bash
   flutter build apk --debug
   adb install build/app/outputs/flutter-apk/app-debug.apk
   ```
   The device may warn about "unknown sources" the first time — allow it
   for this install.

### iOS (sideload via Xcode)

Apple requires every app to be code-signed, even for local development, but
you don't need a paid Apple Developer account for this — a free Apple ID
works for personal sideloading.

1. Open the iOS project in Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```
2. In Xcode, select the **Runner** target → **Signing & Capabilities**:
   - Check *Automatically manage signing*.
   - Set **Team** to your personal Apple ID (add one via Xcode → Settings →
     Accounts if it's not listed).
   - Xcode will assign a bundle identifier automatically if
     `com.xndev.carWarsVehicleDesigner` is already taken under your account;
     change it to something unique if it complains.
3. Connect your iPhone via USB (or the same Wi-Fi network with Xcode's
   wireless debugging enabled) and select it as the run destination.
4. Run from the command line (or hit ▶ in Xcode):
   ```bash
   flutter run -d <your-iphone-device-id>
   ```
5. On the phone, the first launch will fail to open with an "Untrusted
   Developer" warning. Go to **Settings → General → VPN & Device
   Management**, select your Apple ID's developer profile, and tap *Trust*.
   Relaunch the app from the home screen.

**Limitations of free-account sideloading:** the app's provisioning profile
expires after **7 days**, after which you'll need to reconnect and re-run
it from Xcode/`flutter run` to refresh it. A paid Apple Developer
Program membership ($99/year) removes the 7-day limit and raises the
device cap.

## Project Structure

```
lib/
  models/     Rulebook data tables (body types, chassis, suspension,
              power plants, tires, weapons, armor)
  services/   Vehicle stat calculator (cost/weight/space/acceleration/
              top speed formulas)
  screens/    Home, vehicle list, vehicle detail, and the designer form
```

## Development

Built by Matt Heusser with assistance from [Claude Code](https://claude.com/claude-code)
(Anthropic).

## License

Copyright © 2026 Matt Heusser

Released under the [MIT License](LICENSE).

## Fan Content Notice

This is an unofficial, free companion app and play aid for **Car Wars
Compendium, 2nd Edition** (and earlier editions of *Car Wars*), published by
Steve Jackson Games. It is fan-made, non-commercial, and distributed free of
charge in accordance with Steve Jackson Games' online policy for fan-created
materials. It is not produced, sponsored, endorsed, or affiliated with Steve
Jackson Games.

*Car Wars* and *Car Wars Compendium* are trademarks of Steve Jackson Games
Incorporated. For the official game, rules, and more information, visit
[carwars.sjgames.com](https://carwars.sjgames.com/).
