// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-boolean-prefixes

import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// A widget that applies custom radius to specific corners of a child widget.
class RadiusOnly extends StatelessWidget {
  const RadiusOnly._({
    required this.bottomLeft,
    required this.bottomRight,
    required this.child,
    required this.radius,
    required this.topLeft,
    required this.topRight,
    super.key,
  });

  /// Creates a widget with large radius for specified corners.
  factory RadiusOnly.lg({
    required Widget child,
    Key? key,
    bool bottomLeft = false,
    bool bottomRight = false,
    bool topLeft = false,
    bool topRight = false,
  }) =>
      RadiusOnly._(
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
        child: child,
        radius: $.radiuses.lg,
        topLeft: topLeft,
        topRight: topRight,
        key: key,
      );

  /// Creates a widget with medium radius for specified corners.
  factory RadiusOnly.md({
    required Widget child,
    Key? key,
    bool bottomLeft = false,
    bool bottomRight = false,
    bool topLeft = false,
    bool topRight = false,
  }) =>
      RadiusOnly._(
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
        child: child,
        radius: $.radiuses.md,
        topLeft: topLeft,
        topRight: topRight,
        key: key,
      );

  /// Creates a widget with no radius for specified corners.
  factory RadiusOnly.none({
    required Widget child,
    Key? key,
    bool bottomLeft = false,
    bool bottomRight = false,
    bool topLeft = false,
    bool topRight = false,
  }) =>
      RadiusOnly._(
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
        child: child,
        radius: $.radiuses.none,
        topLeft: topLeft,
        topRight: topRight,
        key: key,
      );

  /// Creates a widget with small radius for specified corners.
  factory RadiusOnly.sm({
    required Widget child,
    Key? key,
    bool bottomLeft = false,
    bool bottomRight = false,
    bool topLeft = false,
    bool topRight = false,
  }) =>
      RadiusOnly._(
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
        child: child,
        radius: $.radiuses.sm,
        topLeft: topLeft,
        topRight: topRight,
        key: key,
      );

  /// Creates a widget with extra-large radius for specified corners.
  factory RadiusOnly.xl({
    required Widget child,
    Key? key,
    bool bottomLeft = false,
    bool bottomRight = false,
    bool topLeft = false,
    bool topRight = false,
  }) =>
      RadiusOnly._(
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
        child: child,
        radius: $.radiuses.xl,
        topLeft: topLeft,
        topRight: topRight,
        key: key,
      );

  /// Creates a widget with extra-small radius for specified corners.
  factory RadiusOnly.xs({
    required Widget child,
    Key? key,
    bool bottomLeft = false,
    bool bottomRight = false,
    bool topLeft = false,
    bool topRight = false,
  }) =>
      RadiusOnly._(
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
        child: child,
        radius: $.radiuses.xs,
        topLeft: topLeft,
        topRight: topRight,
        key: key,
      );

  /// Creates a widget with extra-extra-large radius for specified corners.
  factory RadiusOnly.xxl({
    required Widget child,
    Key? key,
    bool bottomLeft = false,
    bool bottomRight = false,
    bool topLeft = false,
    bool topRight = false,
  }) =>
      RadiusOnly._(
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
        child: child,
        radius: $.radiuses.xxl,
        topLeft: topLeft,
        topRight: topRight,
        key: key,
      );

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft ? radius : 0),
          topRight: Radius.circular(topRight ? radius : 0),
          bottomLeft: Radius.circular(bottomLeft ? radius : 0),
          bottomRight: Radius.circular(bottomRight ? radius : 0),
        ),
      ),
      child: child,
    );
  }

  final bool bottomLeft;
  final bool bottomRight;
  final Widget child;
  final double radius;
  final bool topLeft;
  final bool topRight;
}
