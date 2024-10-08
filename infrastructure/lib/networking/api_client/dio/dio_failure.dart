// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/dio.dart';
import 'package:infrastructure/analytics/failure/failure.dart';

/// A custom exception class for handling failures in Dio-based HTTP requests.
///
/// [DioFailure] extends [DioException], encapsulating a [Failure] object. This
/// class is useful for managing custom error handling in network operations,
/// allowing the app to gracefully handle different types of failures.
class DioFailure extends DioException {
  /// Constructs a [DioFailure] with the given [failure] and [requestOptions].
  ///
  /// * [failure]: The [Failure] object representing the specific failure that occurred.
  /// * [requestOptions]: The options that were set on the Dio request that triggered the failure.
  DioFailure({required this.failure, required super.requestOptions})
      : super(error: failure);

  /// The [Failure] instance encapsulating details about the failure.
  final Failure failure;
}
