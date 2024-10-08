// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// [PaddingTop] applies padding to the top of its child widget, using predefined padding sizes.
/// This widget simplifies applying consistent top spacing across various parts of the app.
class PaddingTop extends StatelessWidget {
  /// Constructs a [PaddingTop] widget with custom top padding.
  const PaddingTop._({required this.child, required this.padding, super.key});

  /// Factory constructor for applying large padding (lg) to the top of the child.
  factory PaddingTop.lg({required Widget child, Key? key}) =>
      PaddingTop._(child: child, padding: $.paddings.lg, key: key);

  /// Factory constructor for applying medium padding (md) to the top of the child.
  factory PaddingTop.md({required Widget child, Key? key}) =>
      PaddingTop._(child: child, padding: $.paddings.md, key: key);

  /// Factory constructor for applying small padding (sm) to the top of the child.
  factory PaddingTop.sm({required Widget child, Key? key}) =>
      PaddingTop._(child: child, padding: $.paddings.sm, key: key);

  /// Factory constructor for applying extra-large padding (xl) to the top of the child.
  factory PaddingTop.xl({required Widget child, Key? key}) =>
      PaddingTop._(child: child, padding: $.paddings.xl, key: key);

  /// Factory constructor for applying extra-small padding (xs) to the top of the child.
  factory PaddingTop.xs({required Widget child, Key? key}) =>
      PaddingTop._(child: child, padding: $.paddings.xs, key: key);

  /// Factory constructor for applying extra-extra-large padding (xxl) to the top of the child.
  factory PaddingTop.xxl({required Widget child, Key? key}) =>
      PaddingTop._(child: child, padding: $.paddings.xxl, key: key);

  /// Factory constructor for applying extra-extra-small padding (xxs) to the top of the child.
  factory PaddingTop.xxs({required Widget child, Key? key}) =>
      PaddingTop._(child: child, padding: $.paddings.xxs, key: key);

  /// Factory constructor for applying extra-extra-extra-small padding (xxxs) to the top of the child.
  factory PaddingTop.xxxs({required Widget child, Key? key}) =>
      PaddingTop._(child: child, padding: $.paddings.xxxs, key: key);

  /// Builds the [PaddingTop] widget by applying top padding to its child.
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: padding), child: child);
  }

  /// The widget to which top padding is applied.
  final Widget child;

  /// The amount of padding to be applied to the top, fetched from predefined design system values.
  final double padding;
}
