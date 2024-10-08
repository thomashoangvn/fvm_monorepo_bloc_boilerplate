// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// The [Radiuses] class defines a set of predefined border radius values that
/// can be used throughout the app to ensure consistent corner rounding. Each
/// radius value corresponds to a specific size ranging from no radius (`none`)
/// to extra-large radius (`xxl`).
///
/// Example usage:
/// ```dart
/// BorderRadius.circular($.radiuses.md);
/// ```

@immutable
final class Radiuses {
  /// No border radius.
  final double none = 0;

  /// Extra small border radius, typically used for minimal rounding.
  final double xs = 4;

  /// Small border radius, commonly used for slightly rounded corners.
  final double sm = 8;

  /// Medium border radius, offering moderate rounding.
  final double md = 12;

  /// Large border radius, providing more noticeable rounding for elements.
  final double lg = 16;

  /// Extra large border radius, used for highly rounded corners.
  final double xl = 20;

  /// Double extra large border radius, the largest available, used for highly rounded elements.
  final double xxl = 24;
}
