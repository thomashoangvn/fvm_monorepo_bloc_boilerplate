// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:async';
import 'dart:ui';

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/adaptive_theme.dart';
import 'package:deps/packages/flutter_native_splash.dart';
import 'package:deps/packages/hydrated_bloc.dart';
import 'package:deps/packages/path_provider.dart';
import 'package:deps/packages/talker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/analytics/observers/i_failure_observer.dart';
import 'package:infrastructure/presentation/widgets/_core/error.page.dart';
import 'package:infrastructure/presentation/wrappers/_core/app_settings.dart';
import 'package:infrastructure/presentation/wrappers/_core/observer_settings.dart';

typedef AppWrapperCallback = Widget Function(Widget widget);
typedef MainCallback = Future<void> Function(WidgetsBinding binding)?;

/// A class that handles the initialization of the application environment,
/// error handling, theming, and other core configurations for a Flutter app.
class MainBinding extends WidgetsFlutterBinding {
  /// Constructor to initialize the [MainBinding] with optional settings.
  ///
  /// If [appSettings], [appWrapper], [env], or [observerSettings] are not provided,
  /// the class will initialize them with default values.
  MainBinding({
    this.appSettings,
    this.appWrapper,
    this.env,
    this.mainCallback,
    this.observerSettings,
  }) {
    // Builds the app and runs it.
    build().then(runApp);
  }

  /// Optional settings to customize the app's configuration.
  final AppSettings? appSettings;

  /// Optional wrapper around the app, useful for customization of the app widget.
  final AppWrapperCallback? appWrapper;

  /// The current environment (development, production, etc.).
  final EnvEnum? env;

  /// Optional callback for additional initialization logic during the main setup.
  final MainCallback mainCallback;

  /// Settings for configuring observers like Bloc and Dio.
  final ObserverSettings? observerSettings;

  /// Initializes and builds the app.
  ///
  /// This method handles the initialization of service locators, failure observers,
  /// caching assets, setting themes, and configuring error handling.
  Future<Widget> build() async {
    // Initialize optional settings if not provided.
    final AppSettings theAppSettings = appSettings ?? const AppSettings();
    final ObserverSettings theObserverSettings =
        observerSettings ?? const ObserverSettings();

    // Ensure the Flutter widget binding is initialized.
    final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();

    // Initialize the service locator with the correct environment.
    await initLocator(_env(env));

    // Set up observers for Bloc and Dio if enabled.
    if (theObserverSettings.isBlocObserverEnabled) {
      Bloc.observer = BlocTalkerObserver(
        settings: theObserverSettings.blocSettings,
        talker: $.get<Talker>(),
      );
    }

    if (theObserverSettings.isDioObserverEnabled) {
      $.get<IApiClient>().setObserver(
            DioTalkerObserver(
              settings: theObserverSettings.dioSettings,
              talker: $.get<Talker>(),
            ),
          );
    }

    // Configure error handling for Flutter and platform-specific errors.
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return ErrorPage(details: details);
    };

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);

      final UnexpectedFlutterError error = UnexpectedFlutterError(
        exception: details.exception,
        stack: details.stack,
      );

      locator<IFailureObserver>().onFailure(error);
    };

    PlatformDispatcher.instance.onError = (Object exception, StackTrace stack) {
      final UnexpectedPlatformError error =
          UnexpectedPlatformError(exception: exception, stack: stack);

      locator<IFailureObserver>().onFailure(error);

      return true;
    };

    // Initialize HydratedBloc's storage for state persistence.
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );

    // Execute additional setup logic if provided via [mainCallback].
    await mainCallback?.call(binding);

    // Retrieve the saved theme mode for Adaptive Theme.
    final AdaptiveThemeMode? savedThemeMode =
        await AdaptiveTheme.getThemeMode();

    // Cache assets like images and SVGs after the first frame is rendered.
    binding.addPostFrameCallback((_) {
      // TODO: Cache assets here.
      // final BuildContext? context = binding.rootElement;
      //
      // for (final AssetGenImage image in $.images.values) {
      //   precacheImage(AssetImage(image.path, package: 'design'), context!);
      // }

      // for (final SvgGenImage icon in $.icons.values) {
      //   final SvgAssetLoader logo = SvgAssetLoader(icon.path, packageName: 'design');
      //   svg.cache.putIfAbsent(logo.cacheKey(null), () => logo.loadBytes(null));
      // }

      // Remove the splash screen after initialization.
      FlutterNativeSplash.remove();
    });

    // Return the app wrapped in the optional [appWrapper] if provided, otherwise return the default AppWrapper.
    return appWrapper == null
        ? AppWrapper(
            appSettings: theAppSettings,
            isRouterObserverEnabled:
                theObserverSettings.isRouterObserverEnabled,
            savedThemeMode: savedThemeMode,
          )
        : appWrapper!(
            AppWrapper(
              appSettings: theAppSettings,
              isRouterObserverEnabled:
                  theObserverSettings.isRouterObserverEnabled,
              savedThemeMode: savedThemeMode,
            ),
          );
  }

  /// Determines the environment (development, production, etc.) from the [EnvEnum].
  ///
  /// The method uses environment variables to determine the current environment.
  /// If the `flavor` environment variable is set, it overrides the provided [env] parameter.
  String _env(EnvEnum? env) {
    // Determine the default environment value based on the [env] parameter.
    final String defaultValue = switch (env) {
      EnvEnum.dev => 'dev',
      EnvEnum.prod => 'prod',
      _ => 'dev',
    };

    // Use the determined default value or the environment variable 'flavor'.
    return const bool.hasEnvironment('flavor')
        ? const String.fromEnvironment('flavor')
        : defaultValue;
  }
}
