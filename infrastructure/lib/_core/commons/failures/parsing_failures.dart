// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:infrastructure/_core/commons/enums/failure_tag.enum.dart';
import 'package:infrastructure/_core/commons/enums/failure_type.enum.dart';
import 'package:infrastructure/analytics/failure/failure.dart';

/// A specific failure class for handling errors related to API response parsing.
///
/// This error occurs when an unexpected issue arises during the parsing of an API response
/// into the expected output type.
class ApiResponseParsingError extends Failure {
  ApiResponseParsingError({super.exception, super.stack})
      : super(
          code: 'api-response-parsing-error',
          type: FailureTypeEnum.error,
          tag: FailureTagEnum.operation,
          message:
              'An unexpected error occurred while parsing the API response for the desired (O)utput type.',
        );
}
