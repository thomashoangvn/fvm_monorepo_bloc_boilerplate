// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-correct-callback-field-name

import 'package:flutter/material.dart';

/// The `Colours` class provides a centralized collection of static color constants
/// and getters that define the primary and accent color palette used across the
/// application. These colors are consistent and reusable to ensure uniform design
/// language across the app's UI components.
final class Colours {
  /// Pure white color, used typically for backgrounds and text.
  static const Color kWhite = Color(0xFFFFFFFF);

  /// Semi-grey color, a light grey used for subtle UI elements like borders.
  static const Color kSemiGrey = Color(0xFFE2E4E5);

  /// Half-grey color, a medium grey used for text or inactive UI elements.
  static const Color kHalfGrey = Color(0xFF929292);

  /// Full grey color, a darker grey suitable for primary text or more prominent elements.
  static const Color kGrey = Color(0xFF494949);

  /// Light blue color, used for softer accent elements in the UI.
  static const Color kSemiBlue = Color(0xFFDBEEF9);

  /// Bright blue color, often used for primary buttons and interactive elements.
  static const Color kBlue = Color(0xFF69C9FF);

  /// Light red color, used for background elements indicating warnings or errors.
  static const Color kSemiRed = Color(0xFFEFD5D4);

  /// Bright red color, commonly used for errors or alert messages.
  static const Color kRed = Color(0xFFED7870);

  /// Bright green color, suitable for success messages or confirmation buttons.
  static const Color kGreen = Color(0xFF40DBA3);

  /// Light green color, used for softer success indicators.
  static const Color kSemiGreen = Color(0xFFC6EFE1);

  /// Getter for white color.
  Color get white => kWhite;

  /// Getter for semi-grey color.
  Color get semiGrey => kSemiGrey;

  /// Getter for half-grey color.
  Color get halfGrey => kHalfGrey;

  /// Getter for grey color.
  Color get grey => kGrey;

  /// Getter for semi-blue color.
  Color get semiBlue => kSemiBlue;

  /// Getter for blue color.
  Color get blue => kBlue;

  /// Getter for semi-red color.
  Color get semiRed => kSemiRed;

  /// Getter for red color.
  Color get red => kRed;

  /// Getter for green color.
  Color get green => kGreen;

  /// Getter for semi-green color.
  Color get semiGreen => kSemiGreen;
}
