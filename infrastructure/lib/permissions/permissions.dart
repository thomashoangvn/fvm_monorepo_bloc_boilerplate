// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: avoid_returning_this

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/permission_handler.dart';
import 'package:flutter/widgets.dart';
import 'package:infrastructure/_core/_i18n/translations.g.dart';
import 'package:infrastructure/_core/commons/typedefs/future_void_callback.typedef.dart';
import 'package:infrastructure/permissions/_core/permission.failures.dart';
import 'package:infrastructure/permissions/_core/permission_dialogs.dart';

typedef FailureCallback = ValueChanged<Failure>;

/// A class that manages permissions by handling requests, user responses,
/// and failures related to permission requests.
///
/// This class provides methods to request permissions and to handle different
/// permission states like granted, denied, or permanently denied. The class
/// also supports callbacks for handling custom logic based on the status of
/// a permission request.
final class Permissions {
  final PermissionDialogs _permissionDialogs = const PermissionDialogs();

  /// Callback when the user denies access to the requested permission.
  FutureVoidCallback? _onDeniedCallback;

  /// Callback when the user grants access to the requested permission.
  FutureVoidCallback? _onGrantedCallback;

  /// Callback when permission is permanently denied.
  ///
  /// *On Android*:
  /// - Android 11+ (API 30+): The user denied the permission for a second time.
  /// - Below Android 11 (API 30): The user denied access and selected not to show the request again.
  ///
  /// *On iOS*:
  /// - The user denied access to the requested feature.
  FutureVoidCallback? _onPermanentlyDeniedCallback;

  /// Callback when the OS restricts access to the requested feature.
  ///
  /// *Only supported on iOS*, typically for restrictions like parental controls.
  FutureVoidCallback? _onRestrictedCallback;

  /// Callback when the user grants limited access, relevant for photo library access on iOS (iOS14+).
  FutureVoidCallback? _onLimitedCallback;

  /// Callback when the application is provisionally authorized for non-interruptive notifications.
  ///
  /// *Only supported on iOS (iOS12+)*.
  FutureVoidCallback? _onProvisionalCallback;

  /// Callback for handling failures during permission requests.
  FailureCallback? _onFailureCallback;

  /// Requests the permission specified by [permissionType], optionally handling alerts based on [shouldHandleAlerts].
  ///
  /// If a permission request results in any of the permission statuses (granted, denied, permanently denied, etc.),
  /// the appropriate callback is triggered. Alerts can be handled via permission dialogs if enabled.
  Future<void> request(
    PermissionTypeEnum permissionType, {
    bool shouldHandleAlerts = true,
  }) async {
    try {
      final Permission permission = _getPermissionFromType(permissionType);

      // Special case: For location permissions, handle request rationale.
      if (permission == Permission.locationWhenInUse ||
          permission == Permission.locationAlways ||
          permission == Permission.location) {
        await permission.shouldShowRequestRationale;
      }

      // Request the permission and handle the result based on status.
      final PermissionStatus status = await permission.request();

      switch (status) {
        case PermissionStatus.granted:
          await _onGrantedCallback?.call();

        case PermissionStatus.denied:
          await _onDeniedCallback?.call();
          if (shouldHandleAlerts) {
            await _permissionDialogs.informDenied(
              permissionType,
              onRetry: () => request(permissionType),
            );
          }

        case PermissionStatus.permanentlyDenied:
          await _onPermanentlyDeniedCallback?.call();
          if (shouldHandleAlerts) {
            await _permissionDialogs.informPermanentlyDenied(permissionType);
          }

        case PermissionStatus.restricted:
          await _onRestrictedCallback?.call();
          if (shouldHandleAlerts) {
            await _permissionDialogs.informRestricted(permissionType);
          }

        case PermissionStatus.limited:
          await _onLimitedCallback?.call();
          if (shouldHandleAlerts) {
            await _permissionDialogs.informLimited(permissionType);
          }

        case PermissionStatus.provisional:
          await _onProvisionalCallback?.call();
          if (shouldHandleAlerts) {
            await _permissionDialogs.informProvisional(permissionType);
          }
      }
    } on InvalidPermissionTypeFailure catch (exception) {
      _onFailureCallback?.call(exception);
    } on Exception catch (exception) {
      _onFailureCallback
          ?.call(UnknownPermissionRequestError(exception: exception));
      if (shouldHandleAlerts) {
        await _permissionDialogs.informProvisional(permissionType);
      }
    }
  }

  /// Sets up the permission handlers for various permission states and failures.
  /// Returns the [Permissions] object to allow method chaining.
  Permissions when({
    FutureVoidCallback? denied,
    FutureVoidCallback? granted,
    FutureVoidCallback? limited,
    FailureCallback? onFailure,
    FutureVoidCallback? permanentlyDenied,
    FutureVoidCallback? provisional,
    FutureVoidCallback? restricted,
  }) {
    _onDeniedCallback = denied;
    _onGrantedCallback = granted;
    _onPermanentlyDeniedCallback = permanentlyDenied;
    _onRestrictedCallback = restricted;
    _onLimitedCallback = limited;
    _onProvisionalCallback = provisional;
    _onFailureCallback = onFailure;

    return this;
  }

  /// Retrieves the [Permission] object corresponding to the given [permissionType].
  /// Throws [InvalidPermissionTypeFailure] if the permission type is invalid.
  Permission _getPermissionFromType(PermissionTypeEnum permissionType) {
    final String? permissionName =
        permissionType.toString().split('.').lastOrNull;

    for (final Permission permission in Permission.values) {
      if (permission.toString().split('.').lastOrNull == permissionName) {
        return permission;
      }
    }

    throw InvalidPermissionTypeFailure(type: permissionType);
  }
}
