// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:infrastructure/analytics/failure/failure.dart';

/// Logger interface defining methods for handling different types of logs.
///
/// - `debug`: Logs debugging information.
/// - `error`: Logs an error, usually caused by a `Failure`.
/// - `exception`: Logs an exception, typically associated with a `Failure`.
abstract class ILogger {
  void debug(dynamic data, [String? message]);

  void error(Failure failure);

  void exception(Failure failure);
}
