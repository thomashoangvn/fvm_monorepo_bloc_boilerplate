// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/reactive_forms.dart';
import 'package:infrastructure/_core/_i18n/infrastructure_i18n_cubit_locale.ext.dart';
import 'package:infrastructure/infrastructure.dart';

typedef ValidationMessageCallback = String Function(Object? error);

/// The `ReactiveValidators` class provides a set of common validators for Reactive Forms,
/// which are customizable based on the provided context.
abstract final class ReactiveValidators {
  /// Returns a map of common validation messages for form fields.
  ///
  /// This function provides localized error messages for common validation rules like
  /// email, required, max length, and min length. It also accepts additional custom validation messages.
  ///
  /// - [isPreview]: Determines if preview mode is enabled, in which case generic labels will be used instead of full messages.
  /// - [labelText]: The field label, used to reference the field in the validation messages.
  /// - [additionalMessages]: Optionally add extra validation messages.
  ///
  /// Example usage:
  /// ```dart
  /// final validators = ReactiveValidators.getCommonValidators(
  ///   isPreview: false,
  ///   labelText: 'Email',
  /// );
  /// ```
  static Map<String, ValidationMessageCallback> getCommonValidators({
    required bool isPreview,
    required String labelText,
    Map<String, ValidationMessageCallback>? additionalMessages,
  }) {
    return <String, ValidationMessageCallback>{
      // Validation for email format
      ValidationMessage.email: (_) => isPreview
          ? 'Email'
          : $.tr.infrastructure.presentation.validations.email(
              field: labelText.capitalizeFirst,
            ),

      // Validation for max length
      ValidationMessage.maxLength: (Object? error) => isPreview
          ? 'Max length'
          : $.tr.infrastructure.presentation.validations.maxLength(
              field: labelText.capitalizeFirst,
              count: (error as Map<String, dynamic>?)?['requiredLength']
                      ?.toString() ??
                  '',
            ),

      // Validation for min length
      ValidationMessage.minLength: (Object? error) => isPreview
          ? 'Min length'
          : $.tr.infrastructure.presentation.validations.minLength(
              field: labelText.capitalizeFirst,
              count: (error as Map<String, dynamic>?)?['requiredLength']
                      ?.toString() ??
                  '',
            ),

      // Validation for required field
      ValidationMessage.required: (_) => isPreview
          ? 'Required'
          : $.tr.infrastructure.presentation.validations.required(
              field: labelText.capitalizeFirst,
            ),

      // Allows merging of additional custom validation messages
      ...?additionalMessages,
    };
  }
}
