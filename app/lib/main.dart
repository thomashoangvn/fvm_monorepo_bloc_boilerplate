// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/flutter_native_splash.dart';
import 'package:flutter/widgets.dart';

/// The entry point of the application.
///
/// This function initializes necessary services before starting the app's main logic.
///
/// The [MainBinding] class is responsible for setting up the app's core components
/// and handling the [WidgetsBinding]. The [FlutterNativeSplash.preserve] call
/// ensures that the splash screen is displayed while the asynchronous initialization completes.
void main() => MainBinding(
      mainCallback: (WidgetsBinding binding) async {
        // Keeps the native splash screen until Flutter is ready
        FlutterNativeSplash.preserve(widgetsBinding: binding);

        // TODO: Initialize other services here if needed.
      },
    );
