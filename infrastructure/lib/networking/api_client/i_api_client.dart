// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/dio.dart';
import 'package:infrastructure/_core/commons/enums/request_type.enum.dart';
import 'package:infrastructure/_core/commons/typedefs/either.typedef.dart';
import 'package:infrastructure/_core/commons/typedefs/model_from_json.typedef.dart';
import 'package:infrastructure/networking/models/token.model.dart';
import 'package:infrastructure/storage/file_storage/token/token_file_storage_mixin.dart';

/// Defines the contract for API clients, specifying core functionalities such as:
/// - Invoking API calls
/// - Changing the base URL
/// - Managing request interceptors
/// - Accessing token storage
abstract interface class IApiClient {
  /// Invokes an API request with the given [path] and [requestType].
  ///
  /// * [path]: The endpoint to which the request is made.
  /// * [requestType]: The HTTP method (GET, POST, PUT, etc.).
  /// * [modelFromJson]: A function to deserialize the JSON response into a model.
  /// * [queryParameters]: Query parameters for the request.
  /// * [data]: The request payload.
  ///
  /// Returns an `Either<Failure, O>` representing the result of the request.
  AsyncEither<M> invoke<SM, M>(
    String path,
    RequestTypeEnum requestType, {
    ModelFromJson<dynamic>? fromJson,
    Map<String, String>? queryParameters,
    Map<String, dynamic> data,
  });

  /// Changes the base URL of the API client.
  void changeBaseUrl(String baseUrl);

  /// Sets an observer for intercepting requests and responses.
  void setObserver(Interceptor interceptor);

  /// Retrieves the token storage, which manages tokens like access and refresh tokens.
  TokenFileStorageMixin<TokenModel> get tokenStorage;
}
