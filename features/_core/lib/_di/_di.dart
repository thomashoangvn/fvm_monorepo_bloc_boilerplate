// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-static-class, avoid-ignoring-return-values, prefer-correct-identifier-length

import 'package:deps/packages/get_it.dart';
import 'package:deps/packages/injectable.dart';
import 'package:feature_auth/_core/_di/_di.dart';
import 'package:feature_core/_di/_di.config.dart';
import 'package:feature_core/_router/features.router.dart';
import 'package:feature_user/_core/_di/_di.dart';

part '_modules.dart';

/// [injectAllFeatures] is responsible for initializing all the feature-specific dependency injection setups.
///
/// It configures the DI container [GetIt] with dependencies for various features by calling their respective
/// injection methods. It also runs the default injection setup for the core app using `@InjectableInit`.
///
/// Parameters:
/// - [di]: The [GetIt] instance representing the DI container.
/// - [env]: The environment string used to determine which dependencies should be injected (e.g., `dev`, `prod`).
///
/// Example usage:
/// ```dart
/// injectAllFeatures(di: GetIt.instance, env: 'prod');
/// ```
@InjectableInit()
void injectAllFeatures({required GetIt di, required String env}) {
  // Initialize the core dependencies using @InjectableInit
  di.init(environment: env);

  // Initialize feature-specific dependencies
  injectAuthFeature(di, env);
  injectUserFeature(di, env);
}
