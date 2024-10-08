// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/envied.dart';
import 'package:deps/packages/injectable.dart';
import 'package:infrastructure/flavors/i_env.dart';

part 'dev.env.g.dart';

/// Development environment implementation of the `IEnv` interface.
/// This class fetches its configuration from the `../.env.dev` file.
///
/// The `Envied` annotation is used to load the environment variables
/// from the `.env.dev` file into the fields defined in this class.
@Environment('dev')
@Singleton(as: IEnv)
@Envied(path: '../.env.dev')
class DevEnv implements IEnv {
  /// Indicates whether the development environment is in debug mode.
  /// Set to `true` for debugging purposes.
  @override
  final bool isDebug = true;

  /// URL for analytics services in the development environment.
  /// This value is fetched from the `ANALYTICS_URL` variable in the `.env.dev` file.
  @override
  @EnviedField(varName: 'ANALYTICS_URL')
  final String analyticsUrl = _DevEnv.analyticsUrl;

  /// API base URL for the development environment.
  /// This value is fetched from the `API_URL` variable in the `.env.dev` file.
  @override
  @EnviedField(varName: 'API_URL')
  final String apiUrl = _DevEnv.apiUrl;
}