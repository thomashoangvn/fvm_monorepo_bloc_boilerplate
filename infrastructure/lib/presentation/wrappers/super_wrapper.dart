// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-boolean-prefixes, prefer-extracting-function-callbacks

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/back_button_interceptor.dart';
import 'package:flutter/material.dart';

/// A [SuperWrapper] is a base wrapper widget that uses the [AutoRouter]
/// for handling navigation within the app. It provides a base layout
/// with a scaffold and handles back button interception.
///
/// The wrapper uses a global scaffold and navigation key to manage the
/// routing and dialogs, ensuring that focus is dismissed when interacting
/// outside of input fields.
@RoutePage()
class SuperWrapper extends StatefulWidget {
  const SuperWrapper({super.key});

  @override
  State<SuperWrapper> createState() => _SuperHandlerState();
}

/// The state handler for the [SuperWrapper] widget.
///
/// It sets up back button interception to handle dialogs and
/// ensures proper navigation behavior.
class _SuperHandlerState extends State<SuperWrapper> {
  /// Builds the [AutoRouter] for navigation, wrapped in a [Scaffold]
  /// to use keys for global context and scaffold access.
  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      key: $.navigator.autoRouterKey,
      builder: (_, Widget child) {
        return Scaffold(
          key: $.navigator.scaffoldKey,
          backgroundColor: Colors.black,
          body: child,
          resizeToAvoidBottomInset: false,
        );
      },
      navigatorKey: $.navigator.navigatorKey,
    );
  }

  /// Adds a back button interceptor when the widget is initialized to
  /// handle back button presses, specifically intercepting if a dialog
  /// is visible and dismissing it instead of navigating back.
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add((_, __) => _shouldIntercept());
  }

  /// Removes the back button interceptor when the widget is disposed of,
  /// ensuring no memory leaks or unnecessary back button handling.
  @override
  void dispose() {
    BackButtonInterceptor.remove((_, __) => _shouldIntercept());
    super.dispose();
  }

  /// Determines whether the back button should be intercepted.
  ///
  /// If a dialog is visible, it will close the dialog and prevent the
  /// default back navigation behavior. Otherwise, it allows normal back
  /// navigation.
  ///
  /// Returns `true` if the dialog is intercepted, otherwise `false`.
  bool _shouldIntercept() {
    if ($.dialog.hasDialogVisible) {
      $.dialog.popDialog();
      return true;
    }

    return false;
  }
}
