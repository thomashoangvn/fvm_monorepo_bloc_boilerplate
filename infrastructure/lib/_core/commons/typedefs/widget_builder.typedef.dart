// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';

/// A type alias for a function that builds a `Widget` using the provided `BuildContext`.
///
/// This is typically used in Flutter to create widgets dynamically, for example,
/// in navigation, dialog builders, or list builders.
///
/// Example usage:
/// ```dart
/// WidgetBuilder myWidgetBuilder = (BuildContext context) {
///   return Text('Hello, world!');
/// };
/// ```
///
/// This allows you to define widget-building functions that take in a `BuildContext`
/// and return a widget, which is essential in many parts of Flutter’s widget tree.
typedef WidgetBuilder = Widget Function(BuildContext context);
