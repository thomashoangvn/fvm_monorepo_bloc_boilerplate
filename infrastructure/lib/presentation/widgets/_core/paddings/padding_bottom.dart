// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// [PaddingBottom] is a convenience widget that applies padding only to the
/// bottom of its child. The padding sizes are predefined based on a
/// consistent design system that is accessible through the global `$.paddings`
/// object. This class offers a variety of factory constructors for common
/// padding sizes.
///
/// This ensures consistency in vertical spacing across the UI where padding
/// is applied only to the bottom of widgets.
class PaddingBottom extends StatelessWidget {
  /// Internal constructor for [PaddingBottom] that takes in a [child] and
  /// a specific [padding] value for the bottom.
  const PaddingBottom._(
      {required this.child, required this.padding, super.key});

  /// Factory constructor for applying large (lg) padding to the bottom.
  factory PaddingBottom.lg({required Widget child, Key? key}) =>
      PaddingBottom._(child: child, padding: $.paddings.lg, key: key);

  /// Factory constructor for applying medium (md) padding to the bottom.
  factory PaddingBottom.md({required Widget child, Key? key}) =>
      PaddingBottom._(child: child, padding: $.paddings.md, key: key);

  /// Factory constructor for applying small (sm) padding to the bottom.
  factory PaddingBottom.sm({required Widget child, Key? key}) =>
      PaddingBottom._(child: child, padding: $.paddings.sm, key: key);

  /// Factory constructor for applying extra-large (xl) padding to the bottom.
  factory PaddingBottom.xl({required Widget child, Key? key}) =>
      PaddingBottom._(child: child, padding: $.paddings.xl, key: key);

  /// Factory constructor for applying extra-small (xs) padding to the bottom.
  factory PaddingBottom.xs({required Widget child, Key? key}) =>
      PaddingBottom._(child: child, padding: $.paddings.xs, key: key);

  /// Factory constructor for applying extra-extra-large (xxl) padding to the bottom.
  factory PaddingBottom.xxl({required Widget child, Key? key}) =>
      PaddingBottom._(child: child, padding: $.paddings.xxl, key: key);

  /// Factory constructor for applying extra-extra-small (xxs) padding to the bottom.
  factory PaddingBottom.xxs({required Widget child, Key? key}) =>
      PaddingBottom._(child: child, padding: $.paddings.xxs, key: key);

  /// Factory constructor for applying extra-extra-extra-small (xxxs) padding to the bottom.
  factory PaddingBottom.xxxs({required Widget child, Key? key}) =>
      PaddingBottom._(child: child, padding: $.paddings.xxxs, key: key);

  /// Builds the [Padding] widget with the specified [padding] applied
  /// to the bottom of the [child] widget.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: child,
    );
  }

  /// The child widget to which the bottom padding is applied.
  final Widget child;

  /// The amount of padding to apply to the bottom side of the widget.
  final double padding;
}
