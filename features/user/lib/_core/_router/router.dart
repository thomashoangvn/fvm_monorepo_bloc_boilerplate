// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-match-file-name

import 'package:deps/packages/auto_route.dart';

/// `UserFeatureRouter` is responsible for defining and configuring
/// the routes related to the User feature module.
///
/// This class extends `RootStackRouter` and utilizes the `@AutoRouterConfig()`
/// annotation to manage routes automatically, enabling code generation for routing.
///
/// - **Example usage**:
///   Define user-related routes inside this router, such as user profile, settings, etc.
///
/// - **Returns**: A list of routes to be used by the `AutoRoute` package.
///
/// Example:
/// ```dart
/// @override
/// List<AutoRoute> get routes => <AutoRoute>[
///   AutoRoute(page: UserProfilePage),
///   AutoRoute(page: UserSettingsPage),
/// ];
/// ```
@AutoRouterConfig()
class UserFeatureRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[];
}
