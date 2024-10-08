// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/auto_route.dart';
import 'package:feature_core/_router/features.router.gr.dart';
import 'package:flutter/material.dart';

/// Enum [NavigationTabsEnum] represents different navigation tabs in the application.
///
/// Each tab is associated with a screen route, an icon, and a label.
/// The routes correspond to specific pages in the app, and icons are used for visual representation
/// in the navigation bar. The labels are currently static and should be localized using translations.
///
/// Example usage:
/// ```dart
/// NavigationTabsEnum.a.screen;
/// NavigationTabsEnum.b.icon;
/// ```
///
/// Properties:
/// - `screen`: The route information for the tab, representing the destination page.
/// - `icon`: The icon used in the navigation bar for the tab.
/// - `label`: The label for the tab, which should be moved to the translation system.
enum NavigationTabsEnum {
  /// Example tab representing the "Home" page.
  /// This should be replaced with the actual home page route.
  a(screen: ARoute(), icon: Icons.home, label: 'Home'),

  /// Example tab representing the "Settings" page.
  /// This should be replaced with the actual settings page route.
  b(screen: BRoute(), icon: Icons.settings, label: 'Settings');

  /// The route representing the screen to navigate to.
  final PageRouteInfo<dynamic> screen;

  /// The icon displayed in the bottom navigation bar.
  final IconData icon;

  /// The label for the tab, which should be localized.
  final String label;

  /// Constructor for the [NavigationTabsEnum].
  const NavigationTabsEnum({
    required this.screen,
    required this.icon,
    required this.label,
  });
}
