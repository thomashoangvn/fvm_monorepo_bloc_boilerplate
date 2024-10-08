// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// Extension on `BuildContext` to simplify access to various Flutter `ThemeData`, `MediaQuery`, and more.
extension ContextExt on BuildContext {
  // Access various themes directly from the context.
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;
  BottomAppBarTheme get bottomAppBarTheme => Theme.of(this).bottomAppBarTheme;
  BottomSheetThemeData get bottomSheetTheme => Theme.of(this).bottomSheetTheme;
  AppBarTheme get appBarTheme => Theme.of(this).appBarTheme;

  // Access media query properties from the context.
  Size get mediaQuerySize => MediaQuery.sizeOf(this);
  double get height => mediaQuerySize.height;
  double get width => mediaQuerySize.width;
  EdgeInsets get mediaQueryPadding => MediaQuery.paddingOf(this);
  EdgeInsets get mediaQueryViewPadding => MediaQuery.viewPaddingOf(this);
  EdgeInsets get mediaQueryViewInsets => MediaQuery.viewInsetsOf(this);
  Orientation get orientation => MediaQuery.orientationOf(this);

  // Determine orientation type.
  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;

  // Check if the 24-hour format should always be used.
  bool get shouldAlwaysUse24HourFormat =>
      MediaQuery.alwaysUse24HourFormatOf(this);

  // Access device pixel ratio and platform brightness from the context.
  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);
  Brightness get platformBrightness => MediaQuery.platformBrightnessOf(this);

  // Determine if the screen size matches phone or tablet dimensions.
  double get mediaQueryShortestSide => mediaQuerySize.shortestSide;
  bool get shouldShowNavbar => width > 800;
  bool get isPhone => mediaQueryShortestSide < 600;
  bool get isSmallTablet => mediaQueryShortestSide >= 600;
  bool get isLargeTablet => mediaQueryShortestSide >= 720;
  bool get isTablet => isSmallTablet || isLargeTablet;

  // Alternative MediaQuery shorthand accessors.
  Size get mqSize => MediaQuery.sizeOf(this);
  double get mqHeight => mqSize.height;
  double get mqWidth => mqSize.width;
  EdgeInsets get mqPadding => MediaQuery.paddingOf(this);
  EdgeInsets get mqViewPadding => MediaQuery.viewPaddingOf(this);
  EdgeInsets get mqViewInsets => MediaQuery.viewInsetsOf(this);
  Orientation get mqOrientation => MediaQuery.orientationOf(this);
  bool get mqAlwaysUse24HourFormat => MediaQuery.alwaysUse24HourFormatOf(this);
  double get mqDevicePixelRatio => MediaQuery.devicePixelRatioOf(this);
  Brightness get mqPlatformBrightness => MediaQuery.platformBrightnessOf(this);

  /// Returns a value based on the current device type (desktop, mobile, tablet).
  T? responsiveValue<T>({T? desktop, T? mobile, T? tablet}) {
    double deviceWidth = mediaQuerySize.shortestSide;

    if ($.platform.isDesktop) {
      deviceWidth = mediaQuerySize.width;
    }

    // Check the device width and return the appropriate value for desktop, tablet, or mobile.
    if (deviceWidth >= 1200 && desktop != null) {
      return desktop;
    }

    return deviceWidth >= 600 && tablet != null ? tablet : mobile;
  }
}
