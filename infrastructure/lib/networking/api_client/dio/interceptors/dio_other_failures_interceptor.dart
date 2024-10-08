// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/locator/locator.dart';
import 'package:deps/packages/dio.dart';
import 'package:infrastructure/_core/commons/enums/connectivity_status.enum.dart';
import 'package:infrastructure/analytics/failure/failure.dart';
import 'package:infrastructure/networking/api_client/dio/dio_failure.dart';
import 'package:infrastructure/networking/connectivity/connectivity.cubit.dart';
import 'package:infrastructure/networking/failures/network_errors.dart';
import 'package:infrastructure/networking/failures/network_failures.dart';

/// Interceptor that handles non-HTTP related failures, such as timeouts, connection issues, etc.
///
/// The [DioOtherFailuresInterceptor] extends Dio's [Interceptor] and provides custom
/// error handling for connection issues, timeouts, certificate errors, and more. It maps
/// these errors to specific `Failure` types.
class DioOtherFailuresInterceptor extends Interceptor {
  /// Constructor for [DioOtherFailuresInterceptor].
  ///
  /// This interceptor is stateless, so it can be reused as a constant instance.
  const DioOtherFailuresInterceptor();

  /// Handles Dio exceptions that are not related to specific HTTP status codes.
  ///
  /// This method overrides Dio's default [onError] behavior to provide more
  /// specific error handling based on the [DioExceptionType]. Each type of
  /// DioException is mapped to a custom [Failure] subclass.
  ///
  /// * [err]: The [DioException] containing details about the failed request.
  /// * [handler]: The error handler for this interceptor.
  ///
  /// It categorizes errors such as timeouts, connection issues, or certificate
  /// problems and maps them to corresponding [Failure] classes.
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    Failure failure;

    // Map DioExceptionType to corresponding Failure classes
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        failure = ConnectionTimeoutNetworkFailure(
            exception: err, stack: err.stackTrace);

      case DioExceptionType.sendTimeout:
        failure =
            SendTimeoutNetworkFailure(exception: err, stack: err.stackTrace);

      case DioExceptionType.receiveTimeout:
        failure =
            ReceiveTimeoutNetworkFailure(exception: err, stack: err.stackTrace);

      case DioExceptionType.badCertificate:
        failure =
            BadCertificateNetworkFailure(exception: err, stack: err.stackTrace);

      case DioExceptionType.badResponse:
        failure =
            BadResponseNetworkFailure(exception: err, stack: err.stackTrace);

      case DioExceptionType.cancel:
        failure =
            RequestCancelNetworkFailure(exception: err, stack: err.stackTrace);

      case DioExceptionType.connectionError:
        failure =
            ConnectionNetworkFailure(exception: err, stack: err.stackTrace);

      // Handle unknown exceptions or uncategorized errors
      case DioExceptionType.unknown:
      default:
        // Check the current connectivity status using the ConnectivityCubit
        final ConnectivityStatusEnum connectivityStatus =
            locator<ConnectivityCubit>().state;

        // If there's no response and the network is disconnected, return NoNetworkFailure
        if (err.response == null &&
            connectivityStatus == ConnectivityStatusEnum.disconnected) {
          failure = NoNetworkFailure(exception: err);
        } else {
          // Otherwise, categorize it as an unexpected network error
          failure =
              UnexpectedNetworkError(exception: err, stack: err.stackTrace);
        }
        break;
    }

    // Reject the request with the custom DioFailure wrapping the mapped Failure
    handler.reject(
      DioFailure(failure: failure, requestOptions: err.requestOptions),
    );
  }
}
