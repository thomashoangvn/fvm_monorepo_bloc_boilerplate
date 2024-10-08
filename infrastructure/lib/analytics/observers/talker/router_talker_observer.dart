// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/talker_flutter.dart' hide TalkerRouteLog;
import 'package:flutter/material.dart';
import 'package:infrastructure/analytics/reporters/talker/logs/route_log.dart';

/// Custom `NavigatorObserver` that logs route changes (push/pop) using Talker.
class RouterTalkerObserver extends NavigatorObserver {
  RouterTalkerObserver({required this.talker});

  /// Instance of Talker used for logging route changes.
  final Talker talker;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name == null) {
      return;
    }
    // Log when a route is popped
    talker.logTyped(RouteLog(route: route, isPush: false));
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == null) {
      return;
    }
    // Log when a new route is pushed
    talker.logTyped(RouteLog(route: route));
  }
}
