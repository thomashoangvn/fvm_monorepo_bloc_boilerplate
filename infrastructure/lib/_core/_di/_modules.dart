// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

part of '_di.dart';

/// A module providing the `Talker` instance for logging in the application.
///
/// This module uses `TalkerFlutter` for logging with custom settings such as
/// max line width and a custom formatter (`FancyTalkerLogFormatter`).
///
/// The `@module` annotation is used by `Injectable` to automatically
/// register this dependency in the DI system.
@module
abstract class TalkerModule {
  /// Provides an initialized `Talker` instance for logging purposes.
  Talker get talker => TalkerFlutter.init(
        logger: TalkerLogger(
          settings: TalkerLoggerSettings(maxLineWidth: 100),
          formatter: FancyTalkerLogFormatter(),
        ),
      );
}

/// A module providing the `Dio` instance for HTTP requests.
///
/// This module registers `Dio` as a dependency, which can be injected
/// wherever HTTP requests are needed within the application.
@module
abstract class DioModule {
  /// Provides an initialized `Dio` instance for making HTTP requests.
  Dio get dio => Dio();
}

/// A module providing the `InternetConnection` instance for checking network status.
///
/// This module registers `InternetConnection`, used for monitoring network
/// connectivity within the application.
@module
abstract class InternetConnectionModule {
  /// Provides an initialized `InternetConnection` instance to check internet connectivity.
  InternetConnection get internetConnection => InternetConnection();
}

/// A module providing the `FlutterSecureStorage` instance for secure key-value storage.
///
/// This module registers `FlutterSecureStorage`, used for securely storing
/// sensitive information, such as tokens and credentials, with encryption.
@module
abstract class FlutterSecureStorageModule {
  /// Provides an initialized `FlutterSecureStorage` instance with encrypted shared preferences.
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      );
}

/// A module providing application information via `PackageInfo`.
///
/// This module registers `PackageInfo`, which can be used to retrieve information
/// about the app, such as version, build number, etc. The `@preResolve` annotation
/// ensures that the `PackageInfo` is asynchronously fetched and ready before being injected.
@module
abstract class AppInformationModule {
  /// Asynchronously retrieves app information from the platform.
  @preResolve
  Future<PackageInfo> get appInformation => PackageInfo.fromPlatform();
}
