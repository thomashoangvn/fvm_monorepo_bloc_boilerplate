// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

/// Enum representing the different authentication statuses of the application.
enum AuthStatusEnum {
  /// User is successfully authenticated.
  authenticated,

  /// Authentication process is currently loading.
  loading,

  /// Initial state, before any authentication attempts.
  initial,

  /// User is not authenticated.
  unauthenticated,
}
