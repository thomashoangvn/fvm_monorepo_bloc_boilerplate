// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

/// Enum representing the different types of failures that can occur in the application.
enum FailureTypeEnum {
  /// Used to inform the user that the operation is successful.
  constructive,

  /// Used to inform the user that the operation is unsuccessful.
  destructive,

  /// Represents an empty or undefined failure type.
  empty,

  /// General important errors.
  error,

  /// Failures caused by exceptions.
  exception,
}
