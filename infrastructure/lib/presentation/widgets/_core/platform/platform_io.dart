// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:io';

/// Platform detection for native environments using `dart:io`.
/// This class provides static methods to determine the platform
/// the app is running on (macOS, Windows, Linux, Android, iOS, or Fuchsia).
abstract final class PlatformIo {
  /// Always returns `false` as it's not a web platform.
  static bool get isWeb => false;

  /// Returns `true` if running on macOS.
  static bool get isMacOS => Platform.isMacOS;

  /// Returns `true` if running on Windows.
  static bool get isWindows => Platform.isWindows;

  /// Returns `true` if running on Linux.
  static bool get isLinux => Platform.isLinux;

  /// Returns `true` if running on Android.
  static bool get isAndroid => Platform.isAndroid;

  /// Returns `true` if running on iOS.
  static bool get isIOS => Platform.isIOS;

  /// Returns `true` if running on Fuchsia.
  static bool get isFuchsia => Platform.isFuchsia;

  /// Returns `true` if running on a desktop platform (macOS, Windows, or Linux).
  static bool get isDesktop =>
      Platform.isMacOS || Platform.isWindows || Platform.isLinux;
}
