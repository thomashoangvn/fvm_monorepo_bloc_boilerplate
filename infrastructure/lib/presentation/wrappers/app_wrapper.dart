// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: max_lines_for_function, avoid-dynamic

import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/adaptive_theme.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/talker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:infrastructure/_core/_i18n/translations.g.dart';
import 'package:infrastructure/_core/commons/converters/bloc_to_listenable.converter.dart';
import 'package:infrastructure/presentation/wrappers/_core/app_settings.dart';

/// The [AppWrapper] widget is responsible for setting up the entire
/// application structure including theme, routing, and connectivity
/// management. It integrates various Bloc and Cubit providers to manage
/// global state across the app.
class AppWrapper extends StatelessWidget {
  /// Constructs the [AppWrapper] widget.
  ///
  /// [appSettings] contains the core settings for the application such as
  /// performance overlays and debug flags. [isRouterObserverEnabled] determines
  /// whether navigation observers should be enabled. [savedThemeMode] is used to
  /// restore the user's theme preferences.
  const AppWrapper({
    required this.appSettings,
    required this.isRouterObserverEnabled,
    this.savedThemeMode,
    super.key,
  });

  /// The settings for the application including debug settings and title.
  final AppSettings appSettings;

  /// Flag to enable or disable router observers, used to monitor navigation events.
  final bool isRouterObserverEnabled;

  /// The saved theme mode that will be applied when the app starts.
  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        // Provides the [ConnectivityCubit] for monitoring network connectivity.
        BlocProvider<ConnectivityCubit>(
            create: (_) => $.get<ConnectivityCubit>()),

        // Provides the [TranslationsCubit] for handling localization state.
        BlocProvider<TranslationsCubit>(
            create: (_) => $.get<TranslationsCubit>()),
      ],
      child: BlocListener<ConnectivityCubit, ConnectivityStatusEnum>(
        // Handles changes in network connectivity status.
        listener: _handleConnectivityStatusChange,
        child: BlocBuilder<TranslationsCubit, Locale>(
          // Rebuilds the app when the locale changes.
          builder: (_, Locale locale) {
            return AdaptiveTheme(
              light: Themes.light,
              dark: Themes.light,
              initial: savedThemeMode ?? AdaptiveThemeMode.light,
              builder: (ThemeData light, ThemeData dark) {
                return MaterialApp.router(
                  routerConfig: $.get<FeaturesRouter>().config(
                        // Converts AuthCubit stream into a listenable for router reevaluation.
                        reevaluateListenable:
                            BlocToListenableConverter<AuthStatusEnum>(
                                $.get<AuthCubit>().stream),
                        navigatorObservers: () => isRouterObserverEnabled
                            ? <NavigatorObserver>[
                                RouterTalkerObserver(talker: $.get<Talker>()),
                                HeroController(),
                              ]
                            : <NavigatorObserver>[],
                      ),
                  builder: (BuildContext ctx, Widget? child) {
                    return MediaQuery.withNoTextScaling(
                      child: child ?? const SizedBox(),
                    );
                  },
                  title: appSettings.title,
                  theme: light,
                  darkTheme: dark,
                  locale: locale,
                  localizationsDelegates: GlobalMaterialLocalizations.delegates,
                  supportedLocales: AppLocaleUtils.supportedLocales,
                  debugShowMaterialGrid: appSettings.debugShowMaterialGrid,
                  showPerformanceOverlay: appSettings.showPerformanceOverlay,
                  checkerboardRasterCacheImages:
                      appSettings.checkerboardRasterCacheImages,
                  checkerboardOffscreenLayers:
                      appSettings.checkerboardOffscreenLayers,
                  showSemanticsDebugger: appSettings.showSemanticsDebugger,
                  debugShowCheckedModeBanner:
                      appSettings.debugShowCheckedModeBanner,
                );
              },
            );
          },
        ),
      ),
    );
  }

  /// Handles changes in the network connectivity status.
  ///
  /// Depending on the [ConnectivityStatusEnum], dialogs or other UI
  /// can be updated to reflect connectivity state.
  ///
  /// Currently, the method is set to handle different states with comments
  /// for adding more functionality in the future.
  void _handleConnectivityStatusChange(_, ConnectivityStatusEnum state) {
    switch (state) {
/*       case ConnectivityStatusEnum.connected:
        $.dialog.popDialog(); // Example of handling connected state.

      case ConnectivityStatusEnum.disconnected:
        unawaited(
          $.dialog.showSheet(
            builder: (_) => const SizedBox(
              height: 50,
              child: Center(child: Text('Connected')), // Example of showing a sheet.
            ),
          ),
        );
 */
      default:
        break;
    }
  }
}
