// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';

/// Extension on the `Color` class to add custom utility methods.
extension ColorExt on Color {
  /// Converts a color to its ARGB representation with an alpha value of 0.
  Color get toARGB => Color.fromARGB(0, red, green, blue);

  /// Converts a color to its hexadecimal string representation.
  String get toHex =>
      "#${value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  /// Blends the current color with a [blendColor] by a given percentage [percent].
  ///
  /// [percent] should be between 0 and 100.
  Color blend(Color blendColor, int percent) {
    assert(percent >= 0 && percent <= 100, 'Percent must be between 0 and 100');

    final double mixRatio = percent / 100;
    final double inverseRatio = 1 - mixRatio;

    // Blend the colors based on the given percentage.
    return Color.fromARGB(
      255,
      (red * inverseRatio + blendColor.red * mixRatio).toInt(),
      (green * inverseRatio + blendColor.green * mixRatio).toInt(),
      (blue * inverseRatio + blendColor.blue * mixRatio).toInt(),
    );
  }
}
