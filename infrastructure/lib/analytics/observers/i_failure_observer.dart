// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:infrastructure/analytics/failure/failure.dart';

/// Interface for observing and responding to failure events.
abstract class IFailureObserver {
  /// Called when a failure occurs.
  void onFailure(Failure failure);
}
