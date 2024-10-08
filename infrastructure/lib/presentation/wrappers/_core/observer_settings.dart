// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/talker_bloc_logger.dart';
import 'package:deps/packages/talker_dio_logger.dart';

/// [ObserverSettings] configures various observers that monitor and log
/// events in the application, including Bloc, Dio, and Router events.
final class ObserverSettings {
  /// Constructs an instance of [ObserverSettings].
  ///
  /// * [isBlocObserverEnabled]: Enables the Bloc observer, which logs
  ///   state changes in Cubit and Bloc classes.
  /// * [blocSettings]: Configuration settings for Bloc observer logging.
  /// * [isDioObserverEnabled]: Enables the Dio observer, which logs HTTP
  ///   requests and responses.
  /// * [dioSettings]: Configuration settings for Dio observer logging.
  /// * [isRouterObserverEnabled]: Enables the Router observer to log navigation
  ///   events.
  const ObserverSettings({
    this.isBlocObserverEnabled = true,
    this.blocSettings = const TalkerBlocLoggerSettings(),
    this.isDioObserverEnabled = true,
    this.dioSettings = const TalkerDioLoggerSettings(),
    this.isRouterObserverEnabled = true,
  });

  /// Settings used to configure logging behavior for Bloc state changes.
  final TalkerBlocLoggerSettings blocSettings;

  /// Settings used to configure logging behavior for Dio HTTP requests and responses.
  final TalkerDioLoggerSettings dioSettings;

  /// Whether the Bloc observer should be enabled for monitoring Bloc and Cubit
  /// state changes.
  final bool isBlocObserverEnabled;

  /// Whether the Dio observer should be enabled for monitoring HTTP requests
  /// and responses.
  final bool isDioObserverEnabled;

  /// Whether the Router observer should be enabled for monitoring navigation
  /// events within the app.
  final bool isRouterObserverEnabled;
}
