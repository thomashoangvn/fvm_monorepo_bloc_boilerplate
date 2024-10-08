// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: avoid_empty_blocks, no-empty-block

abstract final class UrlStrategy {
  /// Sets the URL strategy of your web app to using paths instead of a leading
  /// hash (`#`).
  ///
  /// You can safely call this on all platforms, i.e. also when running on mobile
  /// or desktop. In that case, it will simply be a noop.
  ///
  /// See also:
  ///  * [setHashUrlStrategy], which will use a hash URL strategy instead.
  static void setPathUrlStrategy() {}

  /// Sets the URL strategy of your web app to using a leading has (`#`) instead
  /// of paths.
  ///
  /// You can safely call this on all platforms, i.e. also when running on mobile
  /// or desktop. In that case, it will simply be a noop.
  ///
  /// See also:
  ///  * [setPathUrlStrategy], which will use a path URL strategy instead.
  static void setHashUrlStrategy() {}
}
