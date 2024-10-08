// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/injectable.dart';
import 'package:deps/packages/talker_flutter.dart';
import 'package:infrastructure/analytics/failure/failure.dart';
import 'package:infrastructure/analytics/reporters/i_logger.dart';
import 'package:infrastructure/analytics/reporters/talker/logs/debug_log.dart';
import 'package:infrastructure/analytics/reporters/talker/logs/failure_log.dart';

/// A concrete implementation of the `ILogger` interface using `Talker` for logging.
///
/// This logger supports logging debug information, errors, and exceptions
/// through the `Talker` package. It wraps the `Talker` functionality with a
/// custom log type for each logging level (e.g., `DebugLog`, `FailureLog`).
@LazySingleton(as: ILogger)
class TalkerLogger implements ILogger {
  const TalkerLogger(this._talker);

  final Talker _talker;

  /// Logs debug information with an optional message.
  @override
  void debug(dynamic data, [String? message]) {
    _talker.logTyped(DebugLog(data, message));
  }

  /// Logs an error using the `Failure` log type.
  @override
  void error(Failure failure) {
    _talker.logTyped(FailureLog(failure));
  }

  /// Logs an exception using the `Failure` log type.
  @override
  void exception(Failure failure) {
    _talker.logTyped(FailureLog(failure));
  }
}
