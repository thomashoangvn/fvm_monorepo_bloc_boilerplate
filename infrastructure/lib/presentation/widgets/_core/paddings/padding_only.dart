// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-boolean-prefixes

import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// [PaddingOnly] is a flexible widget that applies padding to specific edges
/// of its child widget based on provided boolean flags for each edge (left, right, top, bottom).
/// The padding value is derived from predefined padding sizes from the design system.
class PaddingOnly extends StatelessWidget {
  /// Constructs a [PaddingOnly] widget with custom padding for each side (left, right, top, bottom).
  const PaddingOnly._({
    required this.bottom,
    required this.child,
    required this.left,
    required this.padding,
    required this.right,
    required this.top,
    super.key,
  });

  /// Factory constructor for creating a large padding.
  factory PaddingOnly.lg({
    required Widget child,
    Key? key,
    bool bottom = false,
    bool left = false,
    bool right = false,
    bool top = false,
  }) =>
      PaddingOnly._(
        bottom: bottom,
        child: child,
        left: left,
        padding: $.paddings.lg,
        right: right,
        top: top,
        key: key,
      );

  /// Factory constructor for creating a medium padding.
  factory PaddingOnly.md({
    required Widget child,
    Key? key,
    bool bottom = false,
    bool left = false,
    bool right = false,
    bool top = false,
  }) =>
      PaddingOnly._(
        bottom: bottom,
        child: child,
        left: left,
        padding: $.paddings.md,
        right: right,
        top: top,
        key: key,
      );

  /// Factory constructor for creating a small padding.
  factory PaddingOnly.sm({
    required Widget child,
    Key? key,
    bool bottom = false,
    bool left = false,
    bool right = false,
    bool top = false,
  }) =>
      PaddingOnly._(
        bottom: bottom,
        child: child,
        left: left,
        padding: $.paddings.sm,
        right: right,
        top: top,
        key: key,
      );

  /// Factory constructor for creating an extra-large padding.
  factory PaddingOnly.xl({
    required Widget child,
    Key? key,
    bool bottom = false,
    bool left = false,
    bool right = false,
    bool top = false,
  }) =>
      PaddingOnly._(
        bottom: bottom,
        child: child,
        left: left,
        padding: $.paddings.xl,
        right: right,
        top: top,
        key: key,
      );

  /// Factory constructor for creating an extra-small padding.
  factory PaddingOnly.xs({
    required Widget child,
    Key? key,
    bool bottom = false,
    bool left = false,
    bool right = false,
    bool top = false,
  }) =>
      PaddingOnly._(
        bottom: bottom,
        child: child,
        left: left,
        padding: $.paddings.xs,
        right: right,
        top: top,
        key: key,
      );

  /// Factory constructor for creating an extra-extra-small padding.
  factory PaddingOnly.xxxs({
    required Widget child,
    Key? key,
    bool bottom = false,
    bool left = false,
    bool right = false,
    bool top = false,
  }) =>
      PaddingOnly._(
        bottom: bottom,
        child: child,
        left: left,
        padding: $.paddings.xxxs,
        right: right,
        top: top,
        key: key,
      );

  /// Factory constructor for creating an extra-extra-large padding.
  factory PaddingOnly.xxl({
    required Widget child,
    Key? key,
    bool bottom = false,
    bool left = false,
    bool right = false,
    bool top = false,
  }) =>
      PaddingOnly._(
        bottom: bottom,
        child: child,
        left: left,
        padding: $.paddings.xxl,
        right: right,
        top: top,
        key: key,
      );

  /// Factory constructor for creating an extra-extra-small padding.
  factory PaddingOnly.xxs({
    required Widget child,
    Key? key,
    bool bottom = false,
    bool left = false,
    bool right = false,
    bool top = false,
  }) =>
      PaddingOnly._(
        bottom: bottom,
        child: child,
        left: left,
        padding: $.paddings.xxs,
        right: right,
        top: top,
        key: key,
      );

  /// Builds the [PaddingOnly] widget by applying padding to the specified edges of its child.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        left ? padding : 0,
        top ? padding : 0,
        right ? padding : 0,
        bottom ? padding : 0,
      ),
      child: child,
    );
  }

  /// A boolean that determines whether padding is applied to the bottom edge.
  final bool bottom;

  /// The widget to which padding is applied.
  final Widget child;

  /// A boolean that determines whether padding is applied to the left edge.
  final bool left;

  /// The amount of padding to be applied, which is fetched from the predefined design system padding values.
  final double padding;

  /// A boolean that determines whether padding is applied to the right edge.
  final bool right;

  /// A boolean that determines whether padding is applied to the top edge.
  final bool top;
}
