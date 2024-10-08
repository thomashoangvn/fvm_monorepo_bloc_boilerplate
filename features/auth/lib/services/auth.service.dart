// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: always_specify_types

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/fpdart.dart';
import 'package:deps/packages/injectable.dart';
import 'package:feature_auth/services/failures/auth.failures.dart';

/// The `AuthService` is responsible for handling user authentication
/// operations, such as logging in and logging out, through the API.
///
/// This class uses `IApiClient` to interact with the backend and
/// returns responses wrapped in `AsyncEither` to ensure proper
/// error handling.
///
/// Example usage:
/// ```dart
/// final Either<Failure, TokenModel> result = await _service.login(username: 'user', password: 'pass');
/// result.fold(
///   (failure) => print('Login failed: $failure'),
///   (token) => print('Login succeeded: $token'),
/// );
/// ```
@lazySingleton
class AuthService {
  /// Constructs the `AuthService` with the required API client.
  AuthService(this._client);

  /// The API client used for making HTTP requests.
  final IApiClient _client;

  /// Attempts to log in with the provided `username` and `password`.
  ///
  /// On success, it returns a `TokenModel` containing the access token,
  /// refresh token, expiration date, and ID token. If the login fails,
  /// it returns an `ExampleAuthFailure`.
  ///
  /// Example usage:
  /// ```dart
  /// final Either<Failure, TokenModel> result = await _service.login(username: 'user', password: 'pass');
  /// ```
  AsyncEither<TokenModel> login({
    required String username,
    required String password,
  }) async {
    try {
      // Mocked successful login response, returning a TokenModel.
      return Right(
        TokenModel(
          accessToken: 'accessToken',
          refreshToken: 'refreshToken',
          expirationDate: DateTime(2100),
          idToken: 'idToken',
        ),
      );
    } catch (exception) {
      // If an error occurs during the login process, it wraps the exception
      // in an `ExampleAuthFailure` and returns it as a `Left` value.
      final ExampleAuthFailure failure =
          ExampleAuthFailure(exception: exception);
      return Left(failure);
    }
  }

  /// Attempts to log out using the provided `idToken`.
  ///
  /// The logout request is sent via a POST request, and the result is wrapped
  /// in an `AsyncEither<void>`. If the logout is successful, it returns a
  /// `Right(null)`, otherwise, it returns a `Failure`.
  ///
  /// Example usage:
  /// ```dart
  /// final Either<Failure, void> result = await _service.logout(idToken);
  /// result.fold(
  ///   (failure) => print('Logout failed: $failure'),
  ///   (_) => print('Logout succeeded'),
  /// );
  /// ```
  AsyncEither<void> logout(String idToken) async {
    // Make an API call to the 'logout' endpoint and handle the response.
    final Either<Failure, bool> response = await _client.invoke<void, bool>(
      'logout',
      RequestTypeEnum.post,
    );

    // Return either a success (Right) or a failure (Left).
    return response.fold(
      Left.new,
      (bool isSucceeded) async {
        return const Right(null);
      },
    );
  }
}
