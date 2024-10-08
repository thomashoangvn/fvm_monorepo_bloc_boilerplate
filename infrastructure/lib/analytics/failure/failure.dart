// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/locator/locator.dart';
import 'package:infrastructure/analytics/observers/i_failure_observer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'failure.g.dart';

/// `Failure` class represents an error or an exceptional case in the app.
///
/// It captures details such as the error code, message, tag, and type.
/// Additionally, it can hold an exception and a stack trace for further analysis.
@JsonSerializable()
class Failure implements Exception {
  Failure({
    required this.code,
    required this.message,
    required this.tag,
    required this.type,
    dynamic exception,
    this.stack,
  })  : exception = (type == FailureTypeEnum.exception)
            ? (exception ??
                (throw ArgumentError(
                    'Exception must be provided for FailureTypeEnum.exception.')))
            : exception,
        _failureObserver = locator<IFailureObserver>() {
    if (type == FailureTypeEnum.error) {
      _failureObserver.onFailure(this);
    }
  }

  /// Factory constructor for generating a `Failure` instance from JSON.
  factory Failure.fromJson(Map<String, dynamic> json) =>
      _$FailureFromJson(json);

  /// Converts the current `Failure` instance to JSON.
  Map<String, dynamic> toJson() => _$FailureToJson(this);

  /// Factory constructor for creating an empty `Failure` instance.
  factory Failure.empty() => Failure(
        code: '',
        message: '',
        tag: FailureTagEnum.empty,
        type: FailureTypeEnum.empty,
      );

  /// Error code related to the failure.
  final String code;

  /// Exception associated with the failure, if applicable.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final dynamic exception;

  /// Error message providing details about the failure.
  final String message;

  /// Stack trace associated with the failure.
  @StackTraceConverter()
  final StackTrace? stack;

  /// Tag categorizing the failure.
  final FailureTagEnum tag;

  /// Type of failure (exception or error).
  final FailureTypeEnum type;

  /// Observer that handles failure events and logs them.
  final IFailureObserver _failureObserver;

  @override
  String toString() => message;

  /// Returns true if this failure instance is empty.
  bool get isEmpty => type == FailureTypeEnum.empty;
}

/// Custom converter for serializing and deserializing `StackTrace` objects in JSON.
class StackTraceConverter implements JsonConverter<StackTrace?, String?> {
  const StackTraceConverter();

  @override
  StackTrace? fromJson(String? json) {
    if (json == null) {
      return null;
    }
    return StackTrace.fromString(json);
  }

  @override
  String? toJson(StackTrace? object) {
    return object?.toString();
  }
}
