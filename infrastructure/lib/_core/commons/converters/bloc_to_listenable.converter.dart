// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:async';

import 'package:flutter/material.dart';

/// A utility class that converts a [Stream] (typically from a BLoC) into a
/// [ChangeNotifier] so that it can be used with widgets that rely on
/// [Listenable] interfaces, such as [AnimatedBuilder] or [ValueListenableBuilder].
///
/// The class listens to a provided stream and notifies its listeners whenever
/// a new event is emitted by the stream.
///
/// Example usage:
/// ```dart
/// final converter = BlocToListenableConverter(myBlocStream);
/// // Use converter in a widget that listens for changes.
/// ```
class BlocToListenableConverter<T> extends ChangeNotifier {
  /// The stream that this converter listens to.
  final Stream<T> _stream;

  /// The subscription to the stream. This is used to listen for updates and
  /// notify the listeners accordingly.
  late final StreamSubscription<T> _subscription;

  /// Creates an instance of [BlocToListenableConverter] that listens to the
  /// provided [stream]. Each time a new event is emitted from the stream, it
  /// calls [notifyListeners] to inform all the listeners.
  BlocToListenableConverter(this._stream) {
    _subscription = _stream.listen((T event) {
      notifyListeners();
    });
  }

  /// Cancels the stream subscription and disposes of the resources when
  /// the [BlocToListenableConverter] is no longer needed.
  ///
  /// Always call [dispose] to free up the stream subscription and prevent
  /// memory leaks.
  @override
  void dispose() {
    _subscription
        .cancel(); // Cancel the stream subscription to avoid memory leaks.
    super
        .dispose(); // Call super to ensure any additional cleanup by ChangeNotifier.
  }
}
