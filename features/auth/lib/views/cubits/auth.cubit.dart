// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:async';

import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/fpdart.dart';
import 'package:deps/packages/freezed_annotation.dart';
import 'package:deps/packages/injectable.dart';

part 'auth.cubit.freezed.dart';
part 'states/auth.state.dart';

/// `AuthCubit` manages the authentication flow of the app, handling login, logout,
/// and changes to the user's authentication state. It listens for authentication status
/// changes and communicates with services like `AuthService` and `IApiClient` to manage tokens.
@lazySingleton
class AuthCubit extends Cubit<AuthStatusEnum> {
  AuthCubit(this._client, this._service) : super(AuthStatusEnum.initial) {
    _authStatusListener =
        _client.tokenStorage.authStatus.listen(_onAuthStatusChanged);
  }

  /// Client responsible for network and token operations.
  final IApiClient _client;

  /// Auth service responsible for handling login and logout requests.
  final AuthService _service;

  /// Subscription to the authentication status stream.
  late final StreamSubscription<AuthStatusEnum> _authStatusListener;

  /// Listens for changes in the authentication status and updates the state accordingly.
  void _onAuthStatusChanged(AuthStatusEnum event) {
    if (state != event) {
      switch (event) {
        case AuthStatusEnum.authenticated:
          emit(event);
          $.get<UserCubit>().init();

        case AuthStatusEnum.unauthenticated:
          emit(event);
          $.get<UserCubit>().deinit();

        default:
      }
    }
  }

  /// Handles user login by calling the `AuthService` and managing the token.
  ///
  /// Shows a loading overlay during the process and stores the token upon success.
  /// If the login fails, it shows a failure alert.
  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(AuthStatusEnum.loading);
    await $.overlay.showLoading();

    final Either<Failure, TokenModel> response = await _service.login(
      username: username,
      password: password,
    );

    await response.fold(
      $.toast.showAlert,
      (TokenModel token) async {
        await _client.tokenStorage.setToken(token);
      },
    );
  }

  /// Logs the user out, either by making a backend call or just clearing local tokens.
  ///
  /// This method shows a loading overlay during the process and restores the previous state if the logout fails.
  Future<void> logout({bool useBackend = true}) async {
    if (state != AuthStatusEnum.authenticated) {
      return;
    }

    final AuthStatusEnum previousState = state;
    emit(AuthStatusEnum.loading);
    await $.overlay.showLoading();

    if (useBackend) {
      final TokenModel? tokens = await _client.tokenStorage.token;
      final Either<Failure, void> response =
          await _service.logout(tokens!.idToken);

      response.fold(
        (Failure failure) {
          $.toast.showAlert(failure);
          emit(previousState);
        },
        (_) {
          $.overlay.popOverlay();
          _client.tokenStorage.clearToken();
        },
      );
    } else {
      await $.overlay.popOverlay();
      await _client.tokenStorage.clearToken();
    }
  }

  /// Closes the authentication status listener when the cubit is disposed.
  @override
  Future<void> close() {
    _authStatusListener.cancel();
    return super.close();
  }
}
