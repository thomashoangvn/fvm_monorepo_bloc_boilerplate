// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/injectable.dart';
import 'package:infrastructure/storage/caches/i_cache.dart';

/// An in-memory implementation of the [ICache] interface, storing cached objects
/// in a map. This class provides basic functionality for caching objects
/// temporarily within the app's memory during runtime.
///
/// The cached data is stored in a [Map] using key-value pairs, and will be
/// discarded when the app is restarted or closed.
///
/// This class is marked as [Injectable] so it can be easily managed by a
/// dependency injection system.
@Injectable(as: ICache)
class InMemoryCache implements ICache {
  InMemoryCache();

  /// The map that holds the cached data in memory. Keys are [String], and
  /// values are any object that extends [Object].
  Map<String, Object> _map = <String, Object>{};

  /// Retrieves a value from the cache, associated with the given [key]. If the
  /// value exists and is of type [T], it is returned. Otherwise, `null` is returned.
  ///
  /// - [key]: The unique string identifier used to retrieve the object.
  /// - Returns: The cached object if found and it matches type [T], otherwise `null`.
  @override
  T? read<T extends Object>({required String key}) {
    final Object? value = _map[key];
    return value is T ? value : null;
  }

  /// Removes a value from the cache, associated with the given [key]. If the
  /// value exists and is of type [T], it is removed and returned. Otherwise, `null`
  /// is returned.
  ///
  /// - [key]: The unique string identifier used to remove the object.
  /// - Returns: The removed object if found and it matches type [T], otherwise `null`.
  @override
  T? remove<T extends Object>({required String key}) {
    final Object? value = _map[key];

    if (value is T) {
      final Map<String, Object> newMap = <String, Object>{..._map}..remove(key);
      _map = newMap; // Reassigning to ensure immutability.

      return value;
    }

    return null;
  }

  /// Writes a value to the cache, associating it with the given [key]. If a value
  /// with the same [key] already exists, it is overwritten.
  ///
  /// - [key]: The unique string identifier used to store the object.
  /// - [value]: The object to be cached.
  @override
  void write<T extends Object>({required String key, required T value}) {
    _map = <String, Object>{
      ..._map,
      key: value
    }; // Ensures immutability by creating a new map.
  }
}
