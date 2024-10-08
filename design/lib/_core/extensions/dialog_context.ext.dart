// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:flutter/material.dart';

/// Extension on `DialogContext` to provide additional convenience methods for displaying dialogs, modals, and sheets.
///
/// This extension provides simplified methods to push dialogs, modals, and bottom sheets within a Flutter application,
/// with customizable dismissibility options.
extension DialogContextExt on DialogContext {
  /// Shows a custom dialog in the current context.
  ///
  /// - `dialog`: The widget to be shown as the dialog.
  /// - `isDismissible`: Specifies whether the dialog can be dismissed by tapping outside of it. Default is `false`.
  ///
  /// Returns a `Future<T?>` that completes when the dialog is dismissed.
  Future<T?> showDialog<T>(Widget dialog, {bool isDismissible = false}) async {
    return $.dialog.pushDialog(
      builder: (_) => dialog,
      config: DialogConfig(isBarrierDismissible: isDismissible),
    );
  }

  /// Shows a modal dialog in the current context.
  ///
  /// - `modal`: The widget to be shown as the modal.
  ///
  /// Returns a `Future<T?>` that completes when the modal is dismissed.
  Future<T?> showModal<T>(Widget modal) async {
    return $.dialog.pushModal(
      builder: (_) => modal,
    );
  }

  /// Displays a bottom sheet in the current context.
  ///
  /// - `sheet`: The widget to be shown as the bottom sheet.
  /// - `isDismissible`: Specifies whether the sheet can be dismissed by dragging it down. Default is `false`.
  ///
  /// Does not return a value as sheets generally remain open until explicitly dismissed.
  void showSheet<T>(Widget sheet, {bool isDismissible = false}) {
    $.dialog.pushSheet(
      builder: (_) => sheet,
      config: SheetConfig(shouldEnableDrag: isDismissible),
    );
  }
}
