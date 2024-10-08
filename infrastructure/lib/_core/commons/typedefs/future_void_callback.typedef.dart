// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

/// A type alias for a callback function that returns a `Future<void>`.
///
/// This is useful for defining asynchronous functions that do not return any
/// value but may still need to perform asynchronous operations.
///
/// Example usage:
/// ```dart
/// FutureVoidCallback myCallback = () async {
///   // Perform some asynchronous operation
/// };
/// ```
typedef FutureVoidCallback = Future<void> Function();
