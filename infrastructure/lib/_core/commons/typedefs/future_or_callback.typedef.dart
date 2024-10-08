// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:async';

/// A type alias for a callback function that can return either a `Future` or
/// a synchronous value of any type (`dynamic`).
///
/// This type is useful for situations where a callback might return either an
/// asynchronous operation (like a `Future`) or a synchronous operation, allowing
/// the function to handle both scenarios.
///
/// Example usage:
/// ```dart
/// FutureOrCallback myCallback = () async {
///   // Do something asynchronously or synchronously
/// };
/// ```
typedef FutureOrCallback = FutureOr<dynamic> Function()?;
