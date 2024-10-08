part of '../auth.cubit.dart';

/// `AuthState` represents the different states of the authentication process.
/// These states are sealed using the `freezed` package for immutability and pattern matching.
@freezed
sealed class AuthState with _$AuthState {
  /// Represents the state when an authentication operation is in progress.
  const factory AuthState.loading() = AuthStateLoading;

  /// Represents the state when an authentication operation has failed.
  /// Contains a [Failure] object to describe the failure reason.
  const factory AuthState.failed(Failure failure) = AuthStateFailed;

  /// Represents the state when the user is unauthenticated.
  const factory AuthState.unauthenticated() = AuthStateUnauthenticated;

  /// Represents the state when the user is successfully authenticated.
  const factory AuthState.authenticated() = AuthStateAuthenticated;
}
