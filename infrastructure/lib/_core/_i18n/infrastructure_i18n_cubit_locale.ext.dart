// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/_core/_i18n/translations.g.dart';

/// Extension on `Cubit<Locale>` to easily access the infrastructure's i18n (internationalization) functionality.
///
/// This extension provides a convenient way to retrieve the appropriate `Translations` object for the current locale
/// managed by a `Cubit<Locale>`. It uses `AppLocaleUtils.parse` to map the `Locale` to a specific `AppLocale` and
/// then builds the `Translations` object, which contains localized strings for the app.
///
/// Example usage:
/// ```dart
/// final translations = $.tr.infrastructure;
/// ```
extension InfrastructureI18nCubitLocaleExt on Cubit<Locale> {
  /// Retrieves the `Translations` object for the current locale.
  ///
  /// This method maps the `Locale` stored in the cubit's state to an `AppLocale` using `AppLocaleUtils.parse`.
  /// It then builds and returns the corresponding `Translations` object, which provides localized strings
  /// for use in the application.
  Translations get infrastructure =>
      AppLocaleUtils.parse(state.toString()).build();
}
