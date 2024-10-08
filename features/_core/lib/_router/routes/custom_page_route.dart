// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';

/// A custom page route that extends [MaterialPageRoute] to provide custom transition duration.
///
/// This class allows you to define a page route with a custom transition animation duration
/// while maintaining the default behavior of [MaterialPageRoute].
///
/// Example usage:
/// ```dart
/// Navigator.push(
///   context,
///   CustomPageRoute(
///     builder: (context) => YourScreen(),
///     settings: RouteSettings(name: 'your_screen'),
///   ),
/// );
/// ```
///
/// [T] is the type of the return value of the route.
///
/// - `transitionDuration`: Overridden to define the custom transition duration of 500 milliseconds.
class CustomPageRoute<T> extends MaterialPageRoute<T> {
  /// Creates a custom page route with the specified builder and route settings.
  ///
  /// - [builder]: A function that returns the widget to be displayed by this route.
  /// - [settings]: Route-specific settings, such as the name of the route.
  CustomPageRoute({required super.builder, required super.settings});

  /// Custom transition duration for the route.
  ///
  /// This overrides the default transition duration of [MaterialPageRoute]
  /// and provides a 500 millisecond transition.
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);
}
