// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-match-file-name

import 'package:deps/packages/auto_route.dart';
import 'package:feature_auth/_core/_router/router.gr.dart';

/// [AuthFeatureRouter] manages the routing for the authentication feature.
///
/// This router is responsible for handling all the routes associated with the
/// authentication flow of the app. It defines a route for the authentication page
/// and integrates with AutoRoute for automatic routing.
@AutoRouterConfig()
class AuthFeatureRouter extends RootStackRouter {
  /// Defines the list of routes for the authentication feature.
  ///
  /// The primary route for the authentication flow is the [AuthRoute], which
  /// is accessible via the path `'auth'`.
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: AuthRoute.page,
          path: 'auth',
        ),
      ];
}
