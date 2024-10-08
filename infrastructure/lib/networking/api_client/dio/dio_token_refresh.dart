// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/dio.dart';
import 'package:deps/packages/injectable.dart';
import 'package:infrastructure/networking/api_client/dio/interceptors/dio_token_refresh_interceptor.dart';
import 'package:infrastructure/networking/failures/network_errors.dart';
import 'package:infrastructure/networking/models/token.model.dart';
import 'package:infrastructure/storage/file_storage/i_file_storage.dart';

/// Handles the logic for refreshing access tokens when they expire in Dio-based HTTP requests.
///
/// The [DioTokenRefresh] class provides the logic for refreshing tokens via the
/// `DioTokenRefreshInterceptor`, storing the tokens in secure storage, and ensuring the
/// authorization header is properly updated for authenticated API calls.
@lazySingleton
class DioTokenRefresh {
  /// Constructor to initialize [DioTokenRefresh] with required dependencies.
  ///
  /// * [_storage]: A storage instance to persist the token, typically using `IFileStorage`.
  DioTokenRefresh(this._storage);

  /// The interceptor responsible for refreshing tokens on failed requests.
  ///
  /// The [DioTokenRefreshInterceptor] listens for failed requests due to token expiration and
  /// attempts to refresh the token automatically.
  late final DioTokenRefreshInterceptor<TokenModel> interceptor =
      DioTokenRefreshInterceptor<TokenModel>(
    onRefreshToken: _onRefreshToken,
    handleTokenHeaderBuilder: _handleTokenHeaderBuilder,
    tokenStorage: _storage,
  );

  /// The storage system for persisting the token.
  final IFileStorage<TokenModel> _storage;

  /// Tracks the number of retry attempts to refresh the token.
  double _totalRetryCount = 0;

  /// Builds the `Authorization` header using the provided token.
  ///
  /// This function constructs a map containing the `Authorization` header
  /// with the format `Bearer <accessToken>`.
  ///
  /// * [token]: The token model containing the access token and token type.
  Map<String, String> _handleTokenHeaderBuilder(TokenModel token) {
    return <String, String>{
      'Authorization': '${token.tokenType} ${token.accessToken}',
    };
  }

  /// Refreshes the access token when the current token is expired.
  ///
  /// This function interacts with the `SsoService` to obtain a new token by using
  /// the refresh token. If the token has expired or too many retries have been attempted,
  /// an [UnexpectedTokenRefreshNetworkError] is thrown.
  ///
  /// * [dio]: The Dio instance to make the request with.
  /// * [token]: The current token to be refreshed.
  ///
  /// Returns a new [TokenModel] containing the refreshed access and refresh tokens.
  ///
  /// Throws [UnexpectedTokenRefreshNetworkError] if the refresh fails.
  Future<TokenModel> _onRefreshToken(
      {required Dio dio, required TokenModel? token}) async {
    _totalRetryCount += 1;

    if (token == null) {
      throw UnexpectedTokenRefreshNetworkError();
    }

    // Check if the token needs refreshing based on the expiration date.
    final bool shouldRefreshToken =
        token.expirationDate.difference(DateTime.now()).isNegative;

    if (shouldRefreshToken || _totalRetryCount > 2) {
      try {
        // TODO: The request to renew the token will be sent here.
        // Attempt to refresh the token using the refresh token.
        // const TokenModel? result = null;

        return TokenModel.empty();
      } catch (exception) {
        // Throw an error if token refresh fails.
        throw UnexpectedTokenRefreshNetworkError(exception: exception);
      }
    }

    // Return the existing token if it doesn't require refreshing.
    return token;
  }
}
