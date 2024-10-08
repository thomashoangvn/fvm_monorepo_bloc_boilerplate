// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/envied.dart';
import 'package:deps/packages/injectable.dart';
import 'package:infrastructure/flavors/i_env.dart';

part 'prod.env.g.dart';

/// Production environment implementation of the `IEnv` interface.
/// This class fetches its configuration from the `../.env.prod` file.
///
/// The `Envied` annotation is used to load the environment variables
/// from the `.env.prod` file into the fields defined in this class.
@Environment('prod')
@Singleton(as: IEnv)
@Envied(path: '../.env.prod')
class ProdEnv implements IEnv {
  /// Indicates whether the production environment is in debug mode.
  /// Set to `true` for debugging purposes in this example.
  @override
  final bool isDebug = true;

  /// URL for analytics services in the production environment.
  /// This value is fetched from the `ANALYTICS_URL` variable in the `.env.prod` file.
  @override
  @EnviedField(varName: 'ANALYTICS_URL')
  final String analyticsUrl = _ProdEnv.analyticsUrl;

  /// API base URL for the production environment.
  /// This value is fetched from the `API_URL` variable in the `.env.prod` file.
  @override
  @EnviedField(varName: 'API_URL')
  final String apiUrl = _ProdEnv.apiUrl;
}
