// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:infrastructure/_core/commons/enums/failure_tag.enum.dart';
import 'package:infrastructure/_core/commons/enums/failure_type.enum.dart';
import 'package:infrastructure/analytics/failure/failure.dart';

/// A failure class for unexpected exceptions that do not fit into other categories.
///
/// This type of failure is used when an unexpected exception occurs during runtime.
class UnexpectedFailure extends Failure {
  UnexpectedFailure({super.exception})
      : super(
          code: 'unexpected-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.uncaught,
          message: 'An unexpected exception occurred.',
        );
}

/// A failure class for unexpected runtime errors that are not exceptions.
///
/// This type of error typically represents unexpected runtime issues that are not categorized as exceptions.
class UnexpectedError extends Failure {
  UnexpectedError({super.exception, super.stack})
      : super(
          code: 'unexpected-error',
          type: FailureTypeEnum.error,
          tag: FailureTagEnum.uncaught,
          message: 'An unexpected error occurred.',
        );
}

/// A failure class representing unexpected errors specifically within the Flutter framework.
///
/// This type of error occurs when a Flutter-specific issue arises during runtime.
class UnexpectedFlutterError extends Failure {
  UnexpectedFlutterError({super.exception, super.stack})
      : super(
          code: 'unexpected-flutter-error',
          type: FailureTypeEnum.error,
          tag: FailureTagEnum.uncaught,
          message: 'An unexpected flutter error occurred.',
        );
}

/// A failure class for unexpected errors that occur at the platform level.
///
/// This type of error occurs when there are platform-specific issues that disrupt normal operation.
class UnexpectedPlatformError extends Failure {
  UnexpectedPlatformError({super.exception, super.stack})
      : super(
          code: 'unexpected-platform-error',
          type: FailureTypeEnum.error,
          tag: FailureTagEnum.uncaught,
          message: 'An unexpected platform error occurred.',
        );
}
