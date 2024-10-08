// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// [PaddingAll] is a convenience widget that applies padding of different
/// sizes around its child. The padding sizes are predefined based on a
/// consistent design system that is accessible through the global `$.paddings`
/// object. This class offers a variety of factory constructors for common
/// padding sizes.
///
/// This helps maintain consistency in spacing throughout the UI.
class PaddingAll extends StatelessWidget {
  /// The internal constructor that takes in a [child] and a [padding] value.
  /// This is used by the factory constructors to build a [PaddingAll] instance.
  const PaddingAll._({required this.child, required this.padding, super.key});

  /// Factory constructor that creates a [PaddingAll] widget with large (lg) padding.
  factory PaddingAll.lg({required Widget child, Key? key}) =>
      PaddingAll._(child: child, padding: $.paddings.lg, key: key);

  /// Factory constructor that creates a [PaddingAll] widget with medium (md) padding.
  factory PaddingAll.md({required Widget child, Key? key}) =>
      PaddingAll._(child: child, padding: $.paddings.md, key: key);

  /// Factory constructor that creates a [PaddingAll] widget with small (sm) padding.
  factory PaddingAll.sm({required Widget child, Key? key}) =>
      PaddingAll._(child: child, padding: $.paddings.sm, key: key);

  /// Factory constructor that creates a [PaddingAll] widget with extra-large (xl) padding.
  factory PaddingAll.xl({required Widget child, Key? key}) =>
      PaddingAll._(child: child, padding: $.paddings.xl, key: key);

  /// Factory constructor that creates a [PaddingAll] widget with extra-small (xs) padding.
  factory PaddingAll.xs({required Widget child, Key? key}) =>
      PaddingAll._(child: child, padding: $.paddings.xs, key: key);

  /// Factory constructor that creates a [PaddingAll] widget with extra-extra-large (xxl) padding.
  factory PaddingAll.xxl({required Widget child, Key? key}) =>
      PaddingAll._(child: child, padding: $.paddings.xxl, key: key);

  /// Factory constructor that creates a [PaddingAll] widget with extra-extra-small (xxs) padding.
  factory PaddingAll.xxs({required Widget child, Key? key}) =>
      PaddingAll._(child: child, padding: $.paddings.xxs, key: key);

  /// Factory constructor that creates a [PaddingAll] widget with extra-extra-extra-small (xxxs) padding.
  factory PaddingAll.xxxs({required Widget child, Key? key}) =>
      PaddingAll._(child: child, padding: $.paddings.xxxs, key: key);

  /// Builds the [Padding] widget with the specified [padding] applied
  /// equally to all sides of the [child] widget.
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(padding), child: child);
  }

  /// The child widget to which the padding is applied.
  final Widget child;

  /// The amount of padding to apply on all sides.
  final double padding;
}
