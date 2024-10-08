// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-boolean-prefixes

import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// [PaddingSymmetric] applies symmetric padding (both vertical and/or horizontal) to its child.
/// This widget simplifies adding uniform spacing to the child widget, based on pre-configured design system paddings.
class PaddingSymmetric extends StatelessWidget {
  /// Constructs a [PaddingSymmetric] widget with custom symmetric padding.
  const PaddingSymmetric._({
    required this.child,
    required this.horizontal,
    required this.padding,
    required this.vertical,
    super.key,
  });

  /// Factory constructor for adding large symmetric padding (lg) around the child.
  factory PaddingSymmetric.lg({
    required Widget child,
    Key? key,
    bool horizontal = false,
    bool vertical = false,
  }) =>
      PaddingSymmetric._(
        child: child,
        horizontal: horizontal,
        padding: $.paddings.lg,
        vertical: vertical,
        key: key,
      );

  /// Factory constructor for adding medium symmetric padding (md) around the child.
  factory PaddingSymmetric.md({
    required Widget child,
    Key? key,
    bool horizontal = false,
    bool vertical = false,
  }) =>
      PaddingSymmetric._(
        child: child,
        horizontal: horizontal,
        padding: $.paddings.md,
        vertical: vertical,
        key: key,
      );

  /// Factory constructor for adding small symmetric padding (sm) around the child.
  factory PaddingSymmetric.sm({
    required Widget child,
    Key? key,
    bool horizontal = false,
    bool vertical = false,
  }) =>
      PaddingSymmetric._(
        child: child,
        horizontal: horizontal,
        padding: $.paddings.sm,
        vertical: vertical,
        key: key,
      );

  /// Factory constructor for adding extra-large symmetric padding (xl) around the child.
  factory PaddingSymmetric.xl({
    required Widget child,
    Key? key,
    bool horizontal = false,
    bool vertical = false,
  }) =>
      PaddingSymmetric._(
        child: child,
        horizontal: horizontal,
        padding: $.paddings.xl,
        vertical: vertical,
        key: key,
      );

  /// Factory constructor for adding extra-small symmetric padding (xs) around the child.
  factory PaddingSymmetric.xs({
    required Widget child,
    Key? key,
    bool horizontal = false,
    bool vertical = false,
  }) =>
      PaddingSymmetric._(
        child: child,
        horizontal: horizontal,
        padding: $.paddings.xs,
        vertical: vertical,
        key: key,
      );

  /// Factory constructor for adding extra-extra-large symmetric padding (xxl) around the child.
  factory PaddingSymmetric.xxl({
    required Widget child,
    Key? key,
    bool horizontal = false,
    bool vertical = false,
  }) =>
      PaddingSymmetric._(
        child: child,
        horizontal: horizontal,
        padding: $.paddings.xxl,
        vertical: vertical,
        key: key,
      );

  /// Factory constructor for adding extra-extra-small symmetric padding (xxs) around the child.
  factory PaddingSymmetric.xxs({
    required Widget child,
    Key? key,
    bool horizontal = false,
    bool vertical = false,
  }) =>
      PaddingSymmetric._(
        child: child,
        horizontal: horizontal,
        padding: $.paddings.xxs,
        vertical: vertical,
        key: key,
      );

  /// Factory constructor for adding extra-extra-extra-small symmetric padding (xxxs) around the child.
  factory PaddingSymmetric.xxxs({
    required Widget child,
    Key? key,
    bool horizontal = false,
    bool vertical = false,
  }) =>
      PaddingSymmetric._(
        child: child,
        horizontal: horizontal,
        padding: $.paddings.xxxs,
        vertical: vertical,
        key: key,
      );

  /// Builds the [PaddingSymmetric] widget by applying symmetric padding to the child widget.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vertical ? padding : 0,
        horizontal: horizontal ? padding : 0,
      ),
      child: child,
    );
  }

  /// The widget to which symmetric padding is applied.
  final Widget child;

  /// Flag to indicate if padding should be applied horizontally.
  final bool horizontal;

  /// The padding value fetched from the design system's predefined padding sizes.
  final double padding;

  /// Flag to indicate if padding should be applied vertically.
  final bool vertical;
}
