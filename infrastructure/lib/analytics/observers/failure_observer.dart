// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/injectable.dart';
import 'package:infrastructure/_core/commons/enums/failure_type.enum.dart';
import 'package:infrastructure/analytics/failure/failure.dart';
import 'package:infrastructure/analytics/observers/i_failure_observer.dart';
import 'package:infrastructure/analytics/reporters/i_analytics.dart';
import 'package:infrastructure/analytics/reporters/i_logger.dart';
import 'package:infrastructure/flavors/i_env.dart';

/// Implementation of `IFailureObserver` to log and report failures.
/// This observer integrates with analytics and logging systems.
@LazySingleton(as: IFailureObserver)
class FailureObserver implements IFailureObserver {
  const FailureObserver(this._analytics, this._env, this._logger);

  /// Analytics service for reporting failures.
  final IAnalytics _analytics;

  /// Environment configuration to check if the app is in debug mode.
  final IEnv _env;

  /// Logger for logging error and exception details.
  final ILogger _logger;

  /// Handles failure based on its type and logs or reports it.
  @override
  void onFailure(Failure failure) {
    // Only send to analytics if not in debug mode
    if (!_env.isDebug) {
      _analytics.send(failure.message);
    }

    // Log failure based on its type
    switch (failure.type) {
      case FailureTypeEnum.exception:
        _logger.exception(failure);

      case FailureTypeEnum.error:
        _logger.error(failure);

      default:
        return;
    }
  }
}
