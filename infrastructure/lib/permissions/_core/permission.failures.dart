// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-match-file-name, prefer-single-declaration-per-file

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:infrastructure/_core/_i18n/infrastructure_i18n_cubit_locale.ext.dart';
import 'package:infrastructure/_core/_i18n/translations.g.dart';

/// A failure that occurs when an unknown error is encountered during a permission request.
///
/// This failure class is used to handle unexpected errors that occur when
/// requesting a permission, with the exact cause not being recognized.
///
/// - [exception]: The underlying exception that caused the error (optional).
/// - [stack]: The stack trace of the error (optional).
class UnknownPermissionRequestError extends Failure {
  UnknownPermissionRequestError({super.exception, super.stack})
      : super(
          code: 'unknown-permission-request-error',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.permission,
          message:
              $.tr.infrastructure.permissions.failures.unknownPermissionRequest,
        );
}

/// A failure that occurs when an invalid or unsupported permission type is requested.
///
/// This failure is thrown when an invalid or unrecognized [PermissionTypeEnum]
/// is used in a permission request, helping developers identify incorrect or
/// unsupported permission types.
///
/// - [type]: The invalid permission type that was requested.
/// - [exception]: The underlying exception that caused the error (optional).
/// - [stack]: The stack trace of the error (optional).
class InvalidPermissionTypeFailure extends Failure {
  InvalidPermissionTypeFailure(
      {required PermissionTypeEnum type, super.exception, super.stack})
      : super(
          code: 'invalid-permission-failure',
          type: FailureTypeEnum.exception,
          tag: FailureTagEnum.permission,
          message: $.tr.infrastructure.permissions.failures
              .invalidPermissionType(type: type),
        );
}
