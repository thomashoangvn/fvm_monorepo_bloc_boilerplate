// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-correct-callback-field-name

import 'package:flutter/material.dart';

/// The `Gradients` class provides a collection of predefined linear gradients
/// for consistent use of gradient styles across the application.
///
/// Each gradient has two colors with a top-to-bottom alignment (vertical gradient).
/// The available gradients include various shades of grey, red, green, and blue.

final class Gradients {
  /// Semi-transparent grey gradient from light grey to slightly darker grey.
  static const LinearGradient kSemiGrey = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFFE2E4E5), Color(0xFFECEEEE)],
  );

  /// Dark grey gradient from a darker grey to a slightly lighter shade.
  static const LinearGradient kGrey = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFF494949), Color(0xFF5D5D5D)],
  );

  /// Semi-transparent red gradient transitioning from light red to a soft peach.
  static const LinearGradient kSemiRed = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFFFBDDDD), Color(0xFFFAE0DA)],
  );

  /// Bright red gradient transitioning from a bold red to a lighter red.
  static const LinearGradient kRed = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFFED6E76), Color(0xFFEC816A)],
  );

  /// Semi-transparent green gradient transitioning from a light green to a soft teal.
  static const LinearGradient kSemiGreen = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFFCFF6E8), Color(0xFFD4F7EB)],
  );

  /// Bright green gradient transitioning from a bold green to a lighter green.
  static const LinearGradient kGreen = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFF40DBA3), Color(0xFF54DFAD)],
  );

  /// Semi-transparent blue gradient transitioning from light blue to a soft sky blue.
  static const LinearGradient kSemiBlue = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFFDAF2FF), Color(0xFFDDF3FF)],
  );

  /// Bright blue gradient transitioning from a bold blue to a lighter blue.
  static const LinearGradient kBlue = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFF69C9FF), Color(0xFF78CFFF)],
  );

  /// Getter for the semi-transparent grey gradient.
  LinearGradient get semiGrey => Gradients.kSemiGrey;

  /// Getter for the dark grey gradient.
  LinearGradient get grey => Gradients.kGrey;

  /// Getter for the semi-transparent red gradient.
  LinearGradient get semiRed => Gradients.kSemiRed;

  /// Getter for the bright red gradient.
  LinearGradient get red => Gradients.kRed;

  /// Getter for the semi-transparent green gradient.
  LinearGradient get semiGreen => Gradients.kSemiGreen;

  /// Getter for the bright green gradient.
  LinearGradient get green => Gradients.kGreen;

  /// Getter for the semi-transparent blue gradient.
  LinearGradient get semiBlue => Gradients.kSemiBlue;

  /// Getter for the bright blue gradient.
  LinearGradient get blue => Gradients.kBlue;
}
