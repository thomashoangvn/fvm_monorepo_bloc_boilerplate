// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

/// Enum representing different tags used to categorize failures in the application.
enum FailureTagEnum {
  /// Represents an empty or undefined failure.
  empty,

  /// Failures related to authentication issues.
  authentication,

  /// Failures caused by network connectivity problems.
  network,

  /// Failures related to operational issues.
  operation,

  /// Failures due to insufficient permissions.
  permission,

  /// Failures in the presentation layer (UI-related).
  presentation,

  /// Failures related to service call issues.
  service,

  /// Failures related to application state.
  state,

  /// Uncaught or uncategorized failures.
  uncaught,
}
