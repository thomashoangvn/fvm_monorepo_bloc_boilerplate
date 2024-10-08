// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/hydrated_bloc.dart';
import 'package:deps/packages/injectable.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/_core/_i18n/translations.g.dart';

/// A `Cubit` class responsible for managing locale (language) state in the application.
///
/// This class extends `HydratedCubit<Locale>` to persist the locale across app restarts.
/// It uses `HydratedCubit` to automatically save and restore the selected locale from storage.
///
/// The `@lazySingleton` annotation ensures that this class is registered as a singleton and
/// can be injected throughout the app, meaning that only one instance will be created.
@lazySingleton
class TranslationsCubit extends HydratedCubit<Locale> {
  /// Initializes the `TranslationsCubit` with the device's locale by default.
  ///
  /// The initial locale is determined using `AppLocaleUtils.findDeviceLocale()`, which
  /// fetches the device's locale and converts it into a Flutter `Locale` object.
  TranslationsCubit() : super(AppLocaleUtils.findDeviceLocale().flutterLocale);

  /// Deserializes the stored locale from JSON when the app is restarted.
  ///
  /// If the `locale` key is present in the JSON map, it is used to create a `Locale` object.
  /// Otherwise, it returns `null`, meaning no locale is restored.
  @override
  Locale? fromJson(Map<String, dynamic> json) {
    return json['locale'] == null ? null : Locale(json['locale']);
  }

  /// Serializes the current locale to JSON for storage.
  ///
  /// The locale is stored as a string, which is later used for restoring the locale state
  /// after app restarts.
  @override
  Map<String, dynamic> toJson(Locale state) {
    return <String, String>{'locale': state.toString()};
  }

  /// Sets the application's locale to English and emits the new locale state.
  ///
  /// This method updates the locale state to `AppLocale.en`, which corresponds to English.
  void setEN() => emit(AppLocale.en.flutterLocale);

  /// Sets the application's locale to Turkish and emits the new locale state.
  ///
  /// This method updates the locale state to `AppLocale.tr`, which corresponds to Turkish.
  void setTR() => emit(AppLocale.tr.flutterLocale);
}
