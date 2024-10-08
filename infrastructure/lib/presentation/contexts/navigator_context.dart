// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// [NavigatorContext] is a helper class that simplifies navigation operations
/// in a Flutter application using `auto_route`. It provides easy access to the
/// navigator and auto-router states through global keys and exposes methods for
/// navigating between pages, replacing routes, and popping navigation stacks.
///
/// This class ensures safe navigation by checking the availability of a valid
/// [BuildContext] before performing any actions, preventing navigation
/// failures in edge cases where the context might not be mounted.

@immutable
final class NavigatorContext {
  /// GlobalKey to access [NavigatorState] for managing standard Flutter navigation.
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// GlobalKey to access [AutoRouterState] for managing `auto_route` navigation.
  final GlobalKey<AutoRouterState> autoRouterKey = GlobalKey<AutoRouterState>();

  /// GlobalKey to access [ScaffoldState] for handling scaffold-related actions.
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  /// Returns `true` if a valid [BuildContext] is available.
  bool get hasContext => context != null;

  /// Retrieves the [BuildContext] from the current [NavigatorState].
  /// Throws an assertion error if no context is found.
  BuildContext? get context {
    final BuildContext? context = navigatorKey.currentContext;
    assert(context != null, 'No context found.');

    return context;
  }

  /// Retrieves the [BuildContext] from the current [NavigatorState].
  /// Waits context related operations until context is ready.
  Future<BuildContext> get ensuredContext async {
    BuildContext? context = navigatorKey.currentContext;

    while (context == null) {
      await Future<void>.delayed(Duration.zero);
      context = navigatorKey.currentContext;
    }

    return context;
  }

  /// Retrieves the [NavigatorState] using the navigator key.
  NavigatorState? get state {
    return navigatorKey.currentState;
  }

  /// Retrieves the current [StackRouter] for the auto-route controller.
  StackRouter? get _controller {
    return autoRouterKey.currentState?.controller;
  }

  /// Pushes a new [PageRouteInfo] onto the stack and navigates to the route.
  ///
  /// If the [context] is mounted, it pushes the route via the auto-route controller.
  /// Returns `null` if no context is available.
  Future<T?> push<T extends Object?>(
    PageRouteInfo route, {
    OnNavigationFailure? onFailure,
    bool shouldAutoDismissOthers = false,
  }) async {
    final BuildContext context = await ensuredContext;

    if (context.mounted) {
      if (shouldAutoDismissOthers) {
        $.dialog.popAllDialogs();
        await $.overlay.popOverlay();
      }

      await _controller?.push<T>(route, onFailure: onFailure);
    }

    return null;
  }

  /// Navigates to the specified [PageRouteInfo] without adding it to the history stack.
  Future<void> navigate(
    PageRouteInfo route, {
    OnNavigationFailure? onFailure,
    bool shouldAutoDismissOthers = false,
  }) async {
    final BuildContext context = await ensuredContext;

    if (context.mounted) {
      if (shouldAutoDismissOthers) {
        $.dialog.popAllDialogs();
        await $.overlay.popOverlay();
      }

      await _controller?.navigate(route, onFailure: onFailure);
    }

    return;
  }

  /// Navigates to a named route via its [path], with optional failure handling and prefix matching.
  Future<void> pushNamed(
    String path, {
    OnNavigationFailure? onFailure,
    bool shouldIncludePrefixMatches = false,
    bool shouldAutoDismissOthers = false,
  }) async {
    final BuildContext context = await ensuredContext;

    if (context.mounted) {
      if (shouldAutoDismissOthers) {
        $.dialog.popAllDialogs();
        await $.overlay.popOverlay();
      }

      await _controller?.navigateNamed(
        path,
        includePrefixMatches: shouldIncludePrefixMatches,
        onFailure: onFailure,
      );
    }

    return;
  }

  /// Replaces the current route with the given [PageRouteInfo] in the stack.
  ///
  /// Optionally handles navigation failures.
  Future<T?> replace<T extends Object?>(
    PageRouteInfo route, {
    OnNavigationFailure? onFailure,
    bool shouldAutoDismissOthers = true,
  }) async {
    final BuildContext context = await ensuredContext;

    if (context.mounted) {
      if (shouldAutoDismissOthers) {
        $.dialog.popAllDialogs();
        await $.overlay.popOverlay();
      }

      if (_controller?.current.name != route.routeName) {
        await _controller?.replace<T>(route, onFailure: onFailure);
      }
    }

    return null;
  }

  /// Replaces all existing routes with the specified [routes] list.
  /// Optionally, it can update existing routes or handle navigation failures.
  Future<void> replaceAll(
    List<PageRouteInfo> routes, {
    OnNavigationFailure? onFailure,
    bool shouldUpdateExistingRoutes = true,
    bool shouldAutoDismissOthers = true,
  }) async {
    final BuildContext context = await ensuredContext;

    if (context.mounted) {
      if (shouldAutoDismissOthers) {
        $.dialog.popAllDialogs();
        await $.overlay.popOverlay();
      }

      await _controller?.replaceAll(routes,
          onFailure: onFailure,
          updateExistingRoutes: shouldUpdateExistingRoutes);
    }
  }

  /// Pops the top-most route from the stack, returning an optional result.
  Future<bool?> pop<T extends Object?>([T? result]) async {
    final BuildContext context = await ensuredContext;

    if (context.mounted) {
      await _controller?.maybePop<T>(result);
    }

    return false;
  }

  /// Forces the pop of the top-most route from the stack, returning an optional result.
  Future<void> popForced<T extends Object?>([T? result]) async {
    final BuildContext context = await ensuredContext;

    if (context.mounted) {
      _controller?.popForced(result);
    }

    return;
  }

  /// Navigates back to the previous route in the stack.
  void back() => _controller?.back();
}
