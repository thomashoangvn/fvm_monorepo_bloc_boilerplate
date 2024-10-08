// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:flutter/cupertino.dart';

/// Extension on `ToastContext` for displaying alerts based on `Failure` objects.
///
/// This extension provides an asynchronous method for showing alerts depending on the type of failure,
/// either constructive (e.g., success messages) or error-based alerts. It leverages toast notifications to provide
/// feedback to the user based on the failure type.
extension ToastContextExt on ToastContext {
  /// Asynchronously displays an alert based on the `Failure` type using the toast system.
  ///
  /// This method first removes any existing overlays, then checks the `Failure` type. If the failure
  /// type is [FailureTypeEnum.empty], no alert will be shown. Otherwise, it displays a toast
  /// with a colored [Container] and the failure message.
  ///
  /// Example usage:
  /// ```dart
  /// final Failure failure = Failure(type: FailureTypeEnum.error, message: 'An error occurred');
  /// await $.toast.showAlert(failure);
  /// ```
  ///
  /// - [failure]: The failure object containing the failure type and message.
  Future<void> showAlert(
    Failure failure, {
    bool shouldAutoDismissModal = false,
  }) async {
    // Remove any existing overlay before showing a new alert.
    await $.overlay.popOverlay();

    // Remove any existing modal before showing a new alert.
    if (shouldAutoDismissModal) {
      await $.dialog.popDialog();
    }

    // If the failure type is empty, do nothing.
    if (failure.type == FailureTypeEnum.empty) {
      return;
    }

    // Create a widget based on the failure type. Success is green, and errors are red.
    final Widget child = switch (failure.type) {
      // Constructive (e.g., success) alerts show a green background.
      FailureTypeEnum.constructive => Container(
          height: 50,
          color: const Color(0xFF40DBA3),
          child: failure.message.text(),
        ),
      // Error alerts show a red background.
      _ => Container(
          height: 50,
          color: const Color(0xFFE4756D),
          child: failure.message.text(),
        ),
    };

    // Display the alert as a toast with the generated widget.
    await $.toast.pushWidgetToast(child: child);
  }
}
