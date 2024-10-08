// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

/// Interface that defines the environment configuration.
/// This class is designed to be implemented by different
/// environment-specific configurations (e.g., `EnvProd`, `EnvDev`).
abstract interface class IEnv {
  /// API base URL for the environment.
  abstract final String apiUrl;

  /// URL for analytics services for the environment.
  abstract final String analyticsUrl;

  /// Indicates whether the environment is in debug mode.
  abstract final bool isDebug;
}
