// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/cupertino.dart';
import 'package:infrastructure/presentation/contexts/navigator_context.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// [OverlayContext] is a utility class designed to manage overlay widgets in
/// a Flutter application. It allows you to insert or remove widgets from the
/// application's overlay stack, which is useful for creating floating widgets
/// like toasts, popups, or loading indicators.
///
/// This class works in conjunction with the [NavigatorContext] to get access
/// to the current [BuildContext] required for interacting with the [Overlay].

final class OverlayContext {
  OverlayContext();

  /// The current [OverlayEntry] used to display the widget in the overlay.
  OverlayEntry? _overlayEntry;

  /// Inserts a new overlay into the overlay stack using the provided [builder].
  ///
  /// The [builder] is used to create the widget that will be displayed in the
  /// overlay. If there is already an active overlay, this method does nothing.
  ///
  /// This method uses [WidgetsBinding.instance.addPostFrameCallback] to ensure
  /// the overlay is inserted after the current frame is completed.
  Future<void> pushOverlay({required WidgetBuilder builder}) async {
    final BuildContext context = await $.navigator.ensuredContext;

    if (context.mounted) {
      if (_overlayEntry != null) {
        return;
      }

      final OverlayState overlayState = Overlay.of(context);
      _overlayEntry = OverlayEntry(builder: builder);
      overlayState.insert(_overlayEntry!);
    }

    return;
  }

  /// Removes the current overlay entry from the overlay stack.
  ///
  /// If no overlay is active, this method does nothing. Once the overlay is
  /// removed, the reference to the [OverlayEntry] is set to `null`.
  Future<void> popOverlay() async {
    final BuildContext context = await $.navigator.ensuredContext;

    if (context.mounted) {
      if (_overlayEntry == null) {
        return;
      }

      _overlayEntry!.remove();
      _overlayEntry = null;
    }

    return;
  }
}
