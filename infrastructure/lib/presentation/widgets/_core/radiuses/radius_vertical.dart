// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: no-equal-arguments

import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// A widget that applies a vertical radius (top and bottom) to a child widget.
class RadiusVertical extends StatelessWidget {
  const RadiusVertical._({
    required this.child,
    required this.radius,
    super.key,
  });

  /// Creates a widget with a large vertical radius.
  factory RadiusVertical.lg({required Widget child, Key? key}) =>
      RadiusVertical._(child: child, radius: $.radiuses.lg, key: key);

  /// Creates a widget with a medium vertical radius.
  factory RadiusVertical.md({required Widget child, Key? key}) =>
      RadiusVertical._(child: child, radius: $.radiuses.md, key: key);

  /// Creates a widget with no vertical radius.
  factory RadiusVertical.none({required Widget child, Key? key}) =>
      RadiusVertical._(child: child, radius: $.radiuses.none, key: key);

  /// Creates a widget with a small vertical radius.
  factory RadiusVertical.sm({required Widget child, Key? key}) =>
      RadiusVertical._(child: child, radius: $.radiuses.sm, key: key);

  /// Creates a widget with an extra-large vertical radius.
  factory RadiusVertical.xl({required Widget child, Key? key}) =>
      RadiusVertical._(child: child, radius: $.radiuses.xl, key: key);

  /// Creates a widget with an extra-small vertical radius.
  factory RadiusVertical.xs({required Widget child, Key? key}) =>
      RadiusVertical._(child: child, radius: $.radiuses.xs, key: key);

  /// Creates a widget with an extra-extra-large vertical radius.
  factory RadiusVertical.xxl({required Widget child, Key? key}) =>
      RadiusVertical._(child: child, radius: $.radiuses.xxl, key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radius),
          bottom: Radius.circular(radius),
        ),
      ),
      child: child,
    );
  }

  final Widget child;
  final double radius;
}
