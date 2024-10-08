// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/_core/dialog/dialog_config.dart';
import 'package:infrastructure/presentation/_core/dialog/dialog_wrapper.route.dart';

/// The `DialogBuilder` class provides a static method to configure and build a
/// dialog route based on a [DialogWrapperRoute] configuration.
abstract final class DialogBuilder {
  /// Builds a dialog route using the [DialogWrapperRoute] configuration.
  ///
  /// The [context] represents the build context where the dialog will be displayed.
  /// The [child] is the widget that represents the dialog's content.
  /// The [page] is the [AutoRoutePage] containing a [DialogWrapperRoute].
  ///
  /// Throws an [ArgumentError] if the page's child is not of type [DialogWrapperRoute].
  static Route<T> route<T>(
      BuildContext context, Widget child, AutoRoutePage<dynamic> page) {
    if (page.child is! DialogWrapperRoute) {
      throw ArgumentError('Child page must be of type DialogWrapperRoute.');
    }

    final DialogWrapperRoute dialogRoute = page.child as DialogWrapperRoute;
    final DialogConfig config = dialogRoute.dialogConfig;

    return DialogRoute<T>(
      context: context,
      builder: (_) => child,
      themes: config.themes,
      barrierColor: config.barrierColor,
      barrierDismissible: config.isBarrierDismissible,
      barrierLabel: config.barrierLabel,
      useSafeArea: config.shouldUseSafeArea,
      settings: page,
      anchorPoint: config.anchorPoint,
      traversalEdgeBehavior: config.traversalEdgeBehavior,
    );
  }
}
