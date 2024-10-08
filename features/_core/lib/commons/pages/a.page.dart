// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:flutter/cupertino.dart';

/// A simple page represented by [APage] which serves as a placeholder.
///
/// This page is built using [CupertinoPageScaffold] and showcases the use of a Cupertino style
/// navigation bar. The page displays a `Placeholder` widget and a text label in the navigation bar.
///
// TODO: These page should be deleted and created as feature.
@RoutePage()
class APage extends StatelessWidget {
  const APage({super.key});

  /// Builds the UI for the page.
  ///
  /// The method returns a [CupertinoPageScaffold] with a navigation bar and a placeholder
  /// widget as the page's content.
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // Sets the title of the page using a custom text style from the theme.
        middle: 'Home'.text(style: $.theme.fonts.h1),
        // Disables transition between routes for the navigation bar.
        transitionBetweenRoutes: false,
      ),
      // Displays a simple placeholder as the body of the page.
      child: const Placeholder(),
    );
  }
}
