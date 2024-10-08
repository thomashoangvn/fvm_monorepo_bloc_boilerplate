// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

/// An abstract interface for cache storage, allowing objects to be stored,
/// retrieved, and removed based on a unique key. Any class implementing this
/// interface should handle the storage of objects in a way that maintains type
/// safety.
///
/// Generic types are used to allow for flexibility in the kind of objects
/// that can be cached.
abstract interface class ICache {
  /// Writes an object of type [T] to the cache.
  ///
  /// - [key]: A unique string identifier used to store and retrieve the object.
  /// - [value]: The object to store, which must extend [Object].
  void write<T extends Object>({required String key, required T value});

  /// Reads and returns an object of type [T] from the cache.
  ///
  /// - [key]: The unique string identifier of the object to retrieve.
  /// - Returns the cached object if found, or `null` if no object is stored
  ///   with the specified [key] or if the stored object is not of type [T].
  T? read<T extends Object>({required String key});

  /// Removes and returns an object of type [T] from the cache.
  ///
  /// - [key]: The unique string identifier of the object to remove.
  /// - Returns the removed object if found, or `null` if no object is stored
  ///   with the specified [key] or if the stored object is not of type [T].
  T? remove<T extends Object>({required String key});
}
