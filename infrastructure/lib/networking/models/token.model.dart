// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/freezed_annotation.dart';

part 'token.model.freezed.dart';
part 'token.model.g.dart';

/// A data class representing an OAuth token, which includes
/// access, refresh, and ID tokens, as well as token type and expiration information.
@freezed
class TokenModel with _$TokenModel {
  /// The main factory constructor for the `TokenModel` class.
  ///
  /// - [accessToken]: The access token required for API requests.
  /// - [refreshToken]: The refresh token used to obtain a new access token.
  /// - [expirationDate]: The date and time when the access token expires.
  /// - [idToken]: The ID token, typically used in identity verification.
  /// - [tokenType]: The type of the token, with a default value of 'Bearer'.
  const factory TokenModel({
    required String accessToken,
    required String refreshToken,
    required DateTime expirationDate,
    required String idToken,
    @Default('Bearer') String tokenType,
  }) = _TokenModel;

  /// Creates an instance of `TokenModel` from a JSON object.
  ///
  /// This factory allows for easy deserialization of the token data from JSON format.
  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);

  /// Creates an initial empty `TokenModel`.
  ///
  /// This factory can be used to instantiate a default or empty `TokenModel`
  /// when no valid token is available.
  factory TokenModel.empty() => TokenModel(
        accessToken: '',
        refreshToken: '',
        expirationDate: DateTime(2100),
        idToken: '',
        tokenType: '',
      );
}
