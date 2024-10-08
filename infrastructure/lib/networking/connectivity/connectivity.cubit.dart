// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:async';

import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/injectable.dart';
import 'package:deps/packages/internet_connection_checker_plus.dart';
import 'package:infrastructure/_core/commons/enums/connectivity_status.enum.dart';

/// [ConnectivityCubit] manages the network connectivity status of the application.
///
/// It uses [InternetConnectionCheckerPlus] to check if the device has an active
/// internet connection and emits the corresponding [ConnectivityStatusEnum] to notify
/// listeners of the network status.
@lazySingleton
class ConnectivityCubit extends Cubit<ConnectivityStatusEnum> {
  /// Creates a [ConnectivityCubit] with the given [InternetConnection] service.
  ///
  /// It initializes the network check by calling [checkNetwork] on instantiation.
  ConnectivityCubit(this._internetConnection)
      : super(ConnectivityStatusEnum.initial) {
    unawaited(checkNetwork());
  }

  /// The [InternetConnection] service to check network access.
  final InternetConnection _internetConnection;

  /// Checks the network status and emits the appropriate [ConnectivityStatusEnum].
  ///
  /// This method checks whether the device has internet access and updates the cubit state
  /// by emitting [ConnectivityStatusEnum.connected] if the internet is available, or
  /// [ConnectivityStatusEnum.disconnected] otherwise.
  Future<void> checkNetwork() async {
    if (await _internetConnection.hasInternetAccess) {
      emit(ConnectivityStatusEnum.connected);
    } else {
      emit(ConnectivityStatusEnum.disconnected);
    }
  }
}
