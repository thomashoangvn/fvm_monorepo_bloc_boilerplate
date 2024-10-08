// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:flutter/material.dart';

/// Extension on `OverlayContext` to provide an easy method for displaying a loading overlay.
///
/// This extension allows you to show a loading spinner with a semi-transparent background, preventing user interaction
/// with the underlying UI while loading is in progress.
extension OverlayContextExt on OverlayContext {
  /// Displays a loading overlay that blocks user interaction.
  ///
  /// The overlay consists of:
  /// - A `ModalBarrier` that covers the entire screen with a semi-transparent background, preventing user interaction.
  /// - `CircularProgressIndicator` widget that shows a loading spinner.
  ///
  /// The `popOverlay` method is used to dismiss the overlay once the loading is complete.
  Future<void> showLoading() async {
    await pushOverlay(
      builder: (_) => Stack(
        children: <Widget>[
          ModalBarrier(
            color: Colors.black26,
            dismissible: false,
            onDismiss: popOverlay,
          ),
          const Center(
              child: CircularProgressIndicator.adaptive(strokeWidth: 10)),
        ],
      ),
    );
  }
}
