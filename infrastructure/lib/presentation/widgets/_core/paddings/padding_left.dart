// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// [PaddingLeft] is a widget that applies padding to the left side
/// of its child based on predefined padding values from the design system.
///
/// This widget helps maintain consistent spacing on the left side of
/// widgets, allowing for quick usage of standard padding values such as `xs`, `md`, `lg`, etc.
class PaddingLeft extends StatelessWidget {
  /// Constructs a [PaddingLeft] widget with a specified padding value.
  const PaddingLeft._({required this.child, required this.padding, super.key});

  /// Factory constructor for creating a left padding of large size.
  factory PaddingLeft.lg({required Widget child, Key? key}) =>
      PaddingLeft._(child: child, padding: $.paddings.lg, key: key);

  /// Factory constructor for creating a left padding of medium size.
  factory PaddingLeft.md({required Widget child, Key? key}) =>
      PaddingLeft._(child: child, padding: $.paddings.md, key: key);

  /// Factory constructor for creating a left padding of small size.
  factory PaddingLeft.sm({required Widget child, Key? key}) =>
      PaddingLeft._(child: child, padding: $.paddings.sm, key: key);

  /// Factory constructor for creating a left padding of extra-large size.
  factory PaddingLeft.xl({required Widget child, Key? key}) =>
      PaddingLeft._(child: child, padding: $.paddings.xl, key: key);

  /// Factory constructor for creating a left padding of extra-small size.
  factory PaddingLeft.xs({required Widget child, Key? key}) =>
      PaddingLeft._(child: child, padding: $.paddings.xs, key: key);

  /// Factory constructor for creating a left padding of extra-extra-large size.
  factory PaddingLeft.xxl({required Widget child, Key? key}) =>
      PaddingLeft._(child: child, padding: $.paddings.xxl, key: key);

  /// Factory constructor for creating a left padding of extra-extra-small size.
  factory PaddingLeft.xxs({required Widget child, Key? key}) =>
      PaddingLeft._(child: child, padding: $.paddings.xxs, key: key);

  /// Factory constructor for creating a left padding of extra-extra-extra-small size.
  factory PaddingLeft.xxxs({required Widget child, Key? key}) =>
      PaddingLeft._(child: child, padding: $.paddings.xxxs, key: key);

  /// Builds the [PaddingLeft] widget with the specified left padding applied.
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: padding), child: child);
  }

  /// The widget that will have the left padding applied to it.
  final Widget child;

  /// The amount of padding to be applied on the left side, coming from the design system.
  final double padding;
}
