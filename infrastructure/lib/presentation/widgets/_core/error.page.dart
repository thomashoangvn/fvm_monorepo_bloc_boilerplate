// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:infrastructure/infrastructure.dart';

/// [ErrorPage] is a custom error page widget used to display detailed error information
/// when an unhandled exception occurs within the app.
///
/// This page notifies the user that something went wrong and provides the option to copy
/// the error details to the clipboard, allowing for easier sharing or debugging.
class ErrorPage extends StatelessWidget {
  /// Creates an instance of [ErrorPage].
  ///
  /// * [details]: The error details captured during a crash or failure, including
  ///   the exception and stack trace.
  const ErrorPage({required this.details, super.key});

  /// The error details to be displayed on the page.
  final FlutterErrorDetails details;

  @override
  Widget build(BuildContext context) {
    return Material(
      // Background color set from the theme.
      color: $.theme.background,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Error icon with a red color to symbolize an error.
                Icon(
                  Icons.error_outline,
                  size: 70,
                  color: $.theme.colors.red,
                ),
                // Medium gap between icon and text.
                PaddingGap.md(),
                // Main error message displayed to the user.
                Text(
                  'Oups! Something went wrong!',
                  style:
                      $.theme.fonts.h2.changeColor($.theme.colors.red).semiBold,
                ),
                PaddingGap.xxs(),
                // Descriptive text explaining the error.
                Text(
                  "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
                  style: $.theme.fonts.body1.medium,
                  textAlign: TextAlign.center,
                ),
                PaddingGap.xl(),
                // Container that holds the error details (exception string).
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    // Red background to indicate an error.
                    color: $.theme.colors.red.withOpacity(0.2),
                    borderRadius: $.radiuses.lg.borderRadius,
                  ),
                  constraints: const BoxConstraints(
                    maxHeight: 200, // Limits the height for better UX.
                  ),
                  child: Stack(
                    children: <Widget>[
                      // Scrollable view to display long error messages.
                      SingleChildScrollView(
                        child: Text(
                          details
                              .exceptionAsString(), // Displays the exception message.
                          style: $.theme.fonts.body2.medium,
                          textDirection: TextDirection
                              .ltr, // Left-to-right text direction.
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
