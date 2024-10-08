// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:flutter/material.dart';

/// Extension on `TextStyle` to simplify applying predefined theme colors to text styles.
///
/// This extension allows easy customization of text color using predefined theme colors, making it easier to manage
/// consistent color usage across the app.
extension ThemeTextStyleExt on TextStyle {
  /// Applies the white color from the theme to the text style.
  ///
  /// Example:
  /// ```dart
  /// TextStyle().white; // Returns a TextStyle with the color set to white.
  /// ```
  TextStyle get white => copyWith(color: $.theme.colors.white);
}
