// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-correct-identifier-length

import 'package:flutter/material.dart';

/// The [Paddings] class provides a set of predefined padding values for consistent
/// spacing throughout the UI. This immutable class can be used to ensure uniformity
/// in padding across different parts of the app.
@immutable
final class Paddings {
  /// Extra extra extra small padding: 2 pixels.
  final double xxxs = 2;

  /// Extra extra small padding: 4 pixels.
  final double xxs = 4;

  /// Extra small padding: 8 pixels.
  final double xs = 8;

  /// Small padding: 12 pixels.
  final double sm = 12;

  /// Medium padding: 16 pixels.
  final double md = 16;

  /// Large padding: 24 pixels.
  final double lg = 24;

  /// Extra large padding: 32 pixels.
  final double xl = 32;

  /// Extra extra large padding: 40 pixels.
  final double xxl = 40;
}
