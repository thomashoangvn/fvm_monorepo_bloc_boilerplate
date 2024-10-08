// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:async';

import 'package:infrastructure/_core/commons/enums/auth_status.enum.dart';
import 'package:infrastructure/storage/file_storage/i_file_storage.dart';

/// A mixin to handle token storage, retrieval, and authentication status
/// management. This mixin abstracts the storage of token-like objects and
/// allows you to work with an authentication state that is broadcasted via
/// a stream.
///
/// [T] represents the token type (e.g., [TokenModel]).
mixin TokenFileStorageMixin<T> {
  /// A [StreamController] to broadcast changes in authentication status.
  final StreamController<AuthStatusEnum> _controller =
      StreamController<AuthStatusEnum>.broadcast()..add(AuthStatusEnum.initial);

  /// The current authentication status.
  AuthStatusEnum _authStatus = AuthStatusEnum.initial;

  /// The current token stored in memory.
  T? _token;

  /// The storage mechanism for storing tokens.
  IFileStorage<T>? _tokenStorage;

  /// Retrieves the token asynchronously. If the authentication status is
  /// not [AuthStatusEnum.initial], the cached token is returned.
  ///
  /// Otherwise, waits for the auth status to update and returns the token.
  Future<T?> get token async {
    if (_authStatus != AuthStatusEnum.initial) {
      return _token;
    }
    await authStatus.first;
    return _token;
  }

  /// A stream of the current authentication status.
  Stream<AuthStatusEnum> get authStatus async* {
    yield _authStatus;
    yield* _controller.stream;
  }

  /// Clears the stored token and updates the authentication status to unauthenticated.
  Future<void> clearToken() async {
    await _tokenStorage?.delete();
    _updateStatus(null);
  }

  /// Closes the stream controller.
  Future<void> close() => _controller.close();

  /// Revokes the stored token and updates the authentication status to unauthenticated.
  Future<void> revokeToken() async {
    await _tokenStorage?.delete();
    if (_authStatus != AuthStatusEnum.unauthenticated) {
      _authStatus = AuthStatusEnum.unauthenticated;
      _controller.add(_authStatus);
    }
  }

  /// Sets the token and stores it. If the token is `null`, it clears the stored token.
  Future<void> setToken(T? value) async {
    if (value == null) {
      return clearToken();
    }
    await _tokenStorage?.write(value);
    _updateStatus(value);
  }

  /// Sets the token storage mechanism and initializes the stored token.
  set tokenStorage(IFileStorage<T> value) {
    _tokenStorage = value;
    unawaited(_initTokenStorage());
  }

  /// Initializes the token storage by reading the stored token and updating the status.
  Future<void> _initTokenStorage() async {
    final T? result = await _tokenStorage?.read();
    _updateStatus(result);
  }

  /// Updates the authentication status based on the provided token.
  void _updateStatus(T? newToken) {
    _authStatus = newToken == null
        ? AuthStatusEnum.unauthenticated
        : AuthStatusEnum.authenticated;
    _token = newToken;
    _controller.add(_authStatus);
  }
}
