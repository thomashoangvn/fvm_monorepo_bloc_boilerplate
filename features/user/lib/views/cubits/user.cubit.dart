// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: always_specify_types

import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/fpdart.dart';
import 'package:deps/packages/freezed_annotation.dart';
import 'package:deps/packages/hydrated_bloc.dart';
import 'package:deps/packages/injectable.dart';
import 'package:feature_user/services/user.service.dart';
import 'package:flutter/material.dart';

part 'states/user.state.dart';
part 'user.cubit.freezed.dart';
part 'user.cubit.g.dart';

/// The `UserCubit` class is responsible for managing the state related to the user within the application.
/// It uses `HydratedCubit` to persist user state between app sessions and interacts with the `UserService`
/// to fetch user data when necessary.
///
/// This cubit holds information about the authenticated user and manages their navigation tabs.
/// It also handles initialization and deinitialization of the user's session.
@lazySingleton
class UserCubit extends HydratedCubit<UserState> {
  /// Constructor to initialize the `UserCubit` with the required `UserService`.
  UserCubit(this._service) : super(UserState.initial());

  /// The service used for fetching user-related data.
  final UserService _service;

  /// Restores the user's state from a JSON object.
  ///
  /// If an error occurs during deserialization, the user is logged out and the initial state is restored.
  @override
  UserState fromJson(Map<String, dynamic> json) {
    try {
      return UserState.fromJson(json);
    } catch (e) {
      $.get<AuthCubit>().logout(useBackend: false);
      return UserState.initial();
    }
  }

  /// Serializes the current user state to a JSON object, omitting any failures.
  @override
  Map<String, dynamic> toJson(UserState state) {
    return state.copyWith(failure: Failure.empty()).toJson();
  }

  /// Retrieves the navigation tabs available to the authenticated user.
  ///
  /// This method can be customized to filter out certain tabs based on the user's permissions.
  List<NavigationTabsEnum> get getAuthenticatedNavigationTabs {
    // TODO: Users authorized pages can be filtered here.
    final List<NavigationTabsEnum> tabs = <NavigationTabsEnum>[
      ...NavigationTabsEnum.values
    ];
    return tabs;
  }

  /// Initializes the user session by showing a loading overlay and fetching user details.
  ///
  /// This method is typically called after the user has been authenticated.
  Future<void> init() async {
    await $.overlay.showLoading();
    emit(state.copyWith(status: UserStateStatus.loading));

    // TODO: This section has been added as an example in case there is additional information that needs to be pulled after the user is authorized. Otherwise, if the user information is fetched during the authorization phase, only saving the user to the state is enough and the routing can be completed without the need for an additional step.
    getUserDetails().ignore();
  }

  /// Deinitializes the user session and redirects to the authentication page.
  Future<void> deinit() async {
    emit(UserState.initial());
    await $.navigator.replace(const AuthRoute());
  }

  /// Fetches the authenticated user's details and updates the cubit's state.
  ///
  /// If an error occurs, it shows a dialog with the failure message. Upon success, it navigates to the dashboard.
  Future<void> getUserDetails() async {
    emit(state.copyWith(status: UserStateStatus.fetchingUserDetails));

    // Mocking the response for demonstration. Replace with actual service call.
    const Either<Failure, UserModel> response = Right(
      UserModel(
        id: '0',
        username: 'test',
        firstName: 'Fikret',
      ),
    ); // await _service.getUserDetails();

    await response.fold(
      (Failure failure) {
        // Show dialog with the failure message if fetching user details fails.
        $.dialog.showDialog(
          Dialog(
              insetPadding: $.paddings.xl.all, child: failure.message.text()),
        );
        emit(state.copyWith(isFailed: true, failure: failure));
      },
      (UserModel user) async {
        // Upon successful fetching of user details, navigate to the dashboard.
        emit(state.copyWith(status: UserStateStatus.authenticated, user: user));
        await $.navigator.replace(const DashboardRouter());
      },
    );
  }
}
