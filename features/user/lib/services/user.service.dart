// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: always_specify_types

import 'package:deps/features/features.dart';
import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/fpdart.dart';
import 'package:deps/packages/injectable.dart';

/// A service class for handling user-related operations such as fetching
/// user details from the backend.
///
/// The class uses the `IApiClient` to make API calls and returns the result
/// wrapped in an `AsyncEither`, where it can either return a successful
/// `UserModel` or a `Failure`.
///
/// ### Example:
/// ```dart
/// final response = await _service.getUserDetails();
///
/// response.fold(
///   (failure) => print('Failed to fetch user details: $failure'),
///   (user) => print('User details: $user'),
/// );
/// ```

@lazySingleton
class UserService {
  /// Constructor for `UserService` which requires an instance of `IApiClient`.
  const UserService(this._client);

  /// The API client used for making requests.
  final IApiClient _client;

  /// Fetches user details from the `/details` endpoint.
  ///
  /// The method returns an `AsyncEither` which will either return a `Failure`
  /// in case of an error, or a `UserModel` if the request is successful.
  ///
  /// ### Example usage:
  /// ```dart
  /// final Either<Failure, UserModel> response = await _service.getUserDetails();
  /// ```
  ///
  /// The API call uses a GET request to the `/details` endpoint, and the
  /// response is expected to be deserialized into a `UserModel`.
  AsyncEither<UserModel> getUserDetails() async {
    // Makes an API call to fetch user details and map the result to a UserModel.
    final Either<Failure, UserModel> response =
        await _client.invoke<void, UserModel>(
      '/details',
      RequestTypeEnum.get,
      fromJson: UserModel.fromJson,
    );

    // Processes the response, either returning a Failure or a successful UserModel.
    return response.fold(
      Left.new,
      (UserModel user) async => Right(user),
    );
  }
}
