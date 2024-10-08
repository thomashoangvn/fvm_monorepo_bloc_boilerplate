// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// A widget that applies uniform border-radius to all corners of a child widget.
class RadiusAll extends StatelessWidget {
  const RadiusAll._({required this.child, required this.radius, super.key});

  /// Creates a widget with large uniform border-radius.
  factory RadiusAll.lg({required Widget child, Key? key}) =>
      RadiusAll._(child: child, radius: $.radiuses.lg, key: key);

  /// Creates a widget with medium uniform border-radius.
  factory RadiusAll.md({required Widget child, Key? key}) =>
      RadiusAll._(child: child, radius: $.radiuses.md, key: key);

  /// Creates a widget with no border-radius (radius set to 0).
  factory RadiusAll.none({required Widget child, Key? key}) =>
      RadiusAll._(child: child, radius: $.radiuses.none, key: key);

  /// Creates a widget with small uniform border-radius.
  factory RadiusAll.sm({required Widget child, Key? key}) =>
      RadiusAll._(child: child, radius: $.radiuses.sm, key: key);

  /// Creates a widget with extra-large uniform border-radius.
  factory RadiusAll.xl({required Widget child, Key? key}) =>
      RadiusAll._(child: child, radius: $.radiuses.xl, key: key);

  /// Creates a widget with extra-small uniform border-radius.
  factory RadiusAll.xs({required Widget child, Key? key}) =>
      RadiusAll._(child: child, radius: $.radiuses.xs, key: key);

  /// Creates a widget with extra-extra-large uniform border-radius.
  factory RadiusAll.xxl({required Widget child, Key? key}) =>
      RadiusAll._(child: child, radius: $.radiuses.xxl, key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: child,
    );
  }

  final Widget child;
  final double radius;
}
