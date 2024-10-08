// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/auto_route.dart';
import 'package:infrastructure/_core/_router/router.gr.dart';
import 'package:infrastructure/presentation/_core/dialog/dialog_builder.dart';
import 'package:infrastructure/presentation/_core/modal/modal_builder.dart';

/// The main router configuration for the infrastructure layer of the application.
///
/// This class extends `RootStackRouter` and defines custom routes for dialogs and modals.
/// It uses the `AutoRoute` package to manage navigation in a type-safe and declarative way.
@AutoRouterConfig()
class InfrastructureRouter extends RootStackRouter {
  /// Defines the routes for the infrastructure, including custom dialog and modal routes.
  ///
  /// - The `DialogWrapperRoute` and `ModalWrapperRoute` are pages that use custom route builders.
  /// - These routes are built using the custom route builders `DialogBuilder.route` and `ModalBuilder.route`,
  ///   respectively, allowing for a customized presentation of dialogs and modals.
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        // Custom route for handling dialog presentations.
        CustomRoute<void>(
          page: DialogWrapperRoute.page,
          customRouteBuilder: DialogBuilder.route,
        ),
        // Custom route for handling modal presentations.
        CustomRoute<void>(
          page: ModalWrapperRoute.page,
          customRouteBuilder: ModalBuilder.route,
        ),
      ];
}
