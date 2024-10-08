// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: unused_import, avoid-global-state

import 'package:design/_core/_constants/assets.gen.dart';
import 'package:design/_core/_constants/colours.dart';
import 'package:design/_core/_constants/defaults.dart';
import 'package:design/_core/_constants/fonts.dart';
import 'package:design/_core/_constants/gradients.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide TextTheme;
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'theme.gen.tailor.dart';

/// The `ThemeGen` class is a customizable and extendable theme class that defines
/// various theme-related properties for the application. It leverages Flutter's
/// ThemeExtension to allow for theme configuration, custom properties, and diagnostic tools.
///
/// It uses the TailorMixin, provided by the `theme_tailor_annotation` package,
/// to automatically generate custom-tailored themes. The class contains properties
/// like colors, fonts, shadows, and gradients, all designed for easy reuse and
/// customization across the application.
@TailorMixin(themeGetter: ThemeGetter.onThemeData)
class ThemeGen extends ThemeExtension<ThemeGen>
    with DiagnosticableTreeMixin, _$ThemeGenTailorMixin {
  /// The constructor for the `ThemeGen` class. It requires all theme properties to be passed.
  const ThemeGen({
    required this.background,
    required this.surface,
    required this.onSurface,
    required this.border,
    required this.shadow,
    required this.placeholder,
    required this.gradients,
    required this.colors,
    required this.fonts,
    required this.defaults,
  });

  /// The background color used across the application.
  @override
  final Color background;

  /// The color of the surface elements, such as cards or containers.
  @override
  final Color surface;

  /// The color for text and icons on surface elements.
  @override
  final Color onSurface;

  /// The color used for borders.
  @override
  final Color border;

  /// The color used for shadows across the application.
  @override
  final Color shadow;

  /// The color used for placeholders in inputs and other elements.
  @override
  final Color placeholder;

  /// A collection of predefined linear gradients used throughout the app.
  @override
  final Gradients gradients;

  /// A collection of colors defined in the `Colours` class.
  @override
  final Colours colors;

  /// A collection of text styles defined in the `Fonts` class.
  @override
  final Fonts fonts;

  /// Default configuration for shadows and other UI elements.
  @override
  final Defaults defaults;
}
