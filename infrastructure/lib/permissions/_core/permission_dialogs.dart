// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:async';

import 'package:deps/packages/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/_core/_i18n/infrastructure_i18n_cubit_locale.ext.dart';
import 'package:infrastructure/_core/_i18n/translations.g.dart';
import 'package:infrastructure/_core/commons/typedefs/future_void_callback.typedef.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// A class responsible for showing dialogs related to permission handling.
///
/// It provides informative dialogs for different permission states such as
/// denied, permanently denied, restricted, limited, and provisional permissions.
/// These dialogs are designed to inform users about the permission request status
/// and guide them on next actions like retrying, opening settings, or simply
/// acknowledging the permission status.
@immutable
final class PermissionDialogs {
  const PermissionDialogs();

  /// Displays a dialog informing the user that a permission request was denied.
  /// The dialog offers two actions: retrying the permission request or cancelling the request.
  ///
  /// - [permissionType]: The type of permission that was denied.
  /// - [onRetry]: A callback function to retry the permission request.
  Future<void> informDenied(
    PermissionTypeEnum permissionType, {
    required FutureVoidCallback onRetry,
  }) async {
    await $.dialog.pushDialog(
      builder: (_) => AlertDialog(
        title: Text(
          $.tr.infrastructure.permissions.dialog.denied
              .title(context: permissionType),
        ),
        content: Text(
          $.tr.infrastructure.permissions.dialog.denied
              .description(context: permissionType),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              $.dialog.popDialog();
              unawaited(onRetry());
            },
            child: Text($.tr.infrastructure.permissions.dialog.buttons.retry),
          ),
          TextButton(
            onPressed: $.dialog.popDialog,
            child: Text($.tr.infrastructure.permissions.dialog.buttons.cancel),
          ),
        ],
      ),
    );
  }

  /// Displays a dialog informing the user that a permission is permanently denied.
  /// The dialog guides the user to open the app settings to manually enable the permission.
  ///
  /// - [permissionType]: The type of permission that is permanently denied.
  Future<void> informPermanentlyDenied(
      PermissionTypeEnum permissionType) async {
    await $.dialog.pushDialog(
      builder: (_) => AlertDialog(
        title: Text(
          $.tr.infrastructure.permissions.dialog.permanentlyDenied
              .title(context: permissionType),
        ),
        content: Text(
          $.tr.infrastructure.permissions.dialog.permanentlyDenied
              .description(context: permissionType),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              $.dialog.popDialog();
              unawaited(openAppSettings());
            },
            child: Text(
                $.tr.infrastructure.permissions.dialog.buttons.openSettings),
          ),
          TextButton(
            onPressed: $.dialog.popDialog,
            child: Text($.tr.infrastructure.permissions.dialog.buttons.cancel),
          ),
        ],
      ),
    );
  }

  /// Displays a dialog informing the user that the requested permission is restricted.
  /// This generally occurs when parental controls or similar restrictions are in place.
  ///
  /// - [permissionType]: The type of permission that is restricted.
  Future<void> informRestricted(PermissionTypeEnum permissionType) async {
    await $.dialog.pushDialog(
      builder: (_) => AlertDialog(
        title: Text(
          $.tr.infrastructure.permissions.dialog.restricted
              .title(context: permissionType),
        ),
        content: Text(
          $.tr.infrastructure.permissions.dialog.restricted
              .description(context: permissionType),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: $.dialog.popDialog,
            child:
                Text($.tr.infrastructure.permissions.dialog.buttons.understood),
          ),
        ],
      ),
    );
  }

  /// Displays a dialog informing the user that limited permission access is granted.
  /// It encourages the user to open the app settings to allow full access.
  ///
  /// - [permissionType]: The type of permission that is limited.
  Future<void> informLimited(PermissionTypeEnum permissionType) async {
    await $.dialog.pushDialog(
      builder: (_) => AlertDialog(
        title: Text(
          $.tr.infrastructure.permissions.dialog.limited
              .title(context: permissionType),
        ),
        content: Text(
          $.tr.infrastructure.permissions.dialog.limited
              .description(context: permissionType),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              $.dialog.popDialog();
              unawaited(openAppSettings());
            },
            child: Text(
                $.tr.infrastructure.permissions.dialog.buttons.openSettings),
          ),
          TextButton(
            onPressed: $.dialog.popDialog,
            child: Text($.tr.infrastructure.permissions.dialog.buttons.ok),
          ),
        ],
      ),
    );
  }

  /// Displays a dialog informing the user that the permission is granted provisionally.
  ///
  /// This typically occurs for non-interruptive notifications on iOS (iOS12+).
  ///
  /// - [permissionType]: The type of permission granted provisionally.
  Future<void> informProvisional(PermissionTypeEnum permissionType) async {
    await $.dialog.pushDialog(
      builder: (_) => AlertDialog(
        title: Text(
          $.tr.infrastructure.permissions.dialog.provisional
              .title(context: permissionType),
        ),
        content: Text(
            $.tr.infrastructure.permissions.dialog.provisional.description),
        actions: <Widget>[
          TextButton(
            onPressed: $.dialog.popDialog,
            child: Text($.tr.infrastructure.permissions.dialog.buttons.ok),
          ),
        ],
      ),
    );
  }
}
