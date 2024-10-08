// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// [PaddingRight] is a widget that adds padding to the right side of its child.
/// This widget provides predefined padding sizes from the design system, making it easier to ensure consistent spacing.
class PaddingRight extends StatelessWidget {
  /// Constructs a [PaddingRight] widget with custom padding for the right side.
  const PaddingRight._({required this.child, required this.padding, super.key});

  /// Factory constructor for creating a large right padding.
  factory PaddingRight.lg({required Widget child, Key? key}) =>
      PaddingRight._(child: child, padding: $.paddings.lg, key: key);

  /// Factory constructor for creating a medium right padding.
  factory PaddingRight.md({required Widget child, Key? key}) =>
      PaddingRight._(child: child, padding: $.paddings.md, key: key);

  /// Factory constructor for creating a small right padding.
  factory PaddingRight.sm({required Widget child, Key? key}) =>
      PaddingRight._(child: child, padding: $.paddings.sm, key: key);

  /// Factory constructor for creating an extra-large right padding.
  factory PaddingRight.xl({required Widget child, Key? key}) =>
      PaddingRight._(child: child, padding: $.paddings.xl, key: key);

  /// Factory constructor for creating an extra-small right padding.
  factory PaddingRight.xs({required Widget child, Key? key}) =>
      PaddingRight._(child: child, padding: $.paddings.xs, key: key);

  /// Factory constructor for creating an extra-extra-large right padding.
  factory PaddingRight.xxl({required Widget child, Key? key}) =>
      PaddingRight._(child: child, padding: $.paddings.xxl, key: key);

  /// Factory constructor for creating an extra-extra-small right padding.
  factory PaddingRight.xxs({required Widget child, Key? key}) =>
      PaddingRight._(child: child, padding: $.paddings.xxs, key: key);

  /// Factory constructor for creating an extra-extra-extra-small right padding.
  factory PaddingRight.xxxs({required Widget child, Key? key}) =>
      PaddingRight._(child: child, padding: $.paddings.xxxs, key: key);

  /// Builds the [PaddingRight] widget by applying right padding to its child.
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(right: padding), child: child);
  }

  /// The widget to which the padding is applied.
  final Widget child;

  /// The amount of padding to be applied to the right side, fetched from predefined values.
  final double padding;
}
