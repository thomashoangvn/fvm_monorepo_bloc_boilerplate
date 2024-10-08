// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

part of '../user.cubit.dart';

/// Represents the various states of the user's authentication and session status.
///
/// - `initial`: The initial state before any user data is loaded.
/// - `loading`: The state when the user data is being loaded.
/// - `unauthenticated`: Indicates the user is not authenticated.
/// - `fetchingUserDetails`: The state where user details are being retrieved.
/// - `authenticated`: The user is authenticated and ready to use the application.
enum UserStateStatus {
  initial,
  loading,
  unauthenticated,
  fetchingUserDetails,
  // TODO: Other additional steps can be added here.
  authenticated,
}

/// Represents the state of the user, containing the status of the authentication,
/// the user details, any failure that occurred, and whether the process failed.
///
/// This class is sealed and generated using `freezed` to provide immutability and pattern matching capabilities.
@freezed
sealed class UserState with _$UserState {
  /// Constructor for the `UserState` which includes:
  /// - [status]: Represents the current status of the user session.
  /// - [user]: Holds the details of the user.
  /// - [isFailed]: A flag indicating whether the process has failed.
  /// - [failure]: Contains the failure information in case of an error.
  const factory UserState({
    required UserStateStatus status,
    required UserModel user,
    required bool isFailed,
    required Failure failure,
  }) = _UserState;

  /// Deserializes a `UserState` object from a JSON map.
  factory UserState.fromJson(Map<String, dynamic> json) =>
      _$UserStateFromJson(json);

  /// Creates the initial state for the `UserState`, where:
  /// - [status] is set to `UserStateStatus.initial`.
  /// - [user] is initialized as an empty user.
  /// - [isFailed] is set to `false`.
  /// - [failure] is set to an empty `Failure`.
  factory UserState.initial() => UserState(
        status: UserStateStatus.initial,
        user: UserModel.empty(),
        isFailed: false,
        failure: Failure.empty(),
      );
}
