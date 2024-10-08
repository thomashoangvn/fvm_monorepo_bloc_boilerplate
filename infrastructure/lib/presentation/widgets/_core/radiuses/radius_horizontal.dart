// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: no-equal-arguments

import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// A widget that applies horizontal (left and right) border-radius to a child widget.
class RadiusHorizontal extends StatelessWidget {
  const RadiusHorizontal._({
    required this.child,
    required this.radius,
    super.key,
  });

  /// Creates a widget with large horizontal border-radius.
  factory RadiusHorizontal.lg({required Widget child, Key? key}) =>
      RadiusHorizontal._(child: child, radius: $.radiuses.lg, key: key);

  /// Creates a widget with medium horizontal border-radius.
  factory RadiusHorizontal.md({required Widget child, Key? key}) =>
      RadiusHorizontal._(child: child, radius: $.radiuses.md, key: key);

  /// Creates a widget with no horizontal border-radius (radius set to 0).
  factory RadiusHorizontal.none({required Widget child, Key? key}) =>
      RadiusHorizontal._(child: child, radius: $.radiuses.none, key: key);

  /// Creates a widget with small horizontal border-radius.
  factory RadiusHorizontal.sm({required Widget child, Key? key}) =>
      RadiusHorizontal._(child: child, radius: $.radiuses.sm, key: key);

  /// Creates a widget with extra-large horizontal border-radius.
  factory RadiusHorizontal.xl({required Widget child, Key? key}) =>
      RadiusHorizontal._(child: child, radius: $.radiuses.xl, key: key);

  /// Creates a widget with extra-small horizontal border-radius.
  factory RadiusHorizontal.xs({required Widget child, Key? key}) =>
      RadiusHorizontal._(child: child, radius: $.radiuses.xs, key: key);

  /// Creates a widget with extra-extra-large horizontal border-radius.
  factory RadiusHorizontal.xxl({required Widget child, Key? key}) =>
      RadiusHorizontal._(child: child, radius: $.radiuses.xxl, key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(radius),
          right: Radius.circular(radius),
        ),
      ),
      child: child,
    );
  }

  final Widget child;
  final double radius;
}
