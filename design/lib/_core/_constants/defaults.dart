// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/widgets.dart';

/// The `Defaults` class provides a collection of default styling properties
/// that can be used throughout the application to ensure consistency in design.
///
/// This class primarily includes a default box shadow configuration which can
/// be applied to various UI elements such as containers, cards, and buttons.
final class Defaults {
  /// Default box shadow styling for elevated UI components.
  ///
  /// - **color**: The shadow color is set to a dark gray.
  /// - **offset**: The shadow is offset slightly downwards (0, 1).
  /// - **blurRadius**: The blur radius is set to 1, giving it a subtle shadow effect.
  final List<BoxShadow> boxShadow = <BoxShadow>[
    const BoxShadow(
      color: Color.fromARGB(255, 40, 40, 41),
      offset: Offset(0, 1),
      blurRadius: 1,
    ),
  ];
}
