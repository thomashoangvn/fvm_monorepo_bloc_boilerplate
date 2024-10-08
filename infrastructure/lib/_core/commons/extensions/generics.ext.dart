// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

/// Extension on nullable generic types to provide utility methods for null checks.
extension GenericsExt<T> on T? {
  /// Returns `true` if the object is `null`.
  bool get ifNull => this == null;

  /// Returns `true` if the object is not `null`.
  bool get ifNotNull => this != null;
}
