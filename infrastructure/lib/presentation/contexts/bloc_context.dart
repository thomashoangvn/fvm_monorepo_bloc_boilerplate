// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/contexts/navigator_context.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// The [BlocContext] class serves as a convenient utility for accessing
/// BLoC (Business Logic Component) instances within the application. It uses
/// the [NavigatorContext] to retrieve the current `BuildContext` and exposes
/// methods to read or watch BLoC instances tied to that context.
///
/// Example usage:
/// ```dart
/// final MyBloc myBloc = $.read<MyBloc>();
/// ```
///
/// This class should be initialized with a [NavigatorContext] that provides
/// access to the current navigation context.
///
/// See also:
/// * [read] for accessing the BLoC without subscribing to changes.
/// * [watch] for subscribing to changes in the BLoC.

@immutable
final class BlocContext {
  /// Constructs a [BlocContext] with the given [NavigatorContext].
  const BlocContext();

  /// Retrieves a BLoC instance of type [T] from the current context without
  /// subscribing to its changes. This is useful for one-time access to a BLoC
  /// instance's current state or behavior.
  ///
  /// Example:
  /// ```dart
  /// final MyBloc myBloc = $.read<MyBloc>();
  /// ```
  T read<T>() {
    return $.navigator.context!.read<T>();
  }

  /// Subscribes to the BLoC instance of type [T] from the current context,
  /// and triggers a rebuild when the BLoC's state changes. Use this method
  /// when you want the widget to rebuild automatically on BLoC state changes.
  ///
  /// Example:
  /// ```dart
  /// final MyBloc myBloc = $.watch<MyBloc>();
  /// ```
  T watch<T>() {
    return $.navigator.context!.watch<T>();
  }
}
