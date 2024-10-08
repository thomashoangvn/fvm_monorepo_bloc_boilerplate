// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:infrastructure/_core/commons/enums/failure_tag.enum.dart';
import 'package:infrastructure/_core/commons/enums/failure_type.enum.dart';
import 'package:infrastructure/analytics/failure/failure.dart';

/// Represents a failure that occurs when there is no network connection.
class NoNetworkFailure extends Failure {
  NoNetworkFailure({super.exception, super.stack})
      : super(
          code: 'no-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              'No network connection. Please check your internet connection and try again.',
        );
}

/// Represents a failure that occurs when a network request times out.
class TimeoutNetworkFailure extends Failure {
  TimeoutNetworkFailure({super.exception, super.stack})
      : super(
          code: 'timeout-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              'The network request timed out. Please check your connection and try again.',
        );
}

/// Represents a failure that occurs when a request is formatted incorrectly.
class BadRequestNetworkFailure extends Failure {
  BadRequestNetworkFailure({super.exception, super.stack})
      : super(
          code: 'bad-request-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              'The request was not formatted correctly. Please check the request format and try again.',
        );
}

/// Represents a failure when access to a resource is unauthorized.
class UnauthorizedNetworkFailure extends Failure {
  UnauthorizedNetworkFailure({super.exception, super.stack})
      : super(
          code: 'unauthorized-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              'Attempted to access a restricted resource without proper authorization.',
        );
}

/// Represents a failure that occurs when access to a resource is forbidden.
class ForbiddenNetworkFailure extends Failure {
  ForbiddenNetworkFailure({super.exception, super.stack})
      : super(
          code: 'forbidden-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              'Request was valid but server is refusing action. Please check your permissions and try again.',
        );
}

/// Represents a failure when the requested resource cannot be found.
class NotFoundNetworkFailure extends Failure {
  NotFoundNetworkFailure({super.exception, super.stack})
      : super(
          code: 'not-found-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              'The requested resource could not be found. Please check the URL and try again.',
        );
}

/// Represents a failure when the server takes too long to process a request.
class RequestTimeoutNetworkFailure extends Failure {
  RequestTimeoutNetworkFailure({super.exception, super.stack})
      : super(
          code: 'request-timeout-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              'The server timed out waiting for the request. Please attempt to reconnect and try again.',
        );
}

/// Represents a failure when too many requests are made in a short time.
class TooManyRequestsNetworkFailure extends Failure {
  TooManyRequestsNetworkFailure({super.exception, super.stack})
      : super(
          code: 'too-many-requests-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              'Too many requests in a given time. Please wait before trying again.',
        );
}

/// Represents a failure when the server encounters an internal error.
class InternalServerNetworkFailure extends Failure {
  InternalServerNetworkFailure({super.exception, super.stack})
      : super(
          code: 'internal-server-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              'The server encountered an unexpected condition. Please try again later.',
        );
}

/// Represents a general server-side error.
class ServerErrorNetworkFailure extends Failure {
  ServerErrorNetworkFailure({super.exception, super.stack})
      : super(
          code: 'server-error-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              'The server encountered a condition that prevented it from fulfilling the request. Please try again later.',
        );
}

/// Represents a failure due to client-side errors.
class ClientErrorNetworkFailure extends Failure {
  ClientErrorNetworkFailure({super.exception, super.stack})
      : super(
          code: 'client-error-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              'A client error occurred. Please check the request and try again.',
        );
}

/// Represents a failure when the connection to the server times out.
class ConnectionTimeoutNetworkFailure extends Failure {
  ConnectionTimeoutNetworkFailure({super.exception, super.stack})
      : super(
          code: 'connection-timeout-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              'The connection timed out. Please check your network settings and try again.',
        );
}

/// Represents a failure when the request to the server times out while sending data.
class SendTimeoutNetworkFailure extends Failure {
  SendTimeoutNetworkFailure({super.exception, super.stack})
      : super(
          code: 'send-timeout-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              'The request timed out while sending data. Please check your connection and try again.',
        );
}

/// Represents a failure when the server takes too long to respond.
class ReceiveTimeoutNetworkFailure extends Failure {
  ReceiveTimeoutNetworkFailure({super.exception, super.stack})
      : super(
          code: 'receive-timeout-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              'The server took too long to respond. Please check your connection and try again.',
        );
}

/// Represents a failure when the server certificate is not valid.
class BadCertificateNetworkFailure extends Failure {
  BadCertificateNetworkFailure({super.exception, super.stack})
      : super(
          code: 'bad-certificate-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              "The server certificate is not valid. Please check the server's certificate and try again.",
        );
}

/// Represents a failure when the server responds with an unexpected format or status code.
class BadResponseNetworkFailure extends Failure {
  BadResponseNetworkFailure({super.exception, super.stack})
      : super(
          code: 'bad-response-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              'The server responded with an unexpected format or status code. Please check the response and try again.',
        );
}

/// Represents a failure when a network request is cancelled.
class RequestCancelNetworkFailure extends Failure {
  RequestCancelNetworkFailure({super.exception, super.stack})
      : super(
          code: 'request-cancel-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message: 'The request was cancelled. Please try again.',
        );
}

/// Represents a failure when there is an issue connecting to the server.
class ConnectionNetworkFailure extends Failure {
  ConnectionNetworkFailure({super.exception, super.stack})
      : super(
          code: 'connection-network-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.network,
          message:
              'Failed to connect to the server. Please check your network connection and try again.',
        );
}
