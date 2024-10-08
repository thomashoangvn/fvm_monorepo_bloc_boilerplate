// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/get_it.dart';
import 'package:deps/packages/injectable.dart';
import 'package:feature_user/_core/_di/_di.config.dart';

/// Initializes the dependency injection (DI) system for the user feature.
///
/// This function is responsible for injecting dependencies needed for the user,
/// using the `GetIt` package for service location and the `Injectable` package for
/// automatic dependency injection setup.
///
/// The DI setup is controlled by the [env] parameter, allowing different configurations
/// for different environments (e.g., development, production).
///
/// The injected dependencies are defined in the `_di.config.dart` file, which is generated
/// by the `Injectable` package based on annotations in the project.
///
/// - [di]: An instance of `GetIt` used for dependency injection.
/// - [env]: A string specifying the environment (e.g., 'dev', 'prod') to determine the setup.
@InjectableInit()
void injectUserFeature(GetIt di, String env) {
  // Initialize the dependencies for the specified environment.
  di.init(environment: env);
}
