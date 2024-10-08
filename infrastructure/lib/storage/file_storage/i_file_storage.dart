// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:async';

/// The [IFileStorage] interface provides a contract for file storage operations
/// such as reading, writing, and deleting data. It is a generic interface
/// where [T] represents the type of the object being stored.
abstract class IFileStorage<T> {
  /// Deletes the stored data.
  ///
  /// This method removes the stored data associated with the storage.
  Future<void> delete();

  /// Reads the stored data and returns an instance of [T].
  ///
  /// Returns `null` if no data is found or if an error occurs.
  Future<T?> read();

  /// Writes the given [value] of type [T] to the storage.
  Future<void> write(T value);
}
