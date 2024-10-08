// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: avoid-dynamic

import 'package:deps/packages/reactive_forms.dart';

/// The `LoginForm` class is responsible for managing the login form
/// which includes `username` and `password` fields.
/// This form uses the `Reactive Forms` package for handling state and validation.
abstract final class LoginForm {
  /// A reactive form group that contains two fields: `username` and `password`.
  /// - **`username`**: A `FormControl<String>` that is initialized with a default value of `test`.
  ///   - Validators:
  ///     - `RequiredValidator()`: Ensures the username field is not left empty.
  ///
  /// - **`password`**: A `FormControl<String>` that is initialized with a default value of `test`.
  ///   - Validators:
  ///     - `RequiredValidator()`: Ensures the password field is not left empty.
  static final FormGroup form = FormGroup(<String, AbstractControl<String>>{
    'username': FormControl<String>(
      value: 'test',
      validators: const <Validator<dynamic>>[RequiredValidator()],
    ),
    'password': FormControl<String>(
      value: 'test',
      validators: const <Validator<dynamic>>[RequiredValidator()],
    ),
  });
}
