// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: avoid-dynamic, avoid-ignoring-return-values, avoid-unassigned-stream-subscriptions

import 'dart:async';

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:feature_auth/_core/_router/router.gr.dart';
import 'package:feature_auth/views/cubits/auth.cubit.dart';
import 'package:feature_user/views/cubits/user.cubit.dart';

/// [AuthGuard] is a custom route guard used to protect routes that require user authentication.
///
/// It implements the [AutoRouteGuard] interface and is responsible for handling route navigation based on the user's
/// authentication status. If the user is authenticated and the user data is available, the navigation proceeds;
/// otherwise, the user is redirected to the authentication route.
///
/// Example usage:
/// ```dart
/// AutoRoute(
///   path: '/protected',
///   page: ProtectedPage,
///   guards: [AuthGuard()],
/// )
/// ```
class AuthGuard extends AutoRouteGuard {
  /// Creates an instance of [AuthGuard] with the default constructor.
  const AuthGuard();

  /// Handles the navigation when a user attempts to access a guarded route.
  ///
  /// If the user is authenticated (checked via the [AuthCubit]) and their user data is available
  /// (checked via the [UserCubit]), the route navigation proceeds by calling [resolver.next].
  ///
  /// If the user is unauthenticated, they are redirected to the authentication route using
  /// [resolver.redirect], replacing the current route.
  ///
  /// - [resolver]: The resolver allows you to either continue navigation or redirect the user.
  /// - [router]: The current router stack that manages the navigation flow.
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    // Check if the user is authenticated and user data exists.
    Future<void>.delayed(Duration.zero, () async {
      if (locator<AuthCubit>().state == AuthStatusEnum.authenticated &&
          locator<UserCubit>().state.user.isNotEmpty) {
        // Proceed with the navigation if authenticated.
        resolver.next();
      }
      // Redirect to the authentication route if unauthenticated.
      else if (locator<AuthCubit>().state == AuthStatusEnum.unauthenticated) {
        await resolver.redirect(const AuthRoute(), replace: true);
      }
    });
  }
}
