// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/_core/modal/modal_config.dart';
import 'package:infrastructure/presentation/_core/modal/modal_wrapper.route.dart';

/// The `ModalBuilder` class provides a static method to configure and build a
/// modal route based on a [ModalWrapperRoute] configuration.
abstract final class ModalBuilder {
  /// Builds a modal route using the [ModalWrapperRoute] configuration.
  ///
  /// The [context] represents the build context where the modal will be displayed.
  /// The [child] is the widget that represents the modal's content.
  /// The [page] is the [AutoRoutePage] containing a [ModalWrapperRoute].
  ///
  /// Throws an [ArgumentError] if the page's child is not of type [ModalWrapperRoute].
  static Route<T> route<T>(
      BuildContext context, Widget child, AutoRoutePage<T> page) {
    if (page.child is! ModalWrapperRoute) {
      throw ArgumentError(
          'Child page must be of type ModalWrapperRoute to use cupertinoModalRouteBuilder.');
    }

    final ModalWrapperRoute dialogWrapperRoute =
        page.child as ModalWrapperRoute;
    final ModalConfig config = dialogWrapperRoute.modalConfig;

    return ModalBottomSheetRoute<T>(
      isScrollControlled: config.isScrollControlled,
      settings: page,
      builder: (_) => child,
      barrierLabel: config.barrierLabel,
    );
  }
}
