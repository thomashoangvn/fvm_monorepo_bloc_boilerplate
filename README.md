# Flutter Monorepo Bloc Boilerplate

## Getting Started

Follow these steps to set up and run the project:

### Prerequisites

- **Git** installed on your machine.
- **Dart Sdk (dart-sdk)** installed.

   ```bash
   brew install dart-sdk
   ```

- **Flutter Version Management (FVM)** installed.

   ```bash
   brew install fvm
   fvm install 3.32.2
   fvm use 3.32.2
   fvm flutter precache
   ```

   ```bash may be if need uninstall
   brew uninstall fvm
   ```

- **Melos** installed.

   ```bash
   fvm dart pub global activate melos
   ```

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/thomashoangvn/fvm_monorepo_bloc_boilerplate.git
   cd fvm_monorepo_bloc_boilerplate
   ```

2. **Set Flutter Version with FVM**

   Use FVM to switch to the required Flutter version:

   ```bash
   brew install fvm
   fvm install 3.24.3
   fvm use 3.24.3
   fvm flutter precache
   ```

3. **Install Dependencies**

   Fetch all project dependencies:

   ```bash
   fvm flutter pub get
   fvm flutter pub outdated
   fvm flutter pub upgrade
   ```

4. **Bootstrap the Project with Melos**

   Initialize the project using Melos:

   ```bash
   fvm dart pub global activate melos
   ```

   ```bash
   export PATH="$PATH":"$HOME/.pub-cache/bin"
   melos bootstrap
   ```

5. **Debug/Build the Project with vscode**

   You can find and update the Android app_name, versionName, versionCode values at productFlavors

   ```bash
   resValue "string", "app_name", "App Name"
   versionName = "1.0.0"
   versionCode = 1
   ```

   You can find and update the iOS (Production) APP_NAME, APP_VERSION, APP_BUILD_NUMBER values at xcconfig

   ```bash
   APP_NAME=APP Name
   APP_VERSION=1.0.0
   APP_BUILD_NUMBER=1
   ```

   Debug the project using vscode:

   ```bash
   cd app
   fvm flutter run lib/main.dart -d 'iPhone 16'
   or
   cd app
   fvm flutter run lib/main.dart -d 'iPhone 16'
   ```

   Debug the project using melos:

   ```bash
   melos run:uat
   or
   melos run:prod
   ```

   Build the project using melos:
   noted: copy "key.properties" file to android like same "local.properties" file

   ```bash
   melos build:ipa:uat
   melos build:apk:uat
   or
   melos build:ipa:prod
   melos build:apk:prod
   ```

## Contributing

We appreciate your interest in contributing to FMBB. Feel free to open issues or submit pull requests.

## License

This project is licensed under the [BSD-4-Clause License](LICENSE).
