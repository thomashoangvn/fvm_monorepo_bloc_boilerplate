// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/_core/modal/modal_config.dart';

/// A stateless widget that wraps a modal configuration and content.
/// This is the actual modal route that is passed into the `ModalBuilder`
/// for display.
@RoutePage()
class ModalWrapperRoute extends StatelessWidget {
  const ModalWrapperRoute({
    required this.builder,
    this.modalConfig = const ModalConfig(),
    super.key,
  });

  /// Builds the widget (modal content) when this route is pushed.
  @override
  Widget build(BuildContext context) {
    return builder(context);
  }

  /// The builder that provides the modal content.
  final Widget Function(BuildContext context) builder;

  /// Configuration settings for the modal (such as barrier color, dismissibility, etc.).
  final ModalConfig modalConfig;
}
