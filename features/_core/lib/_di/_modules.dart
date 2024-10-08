// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-match-file-name

part of '_di.dart';

/// [FeaturesRouterModule] provides a lazily initialized instance of [FeaturesRouter].
///
/// This module is part of the dependency injection setup and defines how the [FeaturesRouter]
/// should be provided across the application. The [@module] annotation marks it as an Injectable module
/// that groups dependency providers. The [@lazySingleton] annotation ensures that a single instance
/// of [FeaturesRouter] is created lazily (when it's first required).
///
/// Usage:
/// - This class is automatically integrated into the DI system, making the [FeaturesRouter] accessible
/// wherever it's injected using GetIt or other DI methods.
///
/// Example:
/// ```dart
/// final router = GetIt.instance<FeaturesRouter>();
/// ```
@module
abstract class FeaturesRouterModule {
  /// Provides a lazily created singleton instance of [FeaturesRouter].
  @lazySingleton
  FeaturesRouter get router => FeaturesRouter();
}
