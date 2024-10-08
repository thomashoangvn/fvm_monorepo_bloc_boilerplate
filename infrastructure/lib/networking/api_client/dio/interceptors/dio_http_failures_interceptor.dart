// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/dio.dart';
import 'package:infrastructure/analytics/failure/failure.dart';
import 'package:infrastructure/networking/api_client/dio/dio_failure.dart';
import 'package:infrastructure/networking/failures/network_failures.dart';

/// Interceptor that catches HTTP errors and maps them to custom network failure classes.
///
/// The [DioHttpFailuresInterceptor] extends Dio's [Interceptor] and provides custom
/// error handling for common HTTP status codes (e.g., 400, 401, 404, 500). It converts
/// the errors into `Failure` objects, which can then be processed by the app.
class DioHttpFailuresInterceptor extends Interceptor {
  /// Constructor for [DioHttpFailuresInterceptor].
  ///
  /// This interceptor is stateless, so it can be reused as a constant instance.
  const DioHttpFailuresInterceptor();

  /// Handles HTTP errors by checking the response's status code and mapping it to
  /// appropriate network failure types.
  ///
  /// If the response contains a known error status code, such as 400 or 500, it is
  /// converted into a `Failure` subclass. These failure objects are then wrapped
  /// in a [DioFailure] and passed to the error handler.
  ///
  /// * [err]: The [DioException] containing details about the failed request.
  /// * [handler]: The error handler for this interceptor.
  ///
  /// This method overrides Dio's default [onError] behavior to provide more
  /// specific error handling based on the HTTP status code.
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Extract the HTTP response from the error.
    final Response<dynamic>? response = err.response;

    // Check if the response and status code are available.
    if (response != null && response.statusCode != null) {
      final int statusCode = response.statusCode ?? 0;
      Failure? failure;

      // Map specific HTTP status codes to corresponding Failure types.
      switch (statusCode) {
        case 400:
          failure =
              BadRequestNetworkFailure(exception: err, stack: err.stackTrace);

        case 401:
          failure =
              UnauthorizedNetworkFailure(exception: err, stack: err.stackTrace);

        case 403:
          failure =
              ForbiddenNetworkFailure(exception: err, stack: err.stackTrace);

        case 404:
          failure =
              NotFoundNetworkFailure(exception: err, stack: err.stackTrace);

        case 408:
          failure = RequestTimeoutNetworkFailure(
              exception: err, stack: err.stackTrace);

        case 429:
          failure = TooManyRequestsNetworkFailure(
              exception: err, stack: err.stackTrace);

        case 500:
          failure = InternalServerNetworkFailure(
              exception: err, stack: err.stackTrace);

        case > 400 && < 500:
          failure =
              ClientErrorNetworkFailure(exception: err, stack: err.stackTrace);

        case > 500:
          failure =
              ServerErrorNetworkFailure(exception: err, stack: err.stackTrace);
      }

      // If a failure was identified, reject the request and pass the custom error.
      if (failure != null) {
        handler.reject(
          DioFailure(failure: failure, requestOptions: err.requestOptions),
        );
        return;
      }
    }

    // If no specific failure type matches, proceed with the original error handling.
    handler.next(err);
  }
}
