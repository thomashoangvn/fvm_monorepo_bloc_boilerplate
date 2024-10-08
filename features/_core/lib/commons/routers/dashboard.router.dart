// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: always_specify_types

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:feature_user/views/cubits/user.cubit.dart';
import 'package:flutter/cupertino.dart';

/// [DashboardRouter] is the main entry point for a tabbed navigation UI using `AutoRoute`.
///
/// This widget builds an [AutoTabsScaffold] that contains the navigation structure
/// for the authenticated user. The tabs are dynamically generated based on the user's
/// authentication status and are retrieved from the `UserCubit`.
///
/// The [CupertinoTabBar] is used as the bottom navigation bar to switch between
/// different tabs. The tab structure can be adjusted based on the routes returned
/// by the [UserCubit].
@RoutePage()
class DashboardRouter extends StatefulWidget {
  const DashboardRouter({super.key});

  @override
  State<DashboardRouter> createState() => _DashboardRouterState();
}

/// The state for the [DashboardRouter] widget.
///
/// This class manages the state of the tabbed navigation structure, including
/// the setup of a [HeroController] for smooth page transitions.
class _DashboardRouterState extends State<DashboardRouter> {
  final HeroController _heroController = HeroController();

  /// Builds the main UI structure using [AutoTabsScaffold].
  ///
  /// The tabs are populated dynamically based on the authenticated user's
  /// available navigation tabs, which are fetched from the `UserCubit`.
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      // Retrieves the list of navigation tabs available for the authenticated user.
      routes: $
          .get<UserCubit>()
          .getAuthenticatedNavigationTabs
          .map((tab) => tab.screen)
          .toList(),
      // Defines the bottom navigation bar using a CupertinoTabBar.
      bottomNavigationBuilder: (_, TabsRouter tabsRouter) {
        return BlocBuilder<TranslationsCubit, Locale>(
          builder: (_, __) {
            return CupertinoTabBar(
              currentIndex: tabsRouter.activeIndex,
              // Changes the active tab when a user taps on a navigation item.
              onTap: tabsRouter.setActiveIndex,
              // Maps the available tabs into navigation items.
              items:
                  $.get<UserCubit>().getAuthenticatedNavigationTabs.map((tab) {
                return BottomNavigationBarItem(
                  icon: Icon(tab.icon),
                  label: tab.label,
                );
              }).toList(),
            );
          },
        );
      },
      // Sets up navigation observers, including the [HeroController].
      navigatorObservers: () => <NavigatorObserver>[_heroController],
    );
  }

  /// Disposes of resources such as the [HeroController] when the widget is removed from the tree.
  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }
}
