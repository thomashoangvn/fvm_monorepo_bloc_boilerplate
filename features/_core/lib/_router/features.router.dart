// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/features/features.dart';
import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:feature_core/_router/guards/auth.guard.dart';
import 'package:feature_core/_router/routes/custom_page_route.dart';
import 'package:flutter/material.dart';

/// A router class that defines the app's navigation configuration using AutoRoute.
///
/// The [FeaturesRouter] handles the routing between the different features of
/// the app, such as authentication and core infrastructure routes. It includes
/// custom page transitions and guards for route protection.
@AutoRouterConfig()
class FeaturesRouter extends RootStackRouter {
  /// Router for authentication-related routes.
  final AuthFeatureRouter authFeatureRouter = AuthFeatureRouter();

  /// Router for infrastructure-related routes.
  final InfrastructureRouter infrastructureRouter = InfrastructureRouter();

  /// Default route type with a custom transition animation.
  ///
  /// This method defines a custom page transition using [CustomPageRoute], which
  /// adds a transition duration of 500 milliseconds for forward and reverse animations.
  @override
  RouteType get defaultRouteType => RouteType.custom(
        customRouteBuilder: <T>(_, Widget child, AutoRoutePage<T> page) {
          return CustomPageRoute<T>(
            builder: (_) {
              return child;
            },
            settings: page,
          );
        },
        durationInMilliseconds: 500,
        reverseDurationInMilliseconds: 500,
      );

  /// List of routes in the app.
  ///
  /// This method defines the application's routing structure, including the main
  /// wrapper (`SuperWrapper`), the `DashboardRouter` which contains child routes
  /// and route guards, as well as additional routes for authentication and infrastructure.
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: SuperWrapper.page,
          children: <AutoRoute>[
            AutoRoute(
              page: DashboardRouter.page,
              guards: const <AuthGuard>[AuthGuard()],
              children: <AutoRoute>[
                // TODO: Routes in the dashboard should be placed here.
                AutoRoute(page: ARoute.page),
                AutoRoute(page: BRoute.page),
              ],
              initial: true,
            ),
            ...authFeatureRouter.routes,
            // TODO: Other routes should be placed here.
            ...infrastructureRouter.routes,
          ],
          initial: true,
        ),
      ];
}
