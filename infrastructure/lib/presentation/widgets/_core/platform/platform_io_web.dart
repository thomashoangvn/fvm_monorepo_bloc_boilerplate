// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:deps/packages/universal_html.dart' as html;

/// Provides platform detection for web environments using `dart:html`.
/// This class checks the browser's user agent to infer the platform (macOS, Windows, Linux, Android, or iOS).
abstract final class PlatformIo {
  /// Always returns `true` as it's a web platform.
  static bool get isWeb => true;

  /// Returns `true` if running on macOS.
  static bool get isMacOS =>
      _navigator.appVersion.contains('Mac OS') && !PlatformIo.isIOS;

  /// Returns `true` if running on Windows.
  static bool get isWindows => _navigator.appVersion.contains('Win');

  /// Returns `true` if running on Linux.
  static bool get isLinux =>
      (_navigator.appVersion.contains('Linux') ||
          _navigator.appVersion.contains('x11')) &&
      !isAndroid;

  /// Returns `true` if running on Android.
  static bool get isAndroid => _navigator.appVersion.contains('Android ');

  /// Returns `true` if running on iOS.
  static bool get isIOS {
    return hasMatch('/iPad|iPhone|iPod/', _navigator.platform) ||
        (_navigator.platform == 'MacIntel' && _navigator.maxTouchPoints! > 1);
  }

  /// Always returns `false` as Fuchsia isn't supported on the web.
  static bool get isFuchsia => false;

  /// Returns `true` if running on a desktop platform (macOS, Windows, or Linux).
  static bool get isDesktop => isMacOS || isWindows || isLinux;

  /// Helper method to check if a string contains a match for a given pattern.
  static bool hasMatch(String pattern, String? value) {
    return value != null && RegExp(pattern).hasMatch(value);
  }

  /// Stores the web navigator object to access platform and app version details.
  static final html.Navigator _navigator = html.window.navigator;
}
