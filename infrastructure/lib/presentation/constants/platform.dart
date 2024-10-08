// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/foundation.dart';
import 'package:infrastructure/presentation/widgets/_core/platform/platform_io_web.dart'
    if (dart.library.io) '../widgets/_core/platform/platform_io.dart';

/// The [Platform] class provides platform-specific flags to identify
/// the environment in which the app is running. This is useful for writing
/// platform-aware code, enabling different behaviors or UI depending on the
/// current operating system (OS) or platform type.
@immutable
final class Platform {
  /// Default constructor for the [Platform] class.
  Platform();

  /// **isWeb**: A boolean flag indicating whether the app is running on the web.
  ///
  /// - Returns `true` if running on the web platform, `false` otherwise.
  final bool isWeb = PlatformIo.isWeb;

  /// **isMacOS**: A boolean flag indicating whether the app is running on macOS.
  ///
  /// - Returns `true` if running on macOS, `false` otherwise.
  final bool isMacOS = PlatformIo.isMacOS;

  /// **isWindows**: A boolean flag indicating whether the app is running on Windows.
  ///
  /// - Returns `true` if running on Windows, `false` otherwise.
  final bool isWindows = PlatformIo.isWindows;

  /// **isLinux**: A boolean flag indicating whether the app is running on Linux.
  ///
  /// - Returns `true` if running on Linux, `false` otherwise.
  final bool isLinux = PlatformIo.isLinux;

  /// **isAndroid**: A boolean flag indicating whether the app is running on Android.
  ///
  /// - Returns `true` if running on Android, `false` otherwise.
  final bool isAndroid = PlatformIo.isAndroid;

  /// **isIOS**: A boolean flag indicating whether the app is running on iOS.
  ///
  /// - Returns `true` if running on iOS, `false` otherwise.
  final bool isIOS = PlatformIo.isIOS;

  /// **isFuchsia**: A boolean flag indicating whether the app is running on Fuchsia.
  ///
  /// - Returns `true` if running on Fuchsia OS, `false` otherwise.
  final bool isFuchsia = PlatformIo.isFuchsia;

  /// **isMobile**: A derived boolean flag that returns `true` if the platform is mobile
  /// (i.e., Android or iOS), `false` otherwise.
  ///
  /// It is lazily initialized based on the `isAndroid` and `isIOS` properties.
  late final bool isMobile = isIOS || isAndroid;

  /// **isDesktop**: A derived boolean flag that returns `true` if the platform is a desktop
  /// environment (i.e., macOS, Windows, or Linux), `false` otherwise.
  ///
  /// It is lazily initialized based on the `isMacOS`, `isWindows`, and `isLinux` properties.
  late final bool isDesktop = isMacOS || isWindows || isLinux;
}
