// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-match-file-name

import 'package:deps/infrastructure/infrastructure.dart';

/// [ExampleAuthFailure] represents a failure case that occurs during an example
/// authentication process. It extends the [Failure] class and categorizes this
/// failure as an authentication-related error.
///
/// This class is useful for identifying specific authentication failures, enabling
/// better error handling and troubleshooting.
///
/// Example usage:
/// ```dart
/// try {
///   // Example authentication logic
/// } catch (e, stack) {
///   throw ExampleAuthFailure(exception: e, stack: stack);
/// }
/// ```
class ExampleAuthFailure extends Failure {
  /// Creates an instance of [ExampleAuthFailure].
  ///
  /// - [exception]: The original exception that triggered the failure.
  /// - [stack]: The stack trace when the failure occurred.
  ///
  /// The failure is initialized with a specific message, code, and failure type,
  /// indicating that it is related to an authentication failure scenario.
  ExampleAuthFailure({super.exception, super.stack})
      : super(
          code: 'example-auth-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.authentication,
          message: 'We encountered a failure while authenticating.',
        );
}
