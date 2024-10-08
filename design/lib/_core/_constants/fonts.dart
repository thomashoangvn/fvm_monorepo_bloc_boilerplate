// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-correct-identifier-length

import 'package:flutter/material.dart';

/// The `Fonts` class provides predefined text styles that can be reused
/// throughout the application to maintain consistency in typography.
///
/// Each text style is configured with the following attributes:
/// - **color**: Text color, defaulting to a shade of gray.
/// - **fontSize**: Font size in logical pixels.
/// - **fontWeight**: The thickness of the font, ranging from normal to bold.
/// - **fontStyle**: Regular or italicized text style.
/// - **fontFamily**: Specifies the `Inter` font family for all text.

final class Fonts {
  /// Heading 1 (h1) text style.
  ///
  /// - Font Size: 24px
  /// - Font Weight: Normal
  /// - Color: Dark Gray (#494949)
  final TextStyle h1 = const TextStyle(
    color: Color(0xFF494949),
    fontSize: 24,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    fontFamily: 'Inter',
  );

  /// Heading 2 (h2) text style.
  ///
  /// - Font Size: 18px
  /// - Font Weight: Normal
  /// - Color: Dark Gray (#494949)
  final TextStyle h2 = const TextStyle(
    color: Color(0xFF494949),
    fontSize: 18,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    fontFamily: 'Inter',
  );

  /// Subtitle 1 (sub1) text style.
  ///
  /// - Font Size: 15px
  /// - Font Weight: Normal
  /// - Color: Dark Gray (#494949)
  final TextStyle sub1 = const TextStyle(
    color: Color(0xFF494949),
    fontSize: 15,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    fontFamily: 'Inter',
  );

  /// Subtitle 2 (sub2) text style.
  ///
  /// - Font Size: 14px
  /// - Font Weight: Normal
  /// - Color: Dark Gray (#494949)
  final TextStyle sub2 = const TextStyle(
    color: Color(0xFF494949),
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    fontFamily: 'Inter',
  );

  /// Body Text 1 (body1) text style.
  ///
  /// - Font Size: 13px
  /// - Font Weight: Normal
  /// - Color: Dark Gray (#494949)
  final TextStyle body1 = const TextStyle(
    color: Color(0xFF494949),
    fontSize: 13,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    fontFamily: 'Inter',
  );

  /// Body Text 2 (body2) text style.
  ///
  /// - Font Size: 11px
  /// - Font Weight: Normal
  /// - Color: Dark Gray (#494949)
  final TextStyle body2 = const TextStyle(
    color: Color(0xFF494949),
    fontSize: 11,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    fontFamily: 'Inter',
  );

  /// Button text style.
  ///
  /// - Font Size: 11px
  /// - Font Weight: Normal
  /// - Color: Dark Gray (#494949)
  final TextStyle button = const TextStyle(
    color: Color(0xFF494949),
    fontSize: 11,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    fontFamily: 'Inter',
  );

  /// Caption text style.
  ///
  /// - Font Size: 9px
  /// - Font Weight: Normal
  /// - Color: Dark Gray (#494949)
  final TextStyle caption = const TextStyle(
    color: Color(0xFF494949),
    fontSize: 9,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    fontFamily: 'Inter',
  );
}
