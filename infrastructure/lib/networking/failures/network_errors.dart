// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:infrastructure/_core/commons/enums/failure_tag.enum.dart';
import 'package:infrastructure/_core/commons/enums/failure_type.enum.dart';
import 'package:infrastructure/analytics/failure/failure.dart';

/// [UnexpectedNetworkError] represents a network failure when an unexpected
/// error occurs during network operations.
///
/// This failure is typically triggered when the network state is unknown
/// or when a network request fails without specific error handling in place.
class UnexpectedNetworkError extends Failure {
  /// Creates an instance of [UnexpectedNetworkError].
  ///
  /// The [exception] and [stack] can be optionally provided to include more
  /// detailed information about the error.
  UnexpectedNetworkError({super.exception, super.stack})
      : super(
          code: 'unexpected-network-error',
          type: FailureTypeEnum.error,
          tag: FailureTagEnum.network,
          message:
              'An unexpected network error occurred. Please check your connection and try again.',
        );
}

/// [UnexpectedTokenRefreshNetworkError] represents a network failure
/// occurring when the application is trying to refresh the user's authentication token.
///
/// This failure indicates that an error occurred while attempting to
/// refresh the token, and a re-authentication is likely required.
class UnexpectedTokenRefreshNetworkError extends Failure {
  /// Creates an instance of [UnexpectedTokenRefreshNetworkError].
  ///
  /// The [exception] and [stack] parameters allow for the inclusion of more detailed
  /// error information, such as the actual exception or the stack trace.
  UnexpectedTokenRefreshNetworkError({super.exception, super.stack})
      : super(
          code: 'unexpected-token-refresh-network-error',
          type: FailureTypeEnum.error,
          tag: FailureTagEnum.network,
          message:
              'An unexpected error occurred while refreshing the authentication token. '
              'Please re-authenticate and try again.',
        );
}
