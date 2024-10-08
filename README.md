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
   fvm install 3.24.3
   fvm use 3.24.3
   ```

3. **Install Dependencies**

   Fetch all project dependencies:

   ```bash
   fvm flutter pub get
   ```

4. **Bootstrap the Project with Melos**

   Initialize the project using Melos:

   ```bash
   fvm dart pub global activate melos
   ```

   ```bash
   melos bootstrap
   ```

## Contributing

We appreciate your interest in contributing to FMBB. Feel free to open issues or submit pull requests.

## License

This project is licensed under the [BSD-4-Clause License](LICENSE).
