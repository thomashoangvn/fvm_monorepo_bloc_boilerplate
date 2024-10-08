// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infrastructure/_core/_router/router.gr.dart';
import 'package:infrastructure/presentation/_core/dialog/dialog_config.dart';
import 'package:infrastructure/presentation/_core/modal/modal_config.dart';
import 'package:infrastructure/presentation/_core/sheet/sheet_config.dart';
import 'package:infrastructure/presentation/_core/sheet/sheet_wrapper.route.dart';
import 'package:infrastructure/presentation/contexts/navigator_context.dart';
import 'package:infrastructure/presentation/contexts/overlay_context.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// [DialogContext] handles the display and management of dialogs, modals, and
/// bottom sheets in the application. It integrates with the app's navigation
/// context and provides an overlay to handle pop-ups and dialogs.
///
/// This class allows showing various types of dialogs, modals, and bottom
/// sheets while ensuring proper dialog state management by tracking currently
/// visible dialogs and removing them when dismissed.
///
/// ### Usage:
/// ```dart
/// $.dialog.pushDialog(builder: (_) => MyDialogWidget());
/// ```
///
/// It also includes utility methods for popping and forcefully removing dialogs,
/// as well as automatically hiding overlays when needed.

@immutable
final class DialogContext {
  /// Constructs a [DialogContext] with the given [NavigatorContext] and [OverlayContext].
  DialogContext();

  /// Tracks currently visible dialogs.
  final ValueNotifier<List<Widget>> _dialogs =
      ValueNotifier<List<Widget>>(<Widget>[]);

  /// Retrieves the current [BuildContext] from the scaffold key in the navigator.
  BuildContext? get _scaffoldContext => $.navigator.scaffoldKey.currentContext;

  /// Retrieves the current [ScaffoldState] from the scaffold key in the navigator.
  ScaffoldState? get _scaffoldState => $.navigator.scaffoldKey.currentState;

  /// Returns `true` if any dialog is currently visible.
  bool get hasDialogVisible => _dialogs.value.isNotEmpty;

  /// Adds the given [widget] to the visible dialogs list.
  void _addDialogVisible(Widget widget) {
    _dialogs.value.add(widget);
  }

  /// Removes the specified [widget] from the visible dialogs list.
  /// If no widget is provided, it removes the last visible dialog.
  void _removeDialogVisible({Widget? widget}) {
    if (widget == null) {
      _dialogs.value.removeLast();
    } else {
      _dialogs.value.remove(widget);
    }
  }

  /// Pops all visible dialogs and clears the dialog registry.
  void popAllDialogs() {
    for (final Widget _ in _dialogs.value) {
      popDialog();
    }
    _resetDialogRegisters();
  }

  /// Pops the top-most dialog if any are visible.
  Future<void> popDialog<T extends Object>([T? result]) async {
    if (hasDialogVisible) {
      await $.navigator.pop<T>(result);
    }
  }

  /// Forcefully pops the top-most dialog.
  Future<void> popDialogForced<T extends Object>([T? result]) async {
    if (hasDialogVisible) {
      await $.navigator.popForced<T>(result);
    }
  }

  /// Clears the dialog register.
  void _resetDialogRegisters() {
    _dialogs.value.clear();
  }

  /// Pushes a new dialog with the provided [builder] and [config].
  /// Optionally, hides the overlay before showing the dialog.
  Future<T?> pushDialog<T>({
    required WidgetBuilder builder,
    DialogConfig config = const DialogConfig(),
    bool shouldAutoDismissOverlay = false,
  }) async {
    final BuildContext context = await $.navigator.ensuredContext;

    if (shouldAutoDismissOverlay) {
      await $.overlay.popOverlay();
    }

    await popDialog();

    if (context.mounted) {
      final Widget dialog = builder(context);
      _addDialogVisible(dialog);

      return $.navigator
          .push<T>(
            DialogWrapperRoute(builder: (_) => dialog, dialogConfig: config),
          )
          .whenComplete(() => _removeDialogVisible(widget: dialog));
    }

    return null;
  }

  /// Pushes a new modal with the provided [builder] and [config].
  /// Optionally, hides the overlay before showing the modal.
  Future<T?> pushModal<T>({
    required WidgetBuilder builder,
    ModalConfig config = const ModalConfig(),
    bool shouldAutoDismissOverlay = true,
  }) async {
    final BuildContext context = await $.navigator.ensuredContext;

    if (shouldAutoDismissOverlay) {
      await $.overlay.popOverlay();
    }

    if (context.mounted) {
      final Widget dialog = builder(context);
      _addDialogVisible(dialog);

      return $.navigator
          .push<T>(
            ModalWrapperRoute(builder: (_) => dialog, modalConfig: config),
          )
          .whenComplete(() => _removeDialogVisible(widget: dialog));
    }

    return null;
  }

  /// Pushes a new bottom sheet with the provided [builder] and [config].
  Future<void> pushSheet({
    required WidgetBuilder builder,
    SheetConfig config = const SheetConfig(),
  }) async {
    if (!(_scaffoldContext?.mounted ?? true)) {
      return;
    }

    final Widget dialog = builder(_scaffoldContext!);
    _addDialogVisible(dialog);

    final PersistentBottomSheetController bottomSheetController =
        _scaffoldState!.showBottomSheet(
      (_) => SheetWrapperRoute(builder: (_) => dialog),
      backgroundColor: config.backgroundColor,
      elevation: config.elevation,
      shape: config.shape,
      clipBehavior: config.clipBehavior,
      constraints: config.constraints,
      enableDrag: config.shouldEnableDrag,
      transitionAnimationController: config.transitionAnimationController,
    );

    await bottomSheetController.closed;
    _removeDialogVisible(widget: dialog);
  }
}
