// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: no-equal-arguments, avoid-non-null-assertion, arguments-ordering

import 'package:design/_core/_constants/colours.dart';
import 'package:design/_core/_constants/defaults.dart';
import 'package:design/_core/_constants/fonts.dart';
import 'package:design/_core/_constants/gradients.dart';
import 'package:design/_core/_constants/theme.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The `Themes` class defines the theme configuration for the application.
/// It provides a static theme, which is customizable, and uses various
/// design constants such as colors, fonts, gradients, and other UI elements.
///
/// This class abstracts away theme configuration, making it easy to apply
/// consistent styles across the application by just referencing the predefined theme.
abstract final class Themes {
  /// The `light` theme configuration provides a light color scheme for the application.
  /// It uses the Material and Cupertino design languages, allowing the application
  /// to have a uniform appearance across platforms.
  ///
  /// Key properties include:
  /// - **cupertinoOverrideTheme**: Defines theme settings specific to Cupertino (iOS) widgets.
  /// - **extensions**: Uses `ThemeGen` to extend and include custom theme properties such as gradients, fonts, and colors.
  /// - **textSelectionTheme**: Configures the appearance of text selection, including cursor and selection colors.
  /// - **brightness**: Defines the overall brightness of the theme (light).
  /// - **scaffoldBackgroundColor**: Sets the background color for the scaffold (main application background).
  static final ThemeData light = ThemeData(
    cupertinoOverrideTheme: const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: Color(0xFF69C9FF),
      barBackgroundColor: Color(0xFFF3F5F6),
      primaryContrastingColor: Color(0xFFF3F5F6),
      scaffoldBackgroundColor: Color(0xFFF3F5F6),
    ),

    // Extend the theme with custom properties defined in ThemeGen.
    extensions: <ThemeExtension<ThemeGen>>[
      ThemeGen(
        background: const Color(0xFFF3F5F6),
        surface: const Color(0xFFFFFFFF),
        onSurface: const Color(0xFFF3F5F6),
        border: const Color(0xFFECECEC),
        shadow: const Color(0xFFDBDBDB),
        placeholder: const Color(0xFFB6B6B6),
        gradients: Gradients(),
        colors: Colours(),
        fonts: Fonts(),
        defaults: Defaults(),
      ),
    ],

    // Define the text selection theme including cursor and selection colors.
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color(0xFF69C9FF),
      selectionColor: Color(0xFF69C9FF),
      selectionHandleColor: Color(0xFF69C9FF),
    ),

    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF3F5F6),
  );
}
