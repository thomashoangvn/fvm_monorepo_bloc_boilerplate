// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:convert';

import 'package:deps/packages/flutter_secure_storage.dart';
import 'package:deps/packages/injectable.dart';
import 'package:infrastructure/networking/models/token.model.dart';
import 'package:infrastructure/storage/file_storage/i_file_storage.dart';

/// An implementation of [IFileStorage] for securely storing the [TokenModel]
/// in the device's secure storage. This class uses [FlutterSecureStorage]
/// to store, read, and delete token data in a secure manner.
///
/// The data is stored as a JSON string, which can be encrypted and stored
/// using platform-specific secure storage mechanisms such as the iOS Keychain
/// and Android Keystore.
@LazySingleton(as: IFileStorage<TokenModel>)
class SecureTokenFileStorage extends IFileStorage<TokenModel> {
  /// Constructs a [SecureTokenFileStorage] with a given [FlutterSecureStorage]
  /// instance.
  SecureTokenFileStorage(this._secureStorage);

  /// The key under which the token data is stored in secure storage.
  final String _key = 'secure_token_storage';

  /// The secure storage mechanism used to store the token.
  final FlutterSecureStorage _secureStorage;

  /// Deletes the stored token from secure storage.
  @override
  Future<void> delete() async {
    await _secureStorage.delete(key: _key);
  }

  /// Reads the stored token from secure storage.
  ///
  /// Returns a [TokenModel] if the token is successfully retrieved and
  /// deserialized. Returns `null` if no token is found or if an error occurs.
  @override
  Future<TokenModel?> read() async {
    try {
      final String? token = await _secureStorage.read(key: _key);

      if (token != null) {
        return TokenModel.fromJson(jsonDecode(token));
      }

      return null;
    } catch (exception) {
      return null;
    }
  }

  /// Writes the [TokenModel] to secure storage after converting it to a JSON string.
  @override
  Future<void> write(TokenModel value) async {
    await _secureStorage.write(key: _key, value: jsonEncode(value.toJson()));
  }
}
