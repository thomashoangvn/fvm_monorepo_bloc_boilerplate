// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';

/// Configuration class that holds settings for the appearance and behavior
/// of a sheet in the UI. These settings are applied when displaying the sheet.
class SheetConfig {
  const SheetConfig({
    this.backgroundColor,
    this.clipBehavior,
    this.constraints,
    this.elevation,
    this.shape,
    this.transitionAnimationController,
    this.shouldEnableDrag = true,
  });

  /// The background color of the sheet.
  final Color? backgroundColor;

  /// Defines how the sheet content should be clipped.
  final Clip? clipBehavior;

  /// Constraints that can limit the sheet's size.
  final BoxConstraints? constraints;

  /// Elevation value, which controls the shadow cast by the sheet.
  final double? elevation;

  /// Specifies whether the sheet can be dragged to close.
  final bool shouldEnableDrag;

  /// The shape of the sheet, useful for rounding corners or other visual effects.
  final ShapeBorder? shape;

  /// An optional animation controller that can control the sheet's transition animations.
  final AnimationController? transitionAnimationController;
}
