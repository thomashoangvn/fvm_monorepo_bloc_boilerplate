// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-single-declaration-per-file

import 'package:deps/packages/freezed_annotation.dart';

part 'user.model.freezed.dart';
part 'user.model.g.dart';

/// `UserModel` represents the user entity with fields for ID, first name,
/// optional last name, phone number, email, and username.
/// It is built using the `freezed` package for immutability and offers
/// JSON serialization capabilities.
///
/// ### Fields:
/// - `id` (required): The unique identifier for the user.
/// - `firstName` (required): The user's first name.
/// - `lastName` (optional): The user's last name.
/// - `phoneNumber` (optional): The user's phone number.
/// - `email` (optional): The user's email address.
/// - `username` (optional): The user's username.
///
/// ### Factory Constructors:
/// - `UserModel.fromJson(Map<String, dynamic> json)`: Deserializes the user data from JSON.
/// - `UserModel.empty()`: Creates an empty user model, where only the `id` and `firstName` fields are initialized with default empty values.
///
/// ### Additional Features:
/// - **isNotEmpty**: A utility getter that checks if the model is not empty.
///
/// ### Example:
/// ```dart
/// final user = UserModel(
///   id: '123',
///   firstName: 'John',
///   lastName: 'Doe',
///   email: 'john.doe@example.com',
/// );
///
/// final json = user.toJson(); // Serialize to JSON
/// final newUser = UserModel.fromJson(json); // Deserialize from JSON
///
/// if (user.isNotEmpty) {
///   print('User is valid');
/// }
/// ```

@freezed
class UserModel with _$UserModel {
  /// The default factory constructor for `UserModel`.
  /// `id` and `firstName` are required fields, while others are optional.
  const factory UserModel({
    required String id,
    required String firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    String? username,
  }) = _UserModel;

  /// Private constructor used by Freezed to implement immutability.
  const UserModel._();

  /// Factory method for deserializing `UserModel` from JSON.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Provides an empty/default instance of `UserModel` with default values.
  /// This is useful when you need a default or uninitialized user model.
  factory UserModel.empty() => const UserModel(id: '', firstName: '');

  /// A utility getter that checks if the user model is not empty.
  /// Compares the instance with the result of `UserModel.empty()`.
  bool get isNotEmpty => this != UserModel.empty();
}
