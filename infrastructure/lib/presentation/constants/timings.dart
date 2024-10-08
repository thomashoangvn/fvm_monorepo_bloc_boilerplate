// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';

/// The [Timings] class defines a set of predefined [Duration] values used
/// throughout the app for animations, delays, and transitions. These constants
/// allow for consistent timing across different UI components.
///
/// Example usage:
/// ```dart
/// Future.delayed($.timings.mil200, () {
///   // Execute some delayed action after 200 milliseconds
/// });
/// ```

@immutable
final class Timings {
  /// A duration of zero, commonly used for immediate actions.
  final Duration zero = Duration.zero;

  /// A short duration of 50 milliseconds, often used for quick transitions or animations.
  final Duration mil050 = const Duration(milliseconds: 50);

  /// A duration of 100 milliseconds, suitable for fast animations.
  final Duration mil100 = const Duration(milliseconds: 100);

  /// A duration of 200 milliseconds, commonly used for moderate animations or small delays.
  final Duration mil200 = const Duration(milliseconds: 200);

  /// A duration of 400 milliseconds, appropriate for standard UI animations.
  final Duration mil400 = const Duration(milliseconds: 400);

  /// A duration of 600 milliseconds, typically used for slightly longer animations.
  final Duration mil600 = const Duration(milliseconds: 600);

  /// A duration of 800 milliseconds, used for extended animations or transitions.
  final Duration mil800 = const Duration(milliseconds: 800);

  /// A duration of 1 second, typically used for noticeable delays or extended animations.
  final Duration sec = const Duration(seconds: 1);

  /// A duration of 2 seconds, generally used for significant pauses or longer animations.
  final Duration sec2 = const Duration(seconds: 2);
}
