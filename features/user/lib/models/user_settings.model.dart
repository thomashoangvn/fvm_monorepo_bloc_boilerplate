// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/freezed_annotation.dart';

part 'user_settings.model.freezed.dart';
part 'user_settings.model.g.dart';

/// The `UserSettingsModel` class is a data model representing user-specific
/// settings, including language preferences, locale, and timezone. It utilizes
/// the `freezed` package for immutable data structures and provides built-in
/// support for JSON serialization.
///
/// ### Fields:
/// - `languageCode` (required): The language code for the user's preferred language, e.g., 'en', 'tr'.
/// - `locale` (required): The user's locale, e.g., 'en-US', 'tr-TR'.
/// - `timeZone` (required): The user's time zone in the ISO format, e.g., '+03:00'.
///
/// ### Features:
/// - **Immutability**: The `freezed` package ensures that instances of this class are immutable.
/// - **JSON Serialization**: Provides factory methods for JSON serialization/deserialization.
///
/// ### Example:
/// ```dart
/// final settings = UserSettingsModel(
///   languageCode: 'en',
///   locale: 'en-US',
///   timeZone: '-05:00',
/// );
///
/// final json = settings.toJson(); // Serialize to JSON
/// final newSettings = UserSettingsModel.fromJson(json); // Deserialize from JSON
/// ```
///
/// ### Factory Constructors:
/// - `UserSettingsModel.fromJson(Map<String, dynamic> json)`: Deserializes from JSON.
/// - `UserSettingsModel.empty()`: Provides a default instance with predefined settings.
@freezed
class UserSettingsModel with _$UserSettingsModel {
  /// The default factory constructor for `UserSettingsModel`.
  /// All fields are required and must be provided.
  const factory UserSettingsModel({
    required String languageCode,
    required String locale,
    required String timeZone,
  }) = _UserSettingsModel;

  /// Factory method for deserializing `UserSettingsModel` from JSON.
  factory UserSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsModelFromJson(json);

  /// Provides an empty/default instance of `UserSettingsModel` with predefined values.
  /// Default language is Turkish ('tr'), locale is 'tr-TR', and time zone is '+03:00'.
  factory UserSettingsModel.empty() => const UserSettingsModel(
        languageCode: 'tr',
        locale: 'tr-TR',
        timeZone: '+03:00',
      );
}
