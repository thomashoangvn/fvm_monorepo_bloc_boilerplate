// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-correct-type-names, always_specify_types

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/hydrated_bloc.dart';
import 'package:design/_core/_constants/themes.dart';
import 'package:design_widgetbook/components.book.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart' hide ThemeMode;

/// The `main` function initializes the Flutter application and sets up services and storage.
///
/// This function:
/// - Ensures that the widget binding is initialized.
/// - Caches assets for optimization (currently commented out for future implementation).
/// - Initializes the service locator for dependency injection with the 'dev' environment.
/// - Sets up persistent storage using `HydratedBloc`.
/// - Runs the application wrapped with `BlocProvider` to manage the app's localization state.
void main() async {
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized()
    ..addPostFrameCallback((_) {
      // TODO: Cache assets here.
      // final BuildContext? context = binding.rootElement;
      // for (final AssetGenImage image in $.images.values) {
      //   precacheImage(AssetImage(image.path, package: 'design'), context!);
      // }
      // for (final SvgGenImage icon in $.icons.values) {
      //   final SvgAssetLoader logo = SvgAssetLoader(icon.path, packageName: 'design');
      //   svg.cache.putIfAbsent(logo.cacheKey(null), () => logo.loadBytes(null));
      // }
    });

  await initLocator('prod');

  // Set up persistent storage for HydratedBloc, using web storage in this case.
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorage.webStorageDirectory,
  );

  // Run the Flutter app with a `BlocProvider` to manage translations.
  runApp(
    BlocProvider<TranslationsCubit>(
      create: (BuildContext context) => $.get<TranslationsCubit>(),
      child: const WidgetbookApp(),
    ),
  );
}

/// The `WidgetbookApp` class is a stateless widget that configures the `Widgetbook` package for the app.
///
/// It defines the app's theme, the list of components for design review, and the device frames for
/// previewing the UI across different devices.
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      components: components,
      appBuilder: (_, Widget child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: $.navigator.navigatorKey,
          theme: Themes.light,
          themeMode: ThemeMode.light,
          home: child,
        );
      },
      addons: <Addon<dynamic>>[
        DeviceFrameAddon(
          <DeviceInfo>[
            Devices.android.samsungGalaxyA50,
            Devices.android.samsungGalaxyS20,
            Devices.ios.iPhoneSE,
            Devices.ios.iPhone13ProMax,
          ],
        ),
        GridAddon(100),
        InspectorAddon(),
        AlignmentAddon(),
      ],
    );
  }
}
