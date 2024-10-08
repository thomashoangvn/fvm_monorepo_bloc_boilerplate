// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:async';

import 'package:infrastructure/_core/commons/typedefs/future_or_callback.typedef.dart';

/// Extension on `Duration` to easily introduce delays with callbacks.
extension DurationExt on Duration {
  /// Delays the execution of the provided [callback] for the duration.
  ///
  /// The callback can either be synchronous or asynchronous.
  Future<dynamic> delay([FutureOrCallback? callback]) =>
      Future<dynamic>.delayed(
        this,
        callback,
      );
}
