// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:async';

import 'package:deps/packages/dio.dart';
import 'package:infrastructure/networking/failures/network_errors.dart';
import 'package:infrastructure/storage/file_storage/i_file_storage.dart';
import 'package:infrastructure/storage/file_storage/token/token_file_storage_mixin.dart';

/// A typedef for the function that determines if the token should be refreshed based on the response.
typedef ShouldRefresh = bool Function(Response<dynamic>? response);

/// A typedef for the function that handles refreshing the token.
typedef RefreshToken<T> = Future<T> Function(
    {required Dio dio, required T? token});

/// A typedef for the function that builds headers using the refreshed token.
typedef TokenHeaderBuilder<T> = Map<String, String> Function(T token);

/// Represents a request that is waiting for a token refresh before being retried.
class _RetryRequest {
  const _RetryRequest(this.options, this.completer);

  /// The original request options that failed due to token expiration.
  final RequestOptions options;

  /// The completer that will complete once the request is retried.
  final Completer<Response<dynamic>> completer;
}

/// [DioTokenRefreshInterceptor] manages token refreshing when API requests encounter token expiration.
///
/// It intercepts failed requests, refreshes the token if necessary, retries the failed requests,
/// and attaches the new token to the retried requests.
class DioTokenRefreshInterceptor<T> extends Interceptor
    with TokenFileStorageMixin<T> {
  DioTokenRefreshInterceptor({
    required RefreshToken<T> onRefreshToken,
    required TokenHeaderBuilder<T> handleTokenHeaderBuilder,
    required IFileStorage<T> tokenStorage,
    Dio? httpClient,
    ShouldRefresh? shouldRefresh,
  })  : _onRefreshToken = onRefreshToken,
        _handleTokenHeaderBuilder = handleTokenHeaderBuilder,
        _onShouldRefresh = shouldRefresh ?? shouldRefreshDefault,
        _dio = httpClient ?? Dio() {
    this.tokenStorage = tokenStorage;
  }

  final Dio _dio;
  final TokenHeaderBuilder<T> _handleTokenHeaderBuilder;
  final RefreshToken<T> _onRefreshToken;
  final ShouldRefresh _onShouldRefresh;

  bool _isRefreshing = false;
  final List<_RetryRequest> _failedRequests = <_RetryRequest>[];

  /// Intercepts failed requests due to token expiration and refreshes the token.
  ///
  /// This method checks if the error is related to token expiration. If so, it initiates the
  /// token refresh process, then retries the failed request with the new token. If the token
  /// is already being refreshed, it queues the request until the token is available.
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final Response<dynamic>? response = err.response;

    // If no response, no token, or another refresh error, proceed with the error handling.
    if (response == null ||
        await token == null ||
        err.error is UnexpectedTokenRefreshNetworkError ||
        !_onShouldRefresh(response)) {
      handler.next(err);
      return;
    }

    if (_isRefreshing) {
      // Queue the request until the token refresh is completed.
      final Completer<Response<dynamic>> completer =
          Completer<Response<dynamic>>();
      _failedRequests.add(_RetryRequest(err.requestOptions, completer));
      try {
        final Response<dynamic> response = await completer.future;
        handler.resolve(response);
      } on DioException catch (exception) {
        handler.next(
          DioException(
            requestOptions: exception.requestOptions,
            response: exception.response,
            error: exception,
          ),
        );
      } catch (exception) {
        handler.next(
            DioException(requestOptions: err.requestOptions, error: exception));
      }
    } else {
      _isRefreshing = true;
      try {
        // Refresh the token and retry the failed requests.
        final T newToken = await _onRefreshToken(dio: _dio, token: await token);
        await setToken(newToken);
        await _retryFailedRequests(newToken);
        final Response<dynamic> retryResponse =
            await _retryRequest(err.requestOptions, newToken);
        handler.resolve(retryResponse);
      } on UnexpectedTokenRefreshNetworkError catch (exception) {
        await clearToken();
        _rejectFailedRequests(exception);
        handler.next(
            DioException(requestOptions: err.requestOptions, error: exception));
      } on DioException catch (exception) {
        _rejectFailedRequests(exception);
        handler.next(
          DioException(
            requestOptions: exception.requestOptions,
            response: exception.response,
            error: exception,
          ),
        );
      } catch (exception) {
        _rejectFailedRequests(exception);
        handler.next(
            DioException(requestOptions: err.requestOptions, error: exception));
      } finally {
        _isRefreshing = false;
      }
    }
  }

  /// Intercepts outgoing requests and attaches the token if available.
  ///
  /// This method adds the stored token to the headers of each outgoing request.
  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final T? currentToken = await token;
    final RequestOptions requestOptions = options;
    final Map<String, String> headers = currentToken == null
        ? const <String, String>{}
        : _handleTokenHeaderBuilder(currentToken);
    requestOptions.headers = <String, dynamic>{
      ...requestOptions.headers,
      ...headers
    };
    handler.next(requestOptions);
  }

  /// Intercepts incoming responses to refresh the token if needed.
  ///
  /// If the response indicates that the token has expired (e.g., a 401 status code),
  /// this method attempts to refresh the token.
  @override
  Future<dynamic> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    if (await token == null || !_onShouldRefresh(response)) {
      handler.next(response);
      return;
    }
    try {
      final Response<dynamic> refreshResponse = await _tryRefresh(response);
      handler.resolve(refreshResponse);
    } on DioException catch (error) {
      handler.reject(error);
    }
  }

  /// Default implementation for determining if the token should be refreshed.
  ///
  /// By default, the token is refreshed if the response has a 401 status code.
  static bool shouldRefreshDefault(Response<dynamic>? response) {
    return response?.statusCode == 401;
  }

  /// Retry all failed requests after refreshing the token.
  Future<void> _retryFailedRequests(T newToken) async {
    final List<_RetryRequest> requests =
        List<_RetryRequest>.of(_failedRequests);
    _failedRequests.clear();
    for (final _RetryRequest request in requests) {
      try {
        final Response<dynamic> response =
            await _retryRequest(request.options, newToken);
        request.completer.complete(response);
      } catch (error) {
        request.completer.completeError(error);
      }
    }
  }

  /// Retry a single failed request with the refreshed token.
  Future<Response<dynamic>> _retryRequest(
      RequestOptions requestOptions, T token) {
    _dio.options.baseUrl = requestOptions.baseUrl;
    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      cancelToken: requestOptions.cancelToken,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers
          ..addAll(_handleTokenHeaderBuilder(token)),
      ),
    );
  }

  /// Reject all queued requests with the provided error.
  void _rejectFailedRequests(Object error) {
    for (final _RetryRequest request in _failedRequests) {
      request.completer.completeError(error);
    }
    _failedRequests.clear();
  }

  /// Attempts to refresh the token and retry the request that triggered the refresh.
  Future<Response<dynamic>> _tryRefresh(Response<dynamic> response) async {
    final T refreshedToken;
    try {
      refreshedToken = await _onRefreshToken(dio: _dio, token: await token);
    } on UnexpectedTokenRefreshNetworkError catch (error) {
      await clearToken();
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: error,
      );
    }

    await setToken(refreshedToken);
    final Map<String, dynamic> newHeaders = <String, dynamic>{
      ...response.requestOptions.headers,
      ..._handleTokenHeaderBuilder(refreshedToken),
    };

    return _dio.request<dynamic>(
      response.requestOptions.path,
      options: Options(
        method: response.requestOptions.method,
        headers: newHeaders,
      ),
    );
  }
}
