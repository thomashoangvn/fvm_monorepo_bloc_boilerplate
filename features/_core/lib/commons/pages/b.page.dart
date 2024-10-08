// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/design/design.dart';
import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:feature_auth/views/cubits/auth.cubit.dart';
import 'package:flutter/cupertino.dart';

/// A basic settings page represented by [BPage].
///
/// This page contains a Cupertino-style UI with a logout button that triggers
/// the logout functionality of the application. It is currently used as a placeholder
/// and should be refactored as part of a feature module.
///
// TODO: These page should be deleted and created as feature.
@RoutePage()
class BPage extends StatelessWidget {
  const BPage({super.key});

  /// Builds the UI for the settings page.
  ///
  /// The method returns a [CupertinoPageScaffold] with a navigation bar and a centered
  /// logout button that logs the user out when pressed.
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // Sets the title of the page using a custom text style from the theme.
        middle: 'Settings'.text(style: $.theme.fonts.h1),
        // Disables transition between routes for the navigation bar.
        transitionBetweenRoutes: false,
      ),
      // Displays a logout button in the center of the page.
      child: Center(
        child: CupertinoButton(
          // Styles the button's background and text color using the theme.
          color: $.theme.colors.blue,
          // The button's label is styled with the theme's h2 font and white text color.
          child: 'Logout'.styled(style: $.theme.fonts.h2.white),
          // Logs out the user when the button is pressed.
          onPressed: () => $.get<AuthCubit>().logout(useBackend: false),
        ),
      ),
    );
  }
}
