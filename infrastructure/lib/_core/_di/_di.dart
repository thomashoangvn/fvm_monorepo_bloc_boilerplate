// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/dio.dart';
import 'package:deps/packages/flutter_secure_storage.dart';
import 'package:deps/packages/get_it.dart';
import 'package:deps/packages/injectable.dart';
import 'package:deps/packages/internet_connection_checker_plus.dart';
import 'package:deps/packages/package_info_plus.dart';
import 'package:deps/packages/talker_flutter.dart';
import 'package:infrastructure/_core/_di/_di.config.dart';
import 'package:infrastructure/analytics/reporters/talker/formatter/fancy_talker_log_formatter.dart';

part '_modules.dart';

/// Initializes the dependency injection (DI) system for the infrastructure layer.
///
/// This function is responsible for injecting dependencies needed for the infrastructure,
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
Future<void> injectInfrastructure(
    {required GetIt di, required String env}) async {
  // Initialize the dependencies for the specified environment.
  await di.init(environment: env);
}
